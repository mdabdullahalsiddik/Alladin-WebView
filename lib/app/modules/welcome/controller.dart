import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var currentPage = 0.obs;

  void changePage(int index) {
    currentPage.value = index;
  }
}
