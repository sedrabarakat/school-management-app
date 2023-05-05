import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl:'http://192.168.1.115:8000/api/',
        receiveDataWhenStatusError: true,
        connectTimeout:const Duration(  seconds: 60),
        receiveTimeout:  const Duration(  seconds: 60),
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async
  {

    dio!.options.headers =
    {
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${token}'??'',
    };

    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<dynamic, dynamic>? data,
    Map<String, dynamic>? query,
    String? token,
  }) async
  {

      dio!.options.headers =
      {
        'Accept': 'application/json',
        'Authorization' : 'Bearer ${token}'??'',
      };


      return dio!.post(
        url,
        queryParameters: query,
        data: data,
      );
    }

  static Future<Response> postDataImage({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async
  {

    dio!.options.headers =
    {
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${token}'??'',
    };


    return dio!.post(

      url,
      queryParameters: query,
      data: data,

    );
  }

}