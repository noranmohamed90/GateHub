import 'package:dio/dio.dart';
import 'package:gatehub/services/api_consumer.dart';
import 'package:gatehub/services/api_interceptors.dart';
import 'package:gatehub/services/end_points.dart';
import 'package:gatehub/services/errors/exception.dart';

class DioConsumer extends ApiConsumer{
  final Dio dio;

  DioConsumer({required this.dio}){
    dio.options.baseUrl =EndPoints.baseUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true
    ));
    
  }
  @override
  Future delete(
    String path, {
    dynamic  data, 
    Map<String, dynamic>? queryParameter,
    bool isFormData = false,
    }) async {
      try {
       final response = await dio.delete(
       path,
       data :isFormData?FormData.fromMap(data): data,
       queryParameters: queryParameter);
        return response.data;
        } on DioException catch (e) {
          handleDioException(e);
        }  }
  @override
  Future get(String path,{
    Object? data,
     Map<String, dynamic>? queryParameter,
     })async {
     try {
       final response = await dio.get(
       path,
       data: data,
       queryParameters: queryParameter);
        return response.data;
        } on DioException catch (e) {
          handleDioException(e);
        } 
  }

  @override
  Future patch(String path, {
    dynamic  data,
     Map<String, dynamic>? queryParameter,
     bool isFormData = false
     }) async{
     try {
       final response = await dio.patch(
       path,
        data :isFormData?FormData.fromMap(data): data,
       queryParameters: queryParameter);
        return response.data;
        } on DioException catch (e) {
          handleDioException(e);
        } 
  }

  @override
  Future post(String path, {
      dynamic data,
     Map<String, dynamic>? queryParameter,
     bool isFormData = false
     })async {
    try {
       final response = await dio.post(
       path,
        data :isFormData?FormData.fromMap(data): data,
       queryParameters: queryParameter);
        return response.data;
        } on DioException catch (e) {
          handleDioException(e);
        } 
  }
  
}