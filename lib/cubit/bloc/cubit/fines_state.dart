part of 'fines_cubit.dart';

@immutable
sealed class FinesState {}

final class FinesInitial extends FinesState {}
class GetFinesInfoSuccess extends FinesState {
   final List<Finesmodel> fines;

  GetFinesInfoSuccess({required this.fines});
}
class GetFinesInfoLoading extends FinesState {}
class GetFinesInfoFailure extends FinesState {
  final String errorMessage;
  GetFinesInfoFailure({required this.errorMessage});
}
