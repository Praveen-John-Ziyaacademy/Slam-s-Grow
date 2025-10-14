import 'package:flutter/material.dart';
import 'package:social_media/colors/fonts.dart';

class ReferralPage extends StatelessWidget {
  const ReferralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people, size: 80, color: Color(0xFF2070FF)),
          SizedBox(height: 20),
          Text(
            'Referral Page',
            style: AppFonts.primaryFont(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Invite friends and earn rewards',
            style: AppFonts.primaryFont(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
