part of 'otp_cubit.dart';

@immutable
abstract class OtpState {}

final class OtpInitial extends OtpState {}
class OtpSuccess extends OtpState {}
class OtpLoading extends OtpState {}
class OtpFailure extends OtpState {
  final String errorMessage;
  OtpFailure({required this.errorMessage});
}