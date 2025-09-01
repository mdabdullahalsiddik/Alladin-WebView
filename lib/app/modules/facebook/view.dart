import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ndpl/app/core/constant/assets.dart';
import 'package:ndpl/app/core/utils/network_checker.dart';
import 'package:ndpl/app/core/utils/snackbar_message.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class FacebookView extends StatefulWidget {
  final String url = "https://www.facebook.com/coderAngon";

  const FacebookView({super.key});

  @override
  State<FacebookView> createState() => _FacebookViewState();
}

class _FacebookViewState extends State<FacebookView> {
  late final WebViewController _webViewController;
  bool isLoading = true;
  bool hasInternetConnection = true;

  final List<String> _historyLinks = [];

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController();

    _checkInternetAndLoad();

    if (_webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_webViewController.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }
  }

  Future<void> _checkInternetAndLoad() async {
    setState(() => isLoading = true);

    bool status = await ConnectionChecker.checkConnection();
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      hasInternetConnection = status;
    });

    if (hasInternetConnection) {
      _loadWebView(widget.url);
    } else {
      CommonSnackBarMessage.noInternetConnection();
    }

    setState(() => isLoading = false);
  }

  void _loadWebView(String url, {bool isBack = false}) {
    if (!isBack) {
      _historyLinks.add(url);
    } else if (_historyLinks.isNotEmpty) {
      _historyLinks.removeLast();
    }

    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (_) {},
          onPageStarted: (_) {},
          onPageFinished: (_) {},
          onWebResourceError: (_) {},
          onNavigationRequest: (request) => NavigationDecision.navigate,
        ),
      )
      ..setUserAgent(
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0 Safari/537.36',
      ) // Forces desktop mode
      ..loadRequest(Uri.parse(url));
  }

  Future<void> _onBackPressed() async {
    if (_historyLinks.length > 1) {
      _loadWebView(_historyLinks.last, isBack: true);
    } else {
      Get.defaultDialog(
        title: 'Confirmation',
        content: const Text('Do you want to exit the app?'),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 35,
              width: 80,
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
              child: const Center(
                child: Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => SystemNavigator.pop(),
            child: Container(
              height: 35,
              width: 80,
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
              child: const Center(
                child: Text('Yes', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          await _onBackPressed();
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: isLoading
              ? Center(child: Image.asset(AppAssets.logo, height: 250, width: 250, fit: BoxFit.cover))
              : hasInternetConnection
              ? WebViewWidget(controller: _webViewController)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off, color: Colors.red, size: 50),
                      const SizedBox(height: 10),
                      const Text("Please, Check Internet Connection", style: TextStyle(color: Colors.blueGrey, fontSize: 16)),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(onPressed: _checkInternetAndLoad, icon: const Icon(Icons.refresh), label: const Text("Reload")),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
