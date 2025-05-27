import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:gatehub/cache/cache_helper.dart';
import 'package:gatehub/core/utiles/service_locator.dart';
import 'package:gatehub/services/api_consumer.dart';
import 'package:gatehub/services/end_points.dart';
import 'package:gatehub/services/errors/exception.dart';
import 'package:meta/meta.dart';
part 'objection_state.dart';

class ObjectionCubit extends Cubit<ObjectionState> {
  ObjectionCubit(this.api) : super(ObjectionInitial());
  ApiConsumer api;
  
  final TextEditingController objectionController = TextEditingController();
  String?vehicleEntryId;
void getVehicleEntryId() {
  final id = getIt<CacheHelper>().getData(key: 'id');
  print("VehicleEntryId from cache: $id"); 
  if (id != null) {
    vehicleEntryId = id.toString();
  } else {
    print("VehicleEntryId is null from cache");
  }
}
String?validateData(){
    if(objectionController.text.isEmpty){
      return'Please Enter your reasons for objection';
    }  return null;
  }



postObjection({required int vehicleEntryId})async{
  getVehicleEntryId();
   final validationMessage =validateData();
  if (validationMessage != null) {
    emit(GetobjectionFailure(errorMessage: validationMessage));
    return;
  }
   emit(GetobjectionoLoading());
  try {
  final response =await api.post(EndPoints.objection,
  data: {
    "description": objectionController.text,
    'vehicleEntryId':vehicleEntryId
  });
  print("Response: ${response.data}");
 print("Type: ${vehicleEntryId.runtimeType}, Value: $vehicleEntryId");
  
 emit(GetobjectionSuccess());
}  on ServerException catch (e) {
    emit(GetobjectionFailure(errorMessage: e.errorModel.errorMessage));
  } catch (e) {
    emit(GetobjectionFailure(errorMessage: e.toString()));
  }
}
}


//  if (response.statusCode == 200 &&
//         response.data["message"] == "Objection submitted successfully.") {
//       emit(GetobjectionSuccess());
//     } else {
//       emit(GetobjectionFailure(
//           errorMessage: "Unexpected response: ${response.data['message']}"));
//     }
//   } on DioException catch (e) {
//     emit(GetobjectionFailure(errorMessage: "Error: ${e.message}"));
//   } catch (e) {
//     emit(GetobjectionFailure(errorMessage: "Unknown error occurred: $e"));
//   }
// }