import 'package:get/get.dart';
import 'package:ndpl/app/modules/offer/notification.dart';

class OfferController extends GetxController {
  var offers = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOffers();
  }

  void fetchOffers() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1)); // simulate API call
      offers.value = OfferListDatas.data;
    } finally {
      isLoading.value = false;
    }
  }
}