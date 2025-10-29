import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/screens/quick_task/share_screen.dart';

class PostController extends GetxController {
  var isLiked = false.obs;
  var likeCount = 1350.obs;
  var commentCount = 59.obs;

  void toggleLike() {
    isLiked.value = !isLiked.value;
    if (isLiked.value) {
      likeCount.value++;
    } else {
      likeCount.value--;
    }
  }

  void addComment() {
    commentCount.value++;
    Get.snackbar(
      'Comment',
      'Comment added successfully',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
      backgroundColor: Colors.black54,
      colorText: Colors.white,
    );
  }

  void share() {
    Get.to(() => ShareScreenshotsPage());
  }
}
