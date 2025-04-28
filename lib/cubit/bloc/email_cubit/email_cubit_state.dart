
part of 'email_cubit_cubit.dart'; 



//@immutable
abstract  class EmailCubitState {}

final class EmailCubitInitial extends EmailCubitState {}
class EmailSuccess extends EmailCubitState {}
class EmailLoading extends EmailCubitState {}
class EmailFailure extends EmailCubitState {
  final String errorMessage;
  EmailFailure({required this.errorMessage});

  

}
