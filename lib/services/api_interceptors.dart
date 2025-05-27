import 'package:dio/dio.dart';
import 'package:gatehub/cache/cache_helper.dart';
import 'package:gatehub/core/utiles/service_locator.dart';
import 'package:gatehub/services/end_points.dart';

class ApiInterceptors extends Interceptor {

@override
void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  final token = getIt<CacheHelper>().getData(key: ApiKey.token);
  if (token != null) {
    options.headers['Authorization'] = 'Bearer $token';
  }
  super.onRequest(options, handler);
}
//  @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//   // options.headers[ApiKey.token]=
//   options.headers['Authorization'] = 
//    getIt<CacheHelper>().getData(key: ApiKey.token)!= null
//    ? '${getIt<CacheHelper>().getData(key: ApiKey.token)}' :null;
//     super.onRequest(options, handler);
//   }
}