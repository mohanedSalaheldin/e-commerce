import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce/core/utils/helpers/network/helpers/api_endpoints.dart';
import 'package:e_commerce/core/utils/shared/components/methods/app_methods.dart';

abstract class FavoritesApiCalls {
  Future<Unit> removeFavoritesItem(
      {required String token, required int productID});

  Future<List<dynamic>> getFavorites({required String token});
}

class FavoritesApiCallsImpl implements FavoritesApiCalls {
  final Dio _dio = Dio();

  @override
  Future<Unit> removeFavoritesItem(
      {required String token, required int productID}) async {
    try {
      await _dio.post(
        ApiEndPoints.baseURL + ApiEndPoints.favorites,
        queryParameters: {"product_id": productID},
        options: Options(
          headers: getAPIHeaders(token: token),
        ),
      );
      // print(response.data['message']);
      return unit;
    } on Exception {
      return unit;
    }
  }

  @override
  Future<List> getFavorites({required String token}) async {
    try {
      Response response = await _dio.get(
        ApiEndPoints.baseURL + ApiEndPoints.favorites,
        options: Options(headers:getAPIHeaders(token: token)),
      );
      dynamic responseMap = response.data['data'];
      if (responseMap == null) {
        return [];
      }
      return Future.value(responseMap['data']);
    } catch (e) {
      // print(e.toString());
      return [];
    }
  }
}
