part of 'change_pass_cubit.dart';

@immutable
sealed class ChangePassState {}

final class ChangePassInitial extends ChangePassState {}

class ChangePassSuccess extends ChangePassState {}
class ChangePassLoading extends ChangePassState {}
class ChangePassFailure extends ChangePassState {
  final String errorMessage;
  ChangePassFailure({required this.errorMessage});
}

class LogOutState{}
final class LogOutInitial extends ChangePassState {}
class LogOutSuccess extends ChangePassState {}
class LogOutLoading extends ChangePassState {}
class LogOutFailure extends ChangePassState{
  final String errorMessage;
  LogOutFailure({required this.errorMessage});
}