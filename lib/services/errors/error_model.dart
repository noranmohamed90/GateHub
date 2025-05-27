class ErrorModel {
  final String errorMessage;

  ErrorModel({required this.errorMessage});

  factory ErrorModel.fromResponse(dynamic responseData) {
    if (responseData is String) {
      return ErrorModel(errorMessage: responseData);
    }
    if (responseData is Map<String, dynamic>) {
      if (responseData.containsKey('errors') && responseData['errors'] is List) {
        List errorsList = responseData['errors'];
        if (errorsList.isNotEmpty) {
          return ErrorModel(errorMessage: errorsList[0]);
        }
      }
      return ErrorModel(
          errorMessage: responseData['error'] ??
              responseData['message'] ?? 
              'Unknown Error');
    }
    return ErrorModel(errorMessage: 'Unexpected error');
  }
}

// class ErrorModel {
//   final String errorMessage;
  

//   ErrorModel({required this.errorMessage});

//   factory ErrorModel.fromResponse(dynamic responseData) {
//     if (responseData is String) {
//       return ErrorModel(errorMessage: responseData);
//     }
//     if (responseData is Map<String, dynamic>) {
//       return ErrorModel(errorMessage: responseData['error'] ?? 'Unknown Error');
//     }
//     return ErrorModel(errorMessage: 'Unexpected error');
//   }
// }