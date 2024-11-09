import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class HttpService {
  final Logger logger = Logger();
  Duration timeOutLimit = const Duration(seconds: 15);

  void throwOnFailureCodeException(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('Request failed with status: ${response.statusCode}');
    }
  }

  void logResponse(http.Response response) {
    logger.i(
      'Server Response to ${response.request?.method.toUpperCase()} ${response.request?.url.path} : '
      'StatusCode: ${response.statusCode} '
      'body: ${response.body}',
    );
  }

  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    try {
      var response = await http
          .delete(url, headers: headers, body: body, encoding: encoding)
          .timeout(timeOutLimit);

      logResponse(response);
      throwOnFailureCodeException(response);

      return response;
    } on http.ClientException catch (e) {
      throw SocketException("ClientException has occurred: $e");
    } on IOException catch (e) {
      throw SocketException("IOException has occurred: $e");
    } on TimeoutException catch (e) {
      throw SocketException("Network TimeoutException has occurred: $e");
    }
  }

  Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
    Map<String, String>? params,
  }) async {
    try {
      if (params != null) {
        url = url.replace(queryParameters: params);
      }

      var response =
          await http.get(url, headers: headers).timeout(timeOutLimit);

      logResponse(response);
      throwOnFailureCodeException(response);

      return response;
    } on http.ClientException catch (e) {
      throw SocketException("ClientException has occurred: $e");
    } on IOException catch (e) {
      throw SocketException("IOException has occurred: $e");
    } on TimeoutException catch (e) {
      throw SocketException("Network TimeoutException has occurred: $e");
    }
  }

  Future<http.Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    try {
      var response = await http
          .patch(url, headers: headers, body: body, encoding: encoding)
          .timeout(timeOutLimit);

      logResponse(response);
      throwOnFailureCodeException(response);

      return response;
    } on http.ClientException catch (e) {
      throw SocketException("ClientException has occurred: $e");
    } on IOException catch (e) {
      throw SocketException("IOException has occurred: $e");
    } on TimeoutException catch (e) {
      throw SocketException("Network TimeoutException has occurred: $e");
    }
  }

  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Map<String, String>? params,
    Object? body,
    Encoding? encoding,
  }) async {
    try {
      if (params != null) {
        url = url.replace(queryParameters: params);
      }

      var response = await http
          .post(url, headers: headers, body: body, encoding: encoding)
          .timeout(timeOutLimit);

      logResponse(response);
      throwOnFailureCodeException(response);

      return response;
    } on http.ClientException catch (e) {
      throw SocketException("ClientException has occurred: $e");
    } on IOException catch (e) {
      throw SocketException("IOException has occurred: $e");
    } on TimeoutException catch (e) {
      throw SocketException("Network TimeoutException has occurred: $e");
    }
  }

  Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    try {
      var response = await http
          .put(url, headers: headers, body: body, encoding: encoding)
          .timeout(timeOutLimit);

      logResponse(response);
      throwOnFailureCodeException(response);

      return response;
    } on http.ClientException catch (e) {
      throw SocketException("ClientException has occurred: $e");
    } on IOException catch (e) {
      throw SocketException("IOException has occurred: $e");
    } on TimeoutException catch (e) {
      throw SocketException("Network TimeoutException has occurred: $e");
    }
  }
}
