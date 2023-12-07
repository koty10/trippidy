import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:trippidy/constants.dart';
import 'package:trippidy/model/dto/completed_transaction.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/model/dto/requests/suggestion_request.dart';
import 'package:trippidy/model/dto/requests/suggestion_response.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:trippidy/model/dto/user_profile.dart';
import 'package:trippidy/providers/auth_controller.dart';

import '../model/dto/item.dart';
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

  @DELETE("$tripsEndpoint/{tripId}")
  Future<HttpResponse<Trip>> deleteTrip(@Path("tripId") String tripId);

  @GET("$tripsEndpoint/{tripId}")
  Future<HttpResponse<Trip>> getTrip(@Path("tripId") String tripId);

  @PUT(itemsEndpoint)
  Future<HttpResponse<Item>> updateItem(@Body() Item item);

  @POST(itemsEndpoint)
  Future<HttpResponse<Item>> createItem(@Body() Item item);

  @DELETE("$itemsEndpoint/{itemId}")
  Future<HttpResponse<bool>> deleteItem(@Path("itemId") String itemId);

  @GET(userProfileEndpoint)
  Future<HttpResponse<UserProfile>> getUserProfile();

  @PUT(userProfileEndpoint)
  Future<HttpResponse<UserProfile>> updateUserProfile(@Body() UserProfile item);

  @GET("$userProfileEndpoint/{query}")
  Future<HttpResponse<List<UserProfile>>> getUserProfilesByQuery(@Path("query") String query, @Query("tripId") String tripId);

  @PUT(membersEndpoint)
  Future<HttpResponse<Member>> updateMember(@Body() Member item);

  @POST(membersEndpoint)
  Future<HttpResponse<Member>> createMember(@Body() Member item);

  @POST(completedTransactionsEndpoint)
  Future<HttpResponse<CompletedTransaction>> createCompletedTransaction(@Body() CompletedTransaction item);

  @POST(suggestEndpoint)
  Future<HttpResponse<SuggestionResponse>> suggestItems(@Body() SuggestionRequest item);
}
