import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sim_jalan_mobile/common/common.dart';

import 'logger.dart';

class ApiBaseHelper {
  ApiBaseHelper() : dio = createDio();

  final String _baseUrl = StringConst.baseUrl;

  String get baseUrl => _baseUrl;

  /// custom to log everytime (true) or only when error found (false)
  bool isLog = true;

  /// helper to change map to params
  String mapToParams(Map<String, dynamic>? map) {
    return '?' + Uri(queryParameters: map).query;
  }

  final Dio dio;

  static BaseOptions opts = BaseOptions(
    baseUrl: StringConst.baseUrl,
    responseType: ResponseType.json,
    connectTimeout: 30000,
    receiveTimeout: 30000,
  );

  static Dio createDio() {
    return Dio(opts);
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? header, Options? options}) async {
    try {
      if (isLog) {
        logInput(url, header: header);
      }
      loggerWtf(url);
      Response response = await dio.get(
        url,
        options: options ??
            Options(
              headers: header,
            ),
      );
      //API SIM Jalan user "echo" as return, api helper need to encode it to json first!
      var jsonData = jsonDecode(response.data);
      checkError(jsonData, url: url, header: header);
      if (isLog) {
        logOutput(jsonData);
      }
      return jsonData;
    } on DioError catch (dioError) {
      if (!isLog) {
        logInput(url, header: header);
      }
      logOutput(dioError.message, error: dioError.error, response: dioError.response);
      throw '${dioError.response?.statusCode} : ${dioError.message}';
    } catch (e, trace) {
      if (!isLog) {
        logInput(url, header: header);
      }
      logOutput('Non dio error', error: e, trace: trace);
      throw e.toString();
    }
  }

  Future<dynamic> getWithoutStatus(String url,
      {Map<String, dynamic>? header, Options? options}) async {
    try {
      if (isLog) {
        logInput(url, header: header);
      }
      Response response = await dio.get(
        url,
        options: options ??
            Options(
              headers: header,
            ),
      );
      //API SIM Jalan user "echo" as return, api helper need to encode it to json first!
      var data = jsonDecode(response.data);
      checkError(data, url: url, header: header);
      if (isLog) {
        logOutput(data);
      }
      return data;
    } on DioError catch (dioError) {
      if (!isLog) {
        logInput(url, header: header);
      }
      logOutput(dioError.message, error: dioError.error, response: dioError.response);
      throw '${dioError.response?.statusCode} : ${dioError.message}';
    } catch (e, trace) {
      if (!isLog) {
        logInput(url, header: header);
      }
      logOutput('Non dio error', error: e, trace: trace);
      throw e.toString();
    }
  }

  Future<dynamic> post(String url,
      {dynamic data, Map<String, dynamic>? header, Options? options}) async {
    try {
      if (isLog) {
        logInput(url, header: header, body: data);
      }
      Response response = await dio.post(
        url,
        data: data,
        options: options ??
            Options(
              headers: header,
            ),
      );
      loggerI(response);
      //API SIM Jalan user "echo" as return, api helper need to encode it to json first!
      var jsonData = jsonDecode(response.data);
      checkError(jsonData, url: url, header: header, body: data);
      if (isLog) {
        logOutput(jsonData);
      }
      return jsonData;
    } on DioError catch (dioError) {
      if (!isLog) {
        logInput(url, header: header, body: data);
      }
      logOutput(dioError.message, error: dioError.error, response: dioError.response);
      throw '${dioError.response?.statusCode} : ${dioError.message}';
    } catch (e, trace) {
      if (!isLog) {
        logInput(url, header: header, body: data);
      }
      logOutput('Non dio error', error: e, trace: trace);
      throw e.toString();
    }
  }

  Future<dynamic> put(String url,
      {dynamic data, Map<String, dynamic>? header, Options? options}) async {
    try {
      if (isLog) {
        logInput(url, header: header, body: data);
      }
      Response response = await dio.put(
        url,
        data: data,
        options: options ??
            Options(
              headers: header,
            ),
      );
      //API SIM Jalan user "echo" as return, api helper need to encode it to json first!
      var jsonData = jsonDecode(response.data);
      checkError(jsonData, url: url, header: header, body: data);
      if (isLog) {
        logOutput(jsonData);
      }
      return jsonData;
    } on DioError catch (dioError) {
      if (!isLog) {
        logInput(url, header: header, body: data);
      }
      logOutput(dioError.message, error: dioError.error, response: dioError.response);
      throw '${dioError.response?.statusCode} : ${dioError.message}';
    } catch (e, trace) {
      if (!isLog) {
        logInput(url, header: header, body: data);
      }
      logOutput('Non dio error', error: e, trace: trace);
      throw e.toString();
    }
  }

  Future<dynamic> delete(String url,
      {dynamic data, Map<String, dynamic>? header, Options? options}) async {
    try {
      if (isLog) {
        logInput(url, header: header, body: data);
      }
      Response response = await dio.delete(
        url,
        data: data,
        options: options ??
            Options(
              headers: header,
            ),
      );
      //API SIM Jalan user "echo" as return, api helper need to encode it to json first!
      var jsonData = jsonDecode(response.data);
      checkError(jsonData, url: url, header: header, body: data);
      if (isLog) {
        logOutput(jsonData);
      }
      return jsonData;
    } on DioError catch (dioError) {
      if (!isLog) {
        logInput(url, header: header, body: data);
      }
      logOutput(dioError.message, error: dioError.error, response: dioError.response);
      throw '${dioError.response?.statusCode} : ${dioError.message}';
    } catch (e, trace) {
      if (!isLog) {
        logInput(url, header: header, body: data);
      }
      logOutput('Non dio error', error: e, trace: trace);
      throw e.toString();
    }
  }

  checkError(dynamic response, {dynamic url, dynamic header, dynamic body}) {
    if (response['status'] == false) {
      logInput(url, header: header, body: body);
      logOutput(response);
      throw response['msg'] ?? response['message'] ?? response['data']?['message'] ?? 'Failed';
    }
  }

  logInput(dynamic url, {dynamic header, dynamic body}) {
    loggerI(baseUrl + url);
    if (header != null) loggerI(header);
    if (body != null) {
      if (body is FormData) {
        if(body.fields.isNotEmpty) loggerI(body.fields.map((e) => "${e.key}: ${e.value}").toList());
        if(body.files.isNotEmpty) loggerI(body.files.map((e) => "${e.key}: ${e.value}").toList());
      } else {
        loggerI(body);
      }
    }
  }

  logOutput(dynamic message, {dynamic error, dynamic trace, dynamic response}) {
    loggerI(message);
    if (error != null) loggerI(error);
    if (trace != null) loggerI(trace);
    if (response != null) loggerI(response);
  }
}
