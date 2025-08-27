import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class UpcomingView extends GetView<UpcomingController> {
  const UpcomingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Container(child: Text("Coming Soon..."))),
    );
  }
}
