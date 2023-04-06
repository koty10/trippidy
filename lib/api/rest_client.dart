import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:trippidy/constants.dart';
import 'package:trippidy/model/trip.dart';
import 'package:trippidy/providers/auth_provider.dart';

import '../model/item.dart';
import 'auth_interceptor.dart';

part 'rest_client.g.dart';

final restClientProvider = Provider((ref) {
  Dio dio = Dio();
  dio.interceptors.addAll([
    AuthInterceptor(ref.read(authNotifierProvider.notifier)),
  ]);

  return RestClient(dio);
});

@RestApi(baseUrl: baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(tripsEndpoint)
  Future<HttpResponse<List<Trip>>> getTrips();

  @POST(itemsEndpoint)
  Future<HttpResponse<Item>> updateItem(@Body() Item item);
}
