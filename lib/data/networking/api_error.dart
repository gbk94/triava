import 'dart:io';
import 'package:dio/dio.dart';

const String _unknownError = 'Bilinmeyen bir hata meydana geldi.';

class ApiError implements Exception {
  final dynamic error;
  ApiError(this.error);

  int get statusCode {
    if (error is DioError) {
      return error.response?.statusCode ?? -1;
    }
    return -1;
  }

  int get errorCode {
    if (error is HandshakeException || error is SocketException) {
      return statusCode;
    } else if (error is DioError) {
      final response = (error as DioError).response;
      if (response == null || response.data == null) {
        return statusCode;
      } else {
        final data = response.data;
        if (data is Map) {
          if (data.containsKey('error_code')) return data['error_code'];
          return statusCode;
        }
        return statusCode;
      }
    }
    return -1;
  }

  String get message {
    if (error is ApiError) return error.message;
    if (error is String) return error;
    if (error is Map) return error['Message'];
    if (error is DioError) {
      if (error.error is HandshakeException || error.error is SocketException) {
        return 'İnternet bağlantınızı kontrol ediniz.';
      }
      final response = (error as DioError).response;
      final data = response?.data;
      if (response == null || data == null) {
        return _unknownError;
      } else {
        if (data is Map) {
          return data['message'] is String ? data['message'] : _unknownError;
        }
        return _unknownError;
      }
    }
    return _unknownError;
  }

  @override
  String toString() => '$error';
}
