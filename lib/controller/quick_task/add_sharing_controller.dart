import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/models/quick_task/add_sharing_models.dart';

// Controller
class AdSharingController extends GetxController {
  var availableCredits = 0.obs;
  var totalCredits = 120.obs;
  var completedTasks = 0.obs;

  var tasks = <Task>[
    Task(
      id: 1,
      icon: Icons.article,
      title: 'Read Linked Blog Article',
      description: 'Read our latest blog post and stay updated',
      credits: 20,
      buttonText: 'Read Article',
      isCompleted: false,
    ),
    Task(
      id: 2,
      icon: Icons.telegram,
      title: 'Join Telegram Group',
      description: 'Join our community and get exclusive updates',
      credits: 30,
      buttonText: 'Join Group',
      isCompleted: false,
    ),
    Task(
      id: 3,
      icon: Icons.repeat,
      title: 'Retweet Tweet',
      description: 'Share our latest tweet with your followers',
      credits: 20,
      buttonText: 'Retweet',
      isCompleted: false,
    ),
    Task(
      id: 4,
      icon: Icons.share,
      title: 'Share Campaign Link',
      description: 'Share campaign link on your social media',
      credits: 25,
      buttonText: 'Share Link',
      isCompleted: false,
    ),
    Task(
      id: 5,
      icon: Icons.photo_library,
      title: 'Instagram Post Share',
      description: 'Share our latest post with your followers',
      credits: 25,
      buttonText: 'Share Link',
      isCompleted: false,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    calculateCredits();
  }

  void completeTask(int taskId) {
    final taskIndex = tasks.indexWhere((t) => t.id == taskId);
    if (taskIndex != -1 && !tasks[taskIndex].isCompleted) {
      tasks[taskIndex].isCompleted = true;
      tasks.refresh();
      calculateCredits();
    }
  }

  void calculateCredits() {
    int available = 0;
    int completed = 0;

    for (var task in tasks) {
      if (task.isCompleted) {
        available += task.credits;
        completed++;
      }
    }

    availableCredits.value = available;
    completedTasks.value = completed;
  }
}
