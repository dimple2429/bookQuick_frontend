
import 'package:book_quick/features/dashbaord/service_detail_screen.dart';
import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../../utils/app_images.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List services = [];

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  void fetchServices() async {
    final data = await ApiService.getServices();
    setState(() {
      services = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Services")),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (_, i) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ServiceDetailScreen(
                    service: services[i],
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(18)),
                      child: Image.asset(
                        AppImages.getServiceImage(services[i]['name']),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              services[i]['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              "Professional service for your needs",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                            ),

                            SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "₹${services[i]['price']}",
                                  style: TextStyle(
                                    color: Color(0xFF5FABBD),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Icon(Icons.arrow_forward_ios, size: 14)
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

