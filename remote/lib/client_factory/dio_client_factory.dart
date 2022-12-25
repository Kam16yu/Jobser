import 'dart:io';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:injector/injector.dart' show Injector;
import 'package:remote/remote.dart';

class DioClientFactory {

  Dio getClient() {
    final client = Dio();
    client.interceptors.add(LogInterceptor(
      responseHeader: false,
      responseBody: true,
    ));
    return client;
  }
}
