part of 'login_cubit.dart';

 @immutable
abstract  class LoginState {}

class LoginInitial extends LoginState {}
class LoginSuccess extends LoginState {}
class LoginLoading extends LoginState {}
class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});

  

}
abstract  class GetUserInfo {}
class GetUserInfoSuccess extends LoginState {
   final UserInfo user;

   GetUserInfoSuccess({required this.user});
}
class GetUserInfoLoading extends LoginState {}
class GetUserInfoFailure extends LoginState {
  final String errorMessage;
  GetUserInfoFailure({required this.errorMessage});
}
