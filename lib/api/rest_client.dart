import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:trippidy/constants.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/model/trip.dart';
import 'package:trippidy/model/user_profile.dart';
import 'package:trippidy/providers/auth_controller.dart';

import '../model/item.dart';
import 'auth_interceptor.dart';

part 'rest_client.g.dart';

final restClientProvider = Provider((ref) {
  Dio dio = Dio();
  dio.interceptors.addAll([
    AuthInterceptor(ref.read(authControllerProvider.notifier)),
  ]);

  return RestClient(dio);
});

@RestApi(baseUrl: baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(tripsEndpoint)
  Future<HttpResponse<List<Trip>>> getTrips();

  @POST(tripsEndpoint)
  Future<HttpResponse<Trip>> createTrip(@Body() Trip item);

  @PUT(itemsEndpoint)
  Future<HttpResponse<Item>> updateItem(@Body() Item item);

  @POST(itemsEndpoint)
  Future<HttpResponse<Item>> createItem(@Body() Item item);

  @GET(userProfileEndpoint)
  Future<HttpResponse<UserProfile>> getUserProfile();

  @GET("$userProfileEndpoint/{query}")
  Future<HttpResponse<List<UserProfile>>> getUserProfilesByQuery(@Path("query") String query);

  @PUT(membersEndpoint)
  Future<HttpResponse<Member>> updateMember(@Body() Member item);

  @POST(membersEndpoint)
  Future<HttpResponse<Member>> createMember(@Body() Member item);
}
