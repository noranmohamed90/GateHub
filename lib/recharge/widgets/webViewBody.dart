import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webviewbody extends StatefulWidget {
  final String paymentUrl;

  const Webviewbody({Key? key, required this.paymentUrl}) : super(key: key);

  @override
  State<Webviewbody> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<Webviewbody> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse(widget.paymentUrl))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complete Payment")),
      body: WebViewWidget(controller: _controller),
    );
  }
}
