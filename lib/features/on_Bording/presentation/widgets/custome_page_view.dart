import 'package:flutter/material.dart';
import 'package:gatehub/features/on_Bording/presentation/widgets/page_view_item.dart';


class CustomePageView extends StatelessWidget {
  const CustomePageView({super.key, required this.pageController});
   final PageController? pageController;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller:pageController ,
     children: const  [ 
      PageViewItem(
        image: 'assets/images/notifications.png',
        title: 'Get instant alerts!',
        subTitle: 'Instant alerts for tolls and violations.',
      ),
      PageViewItem(
        image: 'assets/images/payment.png',
        title: 'Pay in seconds',
        subTitle: 'Easily pay fees and fines through the app.',
      ),
      PageViewItem(
        image: 'assets/images/objection.png',
        title: 'Dispute Fines',
        subTitle: 'Easily dispute incorrect violations.',
      ),
     ],
    );
  }
}
