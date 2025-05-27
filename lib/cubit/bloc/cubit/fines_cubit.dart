import 'package:bloc/bloc.dart';
import 'package:gatehub/models/finesModel.dart';
import 'package:gatehub/services/api_consumer.dart';
import 'package:gatehub/services/end_points.dart';
import 'package:gatehub/services/errors/exception.dart';
import 'package:meta/meta.dart';

part 'fines_state.dart';

class FinesCubit extends Cubit<FinesState> {
  FinesCubit(this.api) : super(FinesInitial());
  final ApiConsumer api;

  List<Finesmodel> finesList = [];
  Future<void> getFinesInfo() async {
    emit(GetFinesInfoLoading());
    try {
      final response = await api.get(EndPoints.finesandfees);
      finesList = (response as List)
          .map((item) => Finesmodel.fromJson(item))
          .toList();
          print(response);
          //final vehicleEntryId = finesList.first.id;
          // getIt<CacheHelper>().saveData(key: 'id', value: fine);
      emit(GetFinesInfoSuccess(fines: finesList));
    } on ServerException catch (e) {
      emit(GetFinesInfoFailure(errorMessage: e.errorModel.errorMessage));
    }
  }

  void toggleFineSelection(int index, bool selected) {
    finesList[index].selected = selected;
    emit(GetFinesInfoSuccess(fines: List.from(finesList)));
  }

  void updateFineSelection(int index, bool? selected) {
  if (state is GetFinesInfoSuccess) {
    final fines = List<Finesmodel>.from((state as GetFinesInfoSuccess).fines);
    fines[index] = fines[index].copyWith(selected: selected);
    emit(GetFinesInfoSuccess(fines: fines));
  }
}

}

