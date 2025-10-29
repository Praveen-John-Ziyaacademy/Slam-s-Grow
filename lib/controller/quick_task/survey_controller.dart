import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/models/quick_task/survey_models.dart';

class SurveyController extends GetxController {
  final surveys = <Survey>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadSurveys();
  }

  void loadSurveys() {
    surveys.value = [
      Survey(
        title: 'Healthcare Survey',
        description:
            'Share your opinions on medical\nservices, fitness, and wellness.',
        icon: Icons.favorite_outline,
        color: Colors.blue,
      ),
      Survey(
        title: 'Entertainment Survey',
        description: 'Express your views on movies,\nTV shows, and games.',
        icon: Icons.movie_outlined,
        color: Colors.green,
      ),
      Survey(
        title: 'Music Survey',
        description:
            'Tell us about your favourite genres,\nartists, and music apps.',
        icon: Icons.music_note,
        color: Colors.purple,
      ),
      Survey(
        title: 'Academic Survey',
        description:
            'Participate in feedback about schools,\nonline courses, and education platforms.',
        icon: Icons.school_outlined,
        color: Colors.amber,
      ),
      Survey(
        title: 'Technical Survey',
        description:
            'Give your opinion on gadgets,\napps and software tools you use daily.',
        icon: Icons.construction_outlined,
        color: Colors.red,
      ),
      Survey(
        title: 'Human Resources Survey',
        description:
            'Help companies improve workplace culture and HR services.',
        icon: Icons.people_outline,
        color: Colors.teal,
      ),
      Survey(
        title: 'Finance Survey',
        description:
            'Share insights on banking, investments, and financial tools.',
        icon: Icons.attach_money,
        color: Colors.cyan,
      ),
    ];
  }

  void onSurveyTap(Survey survey) {
    Get.snackbar(
      survey.title,
      'Opening ${survey.title}...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: survey.color.withOpacity(0.1),
      colorText: survey.color,
      duration: const Duration(seconds: 2),
    );
  }
}
