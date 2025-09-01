import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ndpl/app/core/constant/assets.dart';
import 'package:ndpl/app/core/utils/network_checker.dart';
import 'package:ndpl/app/core/utils/snackbar_message.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class YouTubeView extends StatefulWidget {
  final String url = "https://www.youtube.com/@coderangon";

  const YouTubeView({super.key});

  @override
  State<YouTubeView> createState() => _YouTubeViewState();
}

class _YouTubeViewState extends State<YouTubeView> {
  late WebViewController _webViewController;
  bool isLoading = true;
  bool hasInternetConnection = true;
  List<String> link = [];

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController();

    internetCheckerFunction();

    if (_webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_webViewController.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }
  }

  Future<void> internetCheckerFunction() async {
    setState(() {
      isLoading = true;
    });

    bool status = await ConnectionChecker.checkConnection();
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      hasInternetConnection = status;
    });

    if (hasInternetConnection) {
      _loadWebView(appUrl: widget.url);
    } else {
      CommonSnackBarMessage.noInternetConnection();
    }

    setState(() {
      isLoading = false;
    });
  }

  void _loadWebView({required String appUrl, bool? isBack}) async {
    try {
      _webViewController
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {},
            onPageStarted: (String url) {
              if (isBack != null && isBack == true) {
                if (link.isNotEmpty) link.removeLast();
                debugPrint("----- Removed last link -----");
              } else {
                link.add(appUrl);
                link.removeWhere((element) => element == url);
                debugPrint("----- Added new link -----");
              }
            },
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(appUrl));

      setState(() {});
    } catch (e) {
      debugPrint('Error loading web view: $e');
    }
  }

  Future<void> _onBackPressed(BuildContext context) async {
    if (link.isNotEmpty) {
      _loadWebView(appUrl: link.last, isBack: true);
    } else {
      Get.defaultDialog(
        title: 'Confirmation',
        titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        content: const Text('Do you want to exit the app?'),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context, false),
            child: Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
              child: const Center(
                child: Text('Cancel', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              SystemNavigator.pop();
            },
            child: Container(
              height: 30,
              width: 70,
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
      child: PopScope(
        canPop: false,
        onPopInvoked: (_) => _onBackPressed(context),
        child: isLoading
            ? Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AppAssets.logo, height: 250, width: 250, fit: BoxFit.cover),
                     
                    ],
                  ),
                ),
              )
            : hasInternetConnection
            ? Scaffold(
                backgroundColor: Colors.white,
                body: WebViewWidget(controller: _webViewController),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(Icons.wifi_off, color: Colors.red),
                      const Text("Please, Check Internet Connection", style: TextStyle(color: Colors.blueGrey, fontSize: 15)),
                      SizedBox(height: MediaQuery.sizeOf(context).height / 3),
                      InkWell(
                        onTap: () {
                          internetCheckerFunction();
                        },
                        child: const Icon(Icons.refresh),
                      ),
                      const Text("Reload", style: TextStyle(color: Colors.blueGrey, fontSize: 15)),
                      SizedBox(height: MediaQuery.sizeOf(context).height / 10),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
