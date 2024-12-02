// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:jo_students/utils/helpers/progress_hud.dart';
import 'package:oktoast/oktoast.dart';

class HttpWrapper {
  final String? url;
  final bool showLoading;
  final dynamic body;
  final Map<String, String>? files;
  final Map<String, List<String?>>? filesList;
  final Duration defaultTimeout = const Duration(seconds: 120);
  final BuildContext? context;
  final String? token;
  final String currentLanguage;
  Map<String, String>? headers;
  final bool useAuthorization;
  final bool unFocusPrimary;

  HttpWrapper({
    this.headers,
    this.url,
    this.useAuthorization = true,
    this.body,
    this.files,
    this.filesList,
    this.context,
    this.token,
    this.currentLanguage = 'ar',
    this.showLoading = false,
    this.unFocusPrimary = true,
  }) {
    if (unFocusPrimary) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    headers ??= {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    };
  }

  Future<HttpClient> _createClient(HttpWrapper wrapper) async {
    final clientContext = SecurityContext(withTrustedRoots: false);
    HttpClient client = HttpClient(context: clientContext)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) {
        return true;
      });

    return client;
  }

  Future<ApiResponse?> post() async {
    ApiResponse apiResponse = ApiResponse();
    apiResponse.statusCode = 400;

    // Check for internet connection before making the request
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showToast("يرجى الاتصال بالانترنت",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
      return apiResponse;
    }

    try {
      if (showLoading) {
        ProgressHud.shared.startLoading(context!);
      }

      bool isTimeout = false;

      HttpClient client = await _createClient(this);

      IOClient ioClient = IOClient(client);

      final response = await ioClient
          .post(
        Uri.parse(url!),
        headers: headers,
        body: json.encode(body),
        encoding: utf8,
      )
          .timeout(defaultTimeout, onTimeout: () {
        if (!isTimeout) {
          isTimeout = true;
          if (showLoading) {
            ProgressHud.shared.stopLoading();
          }

          _printLog('Time out', this);
        }

        return Response("Time Out", 504);
      }).catchError((error) {
        if (showLoading) {
          ProgressHud.shared.stopLoading();
        }
        if (kDebugMode) {
          debugPrint('HTTP Exception $error');
        }

        return Response("Error In Internet Connection", 500);
      });
      ioClient.close();

      if (!isTimeout) {
        apiResponse = await _finalResponse(this, response);
      }
    } catch (error) {
      if (showLoading) {
        ProgressHud.shared.stopLoading();
      }
      _printLog('POST Request', this);
    }
    _printLog('POST Request', this);

    return apiResponse;
  }

  Future<ApiResponse?> get() async {
    ApiResponse apiResponse = ApiResponse();
    apiResponse.statusCode = 400;

    // Check for internet connection before making the request
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showToast("يرجى الاتصال بالانترنت",
          backgroundColor: Colors.red, duration: const Duration(seconds: 3));
      return apiResponse;
    }
    try {
      bool isTimeout = false;

      HttpClient client = await _createClient(this);

      IOClient ioClient = IOClient(client);

      final response = await ioClient
          .get(Uri.parse(url!), headers: headers)
          .timeout(defaultTimeout, onTimeout: () {
        if (!isTimeout) {
          isTimeout = true;
          if (showLoading) {
            ProgressHud.shared.stopLoading();
          }

          _printLog('Time out', this);
        }

        return Response("Time Out", 504);
      }).catchError((error) {
        if (showLoading) {
          ProgressHud.shared.stopLoading();
        }
        _printLog('HTTP Exception', this);

        return Response("Error In Internet Connection", 500);
      });

      ioClient.close();

      if (!isTimeout) {
        apiResponse = await _finalResponse(this, response);
      }
    } catch (error) {
      if (showLoading) {
        ProgressHud.shared.stopLoading();
      }
      _printLog('POST Request', this);
    }

    return apiResponse;
  }

  Future<ApiResponse> _finalResponse(
      HttpWrapper wrapper, Response response) async {
    ApiResponse apiResponse = ApiResponse();
    apiResponse.statusCode = 400;

    if (wrapper.showLoading) ProgressHud.shared.stopLoading();

    final connectivityResult = await (Connectivity().checkConnectivity());

    try {
      _printLogWithResponse(response, wrapper);
    } catch (e) {
      if (kDebugMode) {
        debugPrint(e.toString());
      }
    }

    if (connectivityResult == ConnectivityResult.none) {
      return apiResponse;
    } else {
      apiResponse.statusCode = response.statusCode;
      apiResponse.body = response.bodyBytes;

      return apiResponse;
    }
  }

  void _printLogWithResponse(Response response, HttpWrapper wrapper) {
    try {
      if (kDebugMode) {
        if (kDebugMode) {
          print(
              '${'==============================================\nheaders = {\'Content-Type\' : \'application/json\'}\n\nencoding = UTF8\n\nurl =${wrapper.url!}\n\npostBody = ' + wrapper.body}\n\nresponse body = ${response.body}');
        }
        if (kDebugMode) {
          print('\n==============================================');
        }
      }
    } catch (_) {}
  }

  void _printLog(String from, HttpWrapper wrapper) {
    try {
      if (kDebugMode) {
        print(
            '==============================================\nFrom : $from\nheaders = {\'Content-Type\' : \'application/json\'}\n\nencoding = UTF8\n\nurl =${wrapper.url!}\n\npostBody = ${wrapper.body}\n\n');
      }
      if (kDebugMode) {
        print('\n==============================================');
      }
    } catch (_) {}
  }
}

class ApiResponse {
  Uint8List? body;
  Map<String, List<String>>? headers;
  int? statusCode;

  ApiResponse();

  ApiResponse.fromApiResponse(this.body, this.headers, this.statusCode);

  ApiResponse.clone(ApiResponse response)
      : this.fromApiResponse(
            response.body, response.headers, response.statusCode);
}
