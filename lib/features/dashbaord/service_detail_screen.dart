import 'package:flutter/material.dart';

import '../../utils/app_images.dart';
import '../booking/booking.dart';

class ServiceDetailScreen extends StatelessWidget {
  final Map service;

  const ServiceDetailScreen({required this.service});

  String getImage(String serviceName) {
    if (serviceName.toLowerCase().contains("cleaning")) {
      return "assets/cleaning.jpg";
    } else if (serviceName.toLowerCase().contains("plumbing")) {
      return "assets/plumber.jpg";
    } else {
      return "assets/salon.jpg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                  child: Image.asset(
                    AppImages.getServiceImage(service['name']),

                    height: 350,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          service['name'],
                          style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),

                        Positioned(
                          top: 40,
                          right: 16,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Color(0xFF5FABBD),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "₹${service['price']}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Professional service including high quality work and customer satisfaction.",
                      style: TextStyle(color: Colors.grey[600]),
                    ),

                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        infoCard(Icons.schedule, "Flexible"),
                        infoCard(Icons.security, "Insured"),
                      ],
                    ),

                    Spacer(),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF5FABBD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookingScreen(service: service),
                            ),
                          );
                        },
                        child: Text("Book Now", style: TextStyle(
                          color: Colors.white
                        ),),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget infoCard(IconData icon, String text) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF5FABBD)),
          SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}