import 'package:dio/dio.dart';

String baseUrl = 'https://laravel2.chefcoders.com/api/';
String chatUrl = 'ws://laravel2.chefcoders.com/app/chatapp_key';

class DioHelper {
  static late Dio dio;

  static init()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
            'Accept':'application/json',
            'Content-Type':'application/json'
          },
        connectTimeout:const Duration(  seconds: 60),
        receiveTimeout:  const Duration(  seconds: 60),
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
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
    required FormData data,
    Map<String, dynamic>? query,
    String? token,
    ProgressCallback? onSendProgress,

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
      onSendProgress: onSendProgress
    );
  }

}