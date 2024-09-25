import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../../core/data/remote/http_manager.dart';
import '../dtos/user_dto.dart';

abstract class IUserRemoteDataSource {
  Future<Either<String, UserDto>> signInUser(String email, String password);
  Future<Either<Error, bool>> validateToken();
  Future<Either<String, Response>> getCurrentUser();
  Future<Either<Error, Response>> getCurrentUserInfo(String id);
  Future<Either<Error, Response>> changePassword(String password);
  Future<Either<Error, Response>> sendVerificationEmail(String email);
  Future<Either<Error, Response>> verifyRedefinitionCode(
      String email, String code);
  // Future<Either<dynamic, String>> refreshToken();
}

class UserRemoteDataSource implements IUserRemoteDataSource {
  final HttpManager httpClient;

  UserRemoteDataSource({required this.httpClient});

  @override
  Future<Either<String, UserDto>> signInUser(
      String email, String password) async {
    final response = await httpClient.restRequest(
      url: ApiUrls.signIn,
      method: HttpMethods.post,
      body: {
        'email': email,
        'password': password,
      },
      hasToken: false,
    );

    if (response.statusCode == 200) {
      return Right(UserDto.fromMap(response.data['user']));
    }
    return Left(response.data['error']);
  }

  @override
  Future<Either<Error, bool>> validateToken() async {
    final isValidated = await httpClient.restRequest(
      url: ApiUrls.validateUrl,
      method: HttpMethods.get,
    );
    if (isValidated.statusCode == 200) {
      return const Right(true);
    } else if (isValidated.statusCode == 401) {
      return const Right(false);
    }
    return Left(Error());
  }

  @override
  Future<Either<String, Response>> getCurrentUser() async {
    // final response = await httpClient.restRequest(
    //   url: ApiUrls.getLoggedUserUrl,
    //   method: HttpMethods.get,
    // );
    // if (response.statusCode == 200) {
    //   return Right(response);
    // }
    // return Left(response.statusMessage ?? 'Token inválido');

    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Error, Response>> getCurrentUserInfo(id) async {
    // final response = await httpClient.restRequest(
    //   url: '${ApiUrls.getUserInfoUrl}/$id',
    //   method: HttpMethods.get,
    // );

    // if (response.statusCode == 200) {
    //   return Right(response);
    // }
    // return Left(response.data['message']);

    // TODO: implement getCurrentUserInfo
    throw UnimplementedError();
  }

  @override
  Future<Either<Error, Response>> changePassword(String password) async {
    // final response = await httpClient.restRequest(
    //   url: ApiUrls.changePasswordUrl,
    //   method: HttpMethods.put,
    //   parameters: {'password': password},
    // );
    // if (response.statusCode == 200) {
    //   return Right(response);
    // }
    // return Left('message');

    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Error, Response>> sendVerificationEmail(String email) async {
    // final response = await httpClient.restRequest(
    //   url: ApiUrls.sendVerificationEmail,
    //   method: HttpMethods.post,
    //   parameters: {'email': email},
    //   hasToken: false,
    // );

    // if (response.statusCode == 200) {
    //   return Right(response);
    // } else {
    //   return Left(response);
    // }

    // TODO: implement sendVerificationEmail
    throw UnimplementedError();
  }

  @override
  Future<Either<Error, Response>> verifyRedefinitionCode(
      String email, String code) async {
    // final response = await httpClient.restRequest(
    //   url: ApiUrls.verifyRedefinitionCodeUrl,
    //   method: HttpMethods.post,
    //   body: {
    //     'email': email,
    //     'code': code,
    //   },
    //   hasToken: false,
    // );

    // if (response.statusCode == 200) {
    //   return Right(response);
    // } else {
    //   return Left(response);
    // }

    // TODO: implement verifyRedefinitionCode
    throw UnimplementedError();
  }

  // @override
  // Future<Either<dynamic, String>> refreshToken() async {
  //   final response = await httpClient.restRequest(
  //     url: ApiUrls.refreshToken,
  //     method: HttpMethods.get,
  //     hasToken: false,
  //     isRefreshToken: true,
  //   );

  //   if (response.statusCode == 200) {
  //     return Right(response.data['token']);
  //   } else {
  //     return Left(response.data['message']);
  //   }
  // }
}
