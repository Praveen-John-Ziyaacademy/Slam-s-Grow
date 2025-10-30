import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:social_media/controller/home_screen_controller.dart';
import 'package:social_media/screens/home/home_screen.dart';
import 'package:social_media/screens/more/settings_screen.dart';
import 'package:social_media/screens/home/referral_screen.dart';
import 'package:social_media/screens/home/task_screen.dart';
import 'package:social_media/screens/home/wallet_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  final List<Widget> _pages = [
    HomeTabContent(),
    TaskPage(),
    ReferralPage(),
    WalletPage(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedIndex.value == 0) {
          bool shouldExit = await _showExitDialog(context);
          return shouldExit;
        } else {
          controller.selectedIndex.value = 0;
          return false;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: Obx(() => _pages[controller.selectedIndex.value]),
        bottomNavigationBar: Obx(
          () => Container(
            decoration: BoxDecoration(color: Colors.white),
            child: BottomNavigationBar(
              currentIndex: controller.selectedIndex.value,
              onTap: (index) {
                controller.selectedIndex.value = index;
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: const Color(0xFF2070FF),
              unselectedItemColor: Colors.grey,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.task_outlined),
                  activeIcon: Icon(Icons.task),
                  label: 'Task',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people_outline),
                  activeIcon: Icon(Icons.people),
                  label: 'Referral',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_outlined),
                  activeIcon: Icon(Icons.account_balance_wallet),
                  label: 'Wallet',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
