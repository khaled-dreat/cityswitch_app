import 'package:flutter/material.dart';

class BuildSectionTitle extends StatelessWidget {
  const BuildSectionTitle({super.key, required this.title, required this.icon});
  final String title;

  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.blue.shade600, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
            fontFamily: 'Arial Unicode MS',
          ),
        ),
      ],
    );
  }
}
