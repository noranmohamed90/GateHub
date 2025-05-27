part of 'objection_cubit.dart';

@immutable
sealed class ObjectionState {}

final class ObjectionInitial extends ObjectionState {}
class GetobjectionSuccess extends ObjectionState {}
class GetobjectionoLoading extends ObjectionState {}
class GetobjectionFailure extends ObjectionState {
  final String errorMessage;
  GetobjectionFailure({required this.errorMessage});
}
