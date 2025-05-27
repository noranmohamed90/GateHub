import 'package:flutter/material.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/utiles/service_locator.dart';
import 'package:gatehub/cubit/cubit/login_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Rechargewebview extends StatefulWidget {
  final String paymentUrl;

  const Rechargewebview({super.key, required this.paymentUrl});

  @override
  State<Rechargewebview> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<Rechargewebview> {
  late final WebViewController _controller;

  @override
void initState() {
  super.initState();
  _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.contains("paymob-success") || request.url.contains("txn=approved")) {
            _onPaymentApproved(); 
            Navigator.pop(context);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(widget.paymentUrl));
}

void _onPaymentApproved() async {
  await getIt.get<LoginCubit>().getUserInfo();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('تمت عملية الشحن بنجاح')),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complete Recharge",
      style: TextStyle(color: kMainColor,fontWeight: FontWeight.bold),),
      backgroundColor: Colors.white,),
      body: WebViewWidget(controller: _controller),
    );
  }
}
