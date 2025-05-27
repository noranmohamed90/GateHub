import 'package:dio/dio.dart';
import 'package:logger/logger.dart';


class PaymentService {
  final Dio _dio;
  final Logger _logger;

  PaymentService()
      : _dio = Dio(
          BaseOptions(
            baseUrl : 'https://api.gatehub.com/api/VehicleOwner', 
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ),
        _logger = Logger();

  Future<bool> submitObjection({
    required String objectionText,
    required List<String> feeIds,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        '/api/VehicleOwner/SubmitObjection',
        data: {
          'objectionText': objectionText,
          'feeIds': feeIds,
        },
        cancelToken: cancelToken,
      );

      _logger.i('Objection submitted successfully');
      return response.statusCode == 200;
    } on DioException catch (e) {
      _logger.e('Failed to submit objection', error: e);
      if (e.type == DioExceptionType.cancel) {
        _logger.w('Objection submission was cancelled');
      }
      rethrow;
    } catch (e) {
      _logger.e('Unexpected error in objection submission', error: e);
      rethrow;
    }
  }

  Future<bool> payVehicleEntry({
    required String entryId,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        '/api/VehicleOwner/pay-vehicle-entry/$entryId',
        cancelToken: cancelToken,
      );

      _logger.i('Vehicle entry paid successfully');
      return response.statusCode == 200;
    } on DioException catch (e) {
      _logger.e('Failed to pay vehicle entry', error: e);
      if (e.type == DioExceptionType.cancel) {
        _logger.w('Payment was cancelled');
      }
      rethrow;
    }
  }

  Future<bool> payMultipleVehicleEntries({
    required List<String> entryIds,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        '/api/VehicleOwner/pay-multiple-vehicle-entries',
        data: {'entryIds': entryIds},
        cancelToken: cancelToken,
      );

      _logger.i('Multiple entries paid successfully');
      return response.statusCode == 200;
    } on DioException catch (e) {
      _logger.e('Failed to pay multiple entries', error: e);
      rethrow;
    }
  }

  Future<bool> rechargeBalance({
    required double amount,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        '/api/VehicleOwner/recharge-balance',
        data: {'amount': amount},
        cancelToken: cancelToken,
      );

      _logger.i('Balance recharged successfully: $amount LE');
      return response.statusCode == 200;
    } on DioException catch (e) {
      _logger.e('Failed to recharge balance', error: e);
      rethrow;
    }
  }

  Future<bool> payFromBalance({
    required double amount,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post(
        '/api/VehicleOwner/pay-from-balance',
        data: {'amount': amount},
        cancelToken: cancelToken,
      );

      _logger.i('Payment from balance successful: $amount LE');
      return response.statusCode == 200;
    } on DioException catch (e) {
      _logger.e('Failed to pay from balance', error: e);
      rethrow;
    }
  }

  
  void addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          _logger.d('Request to ${options.path}');
          
          return handler.next(options);
        },
        onError: (error, handler) {
          _logger.e('API Error: ${error.message}');
          return handler.next(error);
        },
      ),
    );
  }
}