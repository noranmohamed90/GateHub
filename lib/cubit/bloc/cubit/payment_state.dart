part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}
class PaymentSuccess extends PaymentState  {
   final String paymentUrl;

  PaymentSuccess({required this.paymentUrl});
}
class PaymentLoading extends PaymentState  {}
class PaymentFailure extends PaymentState  {
  final String errorMessage;

  PaymentFailure({required this.errorMessage});


}
final class PaymentWalletInitial extends PaymentState {}
class PaymentWalletSuccess extends PaymentState  {}
class PaymentWalletLoading extends PaymentState  {}
class PaymentWalletFailure extends PaymentState  {
  final String errorMessage;

  PaymentWalletFailure({required this.errorMessage});


}