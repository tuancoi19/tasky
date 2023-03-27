import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tasky/models/entities/notification/notification_entity.dart';
import 'package:tasky/models/entities/token_entity.dart';
import 'package:tasky/models/response/array_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  ///User
  @POST("/login")
  Future<TokenEntity> authLogin(@Body() Map<String, dynamic> body);

  @POST("/logout")
  Future<dynamic> signOut(@Body() Map<String, dynamic> body);

  /// Notification
  @GET("/notifications")
  Future<ArrayResponse<NotificationEntity>> getNotifications(
    @Query('page') int page,
    @Query('pageSize') int pageSize,
  );

}
