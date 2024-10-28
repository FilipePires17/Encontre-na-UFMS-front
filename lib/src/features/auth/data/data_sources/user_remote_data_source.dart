import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/api_urls.dart';
import '../../../../core/data/remote/http_manager.dart';
import '../dtos/user_dto.dart';

abstract class IUserRemoteDataSource {
  Future<Either<String, UserDto>> signInUser(String email, String password);
  Future<Either<String, UserDto>> registerUser({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Error, bool>> validateToken();
  Future<Either<Error, Response>> getCurrentUserInfo(String id);
  Future<Either<Error, Response>> sendVerificationEmail(String email);
  Future<Either<String, Response>> verifyRedefinitionCode(
      String email, String code);

  Future<Either<dynamic, UserDto>> editProfile({
    String? name,
    required String email,
    String? password,
  });
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
    return Left(response.statusMessage ?? 'Erro ao fazer login');
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
  Future<Either<Error, Response>> getCurrentUserInfo(id) async {
    final response = await httpClient.restRequest(
      url: '${ApiUrls.baseUser}/$id',
      method: HttpMethods.get,
    );

    if (response.statusCode == 200) {
      return Right(response);
    }
    return Left(response.data['message']);
  }

  @override
  Future<Either<String, UserDto>> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    final response = await httpClient.restRequest(
      url: ApiUrls.register,
      method: HttpMethods.post,
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
      hasToken: false,
    );

    if (response.statusCode == 201) {
      return Right(UserDto.fromMap(response.data['user']));
    }
    return Left(response.statusMessage ?? 'Erro ao fazer cadastro');
  }

  @override
  Future<Either<dynamic, UserDto>> editProfile(
      {String? name, required String email, String? password}) async {
    final response = await httpClient.restRequest(
      url: ApiUrls.editProfileUrl,
      method: HttpMethods.post,
      body: {
        if (name != null) 'name': name,
        'email': email,
        if (password != null) 'password': password,
      },
    );

    if (response.statusCode == 200) {
      return Right(UserDto.fromMap(response.data['user']));
    }
    return Left(response.data['message']);
  }

  @override
  Future<Either<Error, Response>> sendVerificationEmail(String email) async {
    final response = await httpClient.restRequest(
      url: ApiUrls.sendVerificationEmail,
      method: HttpMethods.post,
      body: {'email': email},
      hasToken: false,
    );

    if (response.statusCode == 200) {
      return Right(response);
    } else {
      return Left(Error());
    }
  }

  @override
  Future<Either<String, Response>> verifyRedefinitionCode(
      String email, String code) async {
    final response = await httpClient.restRequest(
      url: ApiUrls.verifyRedefinitionCode,
      method: HttpMethods.post,
      body: {
        'email': email,
        'token': code,
      },
      hasToken: false,
    );

    if (response.statusCode == 200) {
      return Right(response);
    } else {
      return const Left('');
    }
  }
}
