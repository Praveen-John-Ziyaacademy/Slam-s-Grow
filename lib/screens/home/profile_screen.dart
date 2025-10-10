import 'package:flutter/material.dart';
import 'package:social_media/colors/fonts.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 80, color: Color(0xFF2070FF)),
          SizedBox(height: 20),
          Text(
            'Profile Page',
            style: AppFonts.primaryFont(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Manage your account settings',
            style: AppFonts.primaryFont(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
