import 'package:flutter/widgets.dart';
import 'package:gatehub/paymentScreen/widgets/VisaBody.dart';

class Visaview extends StatelessWidget {
  const Visaview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Visabody(selectedFineIds: [], initialAmount: 0,);
  }
}