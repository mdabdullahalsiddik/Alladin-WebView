import 'package:get/get.dart';
import 'package:ndpl/app/data/model/offer.dart';
import 'package:ndpl/app/data/services/api/offer.dart';

class OfferController extends GetxController {
  var offers = <OfferModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOffers();
  }

  void fetchOffers() async {
    try {
      isLoading.value = true;

      offers.value = await OfferService.service();
    } finally {
      isLoading.value = false;
    }
  }
}
