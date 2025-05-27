part of 'recharge_cubit.dart';

@immutable
sealed class RechargeState {}

final class RechargeInitial extends RechargeState {}
class RechargeSuccess extends RechargeState  {
   final String paymentUrl;

  RechargeSuccess({required this.paymentUrl});
}
class RechargeLoading extends RechargeState  {}
class RechargeFailure extends RechargeState  {
  final String errorMessage;

  RechargeFailure({required this.errorMessage});

  

}
