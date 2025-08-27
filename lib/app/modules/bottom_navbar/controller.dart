import 'package:get/get.dart';
import 'package:ndpl/app/modules/facebook/view.dart';
import 'package:ndpl/app/modules/home/view.dart';
import 'package:ndpl/app/modules/upcoming/view.dart';
import 'package:ndpl/app/modules/youtube/view.dart';

class BottomNavBarController extends GetxController {
  RxInt selectedPos = 0.obs;

  final List screenList = [HomeView(), FacebookView(), YouTubeView(), UpcomingView(), UpcomingView()];
}
