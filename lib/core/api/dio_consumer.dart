import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tmdb/core/api/api_consumer.dart';
import 'package:tmdb/core/api/app_interceptors.dart';
import 'package:tmdb/core/api/end_points.dart';
import 'package:tmdb/core/api/status_codes.dart';
import 'package:tmdb/core/errors/exceptions.dart';
import 'package:tmdb/injection_container.dart' as di;

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient httpClient) {
      httpClient.badCertificateCallback =
          (X509Certificate certificate, String host, int port) => true;
      return httpClient;
    };

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..validateStatus = (status) {
        return status! < StatusCodes.internalServerError;
      };

    client.interceptors.add(di.serviceLocator<AppInterceptors>());
    if (kDebugMode) {
      client.interceptors.add(di.serviceLocator<LogInterceptor>());
    }
  }
  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return json.decode(response.data.toString());
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool formDataIsEnabled = false,
  }) async {
    try {
      final response = await client.post(
        path,
        queryParameters: queryParameters,
        data: formDataIsEnabled ? FormData.fromMap(body!) : body,
      );
      return json.decode(response.data.toString());
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.put(
        path,
        queryParameters: queryParameters,
        data: body,
      );
      return json.decode(response.data.toString());
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw FetchDataException();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case StatusCodes.badRequest:
            throw BadRequestException();
          case StatusCodes.forbidden:
          case StatusCodes.unAuthorized:
            throw UnauthorizedException();

          case StatusCodes.notFound:
            throw NotFoundException();
          case StatusCodes.conflict:
            throw ConflictException();
          case StatusCodes.internalServerError:
            throw InternalServerErrorException();
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw NoInternetConnectionException();
    }
  }
}
