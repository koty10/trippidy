import 'package:dio/dio.dart';
import 'package:trippidy/providers/auth_provider.dart';

class AuthInterceptor extends Interceptor {
  AuthNotifier ref;
  AuthInterceptor(this.ref);

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // TODO: handle errors
    final token = await ref.getIdToken();
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    options.headers.addAll(headers);
    super.onRequest(options, handler);
  }
}
