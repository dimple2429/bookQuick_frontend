import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../dashbaord/dashboard.dart';

class BookingScreen extends StatefulWidget {
  final Map service;

  const BookingScreen({required this.service});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final nameController = TextEditingController();

  String selectedSlot = "Morning";
  DateTime? selectedDate;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    nameController.addListener(() {
      setState(() {});
    });
  }

  bool isFormValid() {
    return nameController.text.trim().isNotEmpty && selectedDate != null;
  }

  void pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void book() async {
    if (!isFormValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final res = await ApiService.bookService({
      "name": nameController.text,
      "service": widget.service['name'],
      "slot": selectedSlot,
      "date": selectedDate.toString(),
    });

    setState(() {
      isLoading = false;
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text("Booking Confirmed!"),
        content: Text(res['message']),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => DashboardScreen()),
                    (route) => false,
              );
            },
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complete Booking")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
              ),
              child: Row(
                children: [
                  Icon(Icons.home_repair_service, color: Color(0xFF5FABBD)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.service['name'],
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Text(
                    "₹${widget.service['price']}",
                    style: TextStyle(
                      color: Color(0xFF5FABBD),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter your name",
                prefixIcon: Icon(Icons.person),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 20),

            GestureDetector(
              onTap: pickDate,
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 10),
                    Text(
                      selectedDate == null
                          ? "Select Date"
                          : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Time Slot",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ["Morning", "Afternoon", "Evening"].map((slot) {
                final isSelected = selectedSlot == slot;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSlot = slot;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Color(0xFF5FABBD)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          slot,
                          style: TextStyle(
                            color:
                            isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isFormValid() && !isLoading ? book : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5FABBD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                  "Confirm Booking",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}