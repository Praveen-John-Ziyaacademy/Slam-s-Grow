import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:social_media/screens/wallet/withdraw_success_screen.dart';

class PaymentMethodController extends GetxController {
  final selectedPaymentMethod = 'UPI'.obs;
  final withdrawalAmount = 1000.00.obs;

  void selectPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }

  void continueToConfirm() {
    Get.to(() => WithdrawalSuccessScreen());
  }

  void addNewPaymentMethod() {
    Get.snackbar(
      'Add Payment Method',
      'Opening add payment method screen',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
