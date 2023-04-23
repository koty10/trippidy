import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:trippidy/providers/auth_controller.dart';

class AuthInterceptor extends Interceptor {
  AuthController ref;
  AuthInterceptor(this.ref);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    log("onRequest started...");
    log(options.path);
    log(options.baseUrl);
    final token = ref.getIdToken();
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    options.headers.addAll(headers);
    super.onRequest(options, handler);
    log("onRequest finished...");
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    log("onError started...");
    if (err.response == null) {
      //super.onError(err, handler);
      return;
    }
    if (err.response!.statusCode == 401) {
      log("onError status code == 401");
      // Call your service method here
      await ref.refresh();
      log("onError refreshed");
      // Make the request again with the updated headers
      final newOptions = err.response!.requestOptions.copyWith(headers: {
        'Authorization': 'Bearer ${ref.getIdToken()}',
      });

      log("onError resolve...");
      // Return the new response
      handler.resolve(Response(requestOptions: newOptions));
    } else {
      log("onError next...");
      //handler.next(err);
      super.onError(err, handler);
    }
    log("onError resolve finished...");
  }
}
