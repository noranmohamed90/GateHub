import 'package:dio/dio.dart';
import 'package:gatehub/services/errors/error_model.dart';

class ServerException implements Exception{

  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}


 void handleDioException(DioException e) {
    switch(e.type){
      case DioExceptionType.connectionTimeout:
       throw ServerException(
        errorModel: ErrorModel.fromResponse(e.response!.data));
      case DioExceptionType.sendTimeout:
       throw ServerException(
        errorModel: ErrorModel.fromResponse(e.response!.data));
      case DioExceptionType.receiveTimeout:
       throw ServerException(
        errorModel: ErrorModel.fromResponse(e.response!.data));
      case DioExceptionType.badCertificate:
       throw ServerException(
        errorModel: ErrorModel.fromResponse(e.response!.data));
      case DioExceptionType.cancel:
       throw ServerException(
        errorModel: ErrorModel.fromResponse(e.response!.data));
      case DioExceptionType.connectionError:
       throw ServerException(
        errorModel: ErrorModel.fromResponse(e.response!.data));
      case DioExceptionType.unknown:
       throw ServerException(
        errorModel: ErrorModel.fromResponse(e.response!.data));
        case DioExceptionType.badResponse:
         throw ServerException(
          errorModel: ErrorModel.fromResponse(e.response!.data));
    }
  }