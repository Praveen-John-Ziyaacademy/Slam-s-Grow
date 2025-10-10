import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:social_media/models/home_screen_models.dart';

class HomeController extends GetxController {
  var balance = 2650.0.obs;
  var weeklyIncrease = 250.0.obs;
  var tasksCount = 24.obs;
  var rank = 4.obs;
  var daysStreak = 8.obs;
  var notificationCount = 1.obs;
  final RxInt selectedIndex = 0.obs;

  var tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() {
    tasks.value = [
      Task(
        title: 'Complete Daily Survey',
        points: 50,
        status: 'Active',
        timeLeft: '2 hours left',
        statusColor: Colors.green,
        isHighlighted: false,
        progress: '',
      ),
      Task(
        title: 'Share with 5 Friends',
        points: 100,
        status: '1/3 Complete',
        timeLeft: '',
        statusColor: Colors.orange,
        isHighlighted: true,
        progress: '1/3',
      ),
    ];
  }

  void doTask(int index) {
    Get.snackbar(
      'Task Started',
      'Starting: ${tasks[index].title}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  void viewTransactions() {
    Get.snackbar(
      'My Wallet',
      'Opening wallet transactions',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void viewLeaderboard() {
    Get.snackbar(
      'Leaderboard',
      'Opening leaderboard',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
