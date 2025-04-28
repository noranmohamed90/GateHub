class ErrorModel {
  final String errorMessage;
  

  ErrorModel({required this.errorMessage});

  factory ErrorModel.fromResponse(dynamic responseData) {
    if (responseData is String) {
      return ErrorModel(errorMessage: responseData);
    }
    if (responseData is Map<String, dynamic>) {
      return ErrorModel(errorMessage: responseData['error'] ?? 'Unknown Error');
    }
    return ErrorModel(errorMessage: 'Unexpected error');
  }
}