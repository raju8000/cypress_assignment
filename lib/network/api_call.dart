import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiCall{
  static Future<dynamic>? call({required String url,required BaseOptions options,
    dynamic body=const {} }) async {
    var dio = Dio(options);
    try {
      var response = await dio.request(
        url,
        data: body,
      );
      return response.data;
    }catch(error){
      debugPrint(error.toString());
      return null;
    }
  }
}