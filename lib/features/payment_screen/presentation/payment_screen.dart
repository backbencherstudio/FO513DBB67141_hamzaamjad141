import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/payment_screen/Riverpod/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PaymentWebView extends StatefulWidget {
  final String paymentUrl;
  const PaymentWebView({super.key, required this.paymentUrl});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController  controller;
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  initState() {
    _appLinks = AppLinks();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('myflutterapp://payment-success')) {
              _handleDeepLink(Uri.parse(request.url));
              return NavigationDecision.prevent;
            } else if (request.url.contains('failure')) {
              Navigator.pushReplacementNamed(context, '/failure');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));

    super.initState();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initDeepLinkListener() async {
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleDeepLink(initialUri);
      }
    } catch (e) {
      print('Error getting initial URI: $e');
    }

    _linkSubscription = _appLinks.uriLinkStream.listen(
      (Uri? uri) {
        if (uri != null) {
          _handleDeepLink(uri);
        }
      },
      onError: (err) {
        print('Error handling deep link: $err');
      },
    );
  }

  void _handleDeepLink(Uri uri) {
    if (uri.scheme == 'myflutterapp' && uri.host == 'payment-success') {
      final sessionId = uri.queryParameters['session_id'];
      debugPrint('Payment successful with session ID: $sessionId');
      Fluttertoast.showToast(
        msg: "Payment Successful",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      context.go(RouteName.weatherScreen);
      
      // Navigator.pushReplacementNamed(context, '/success', arguments: sessionId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
