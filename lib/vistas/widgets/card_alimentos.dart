import 'package:flutter/material.dart';

class CardAlimento extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isDelivered;
  final VoidCallback onTap;

  const CardAlimento({
    super.key,
    required this.title,
    required this.icon,
    required this.isDelivered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Card(
            elevation: 5,
            color: Colors.white70,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 40, color: Colors.deepPurple),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          if (!isDelivered)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: Colors.red.withOpacity(0.5),
                child: const Center(
                  child: Icon(Icons.close, size: 60, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}