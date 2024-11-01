import 'package:fpdart/fpdart.dart';

import '../../../../core/platforms/network_info.dart';
import '../../domain/entities/location.dart';

import '../../domain/entities/sections.dart';
import '../../domain/enums/enum_sections.dart';
import '../../domain/repos/i_location_repo.dart';
import '../datasource/remote_location_datasource.dart';

class LocationRepo implements ILocationRepo {
  const LocationRepo({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  final IRemoteLocationDatasource remoteDataSource;
  final INetworkInfo networkInfo;

  @override
  Future<Either<String, Location>> getLocation({required int id}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.getLocation(id: id);
      return result.fold(
        (error) => Left(error),
        (location) => Right(location),
      );
    } else {
      return const Left('Sem conexão com a internet');
    }
  }

  @override
  Future<Either<Error, bool>> setRating(
      {required int id, required double rating}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.setRating(id: id, rating: rating);
      return result.fold(
        (error) => Left(error),
        (success) => Right(success),
      );
    } else {
      return Left(Error());
    }
  }

  @override
  Future<Either<String, bool>> toggleFavorite({required int id}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.toggleFavorite(id: id);
      return result.fold(
        (error) => Left(error),
        (success) => Right(success),
      );
    } else {
      return const Left('Sem conexão com a internet');
    }
  }

  @override
  Future<Either<String, Section>> getSection(
      {required int id, required EnumSections section}) async {
    if (await networkInfo.isConnected) {
      final result =
          await remoteDataSource.getSection(id: id, section: section);
      return result.fold(
        (error) => Left(error),
        (section) => Right(section),
      );
    } else {
      return const Left('Sem conexão com a internet');
    }
  }

  @override
  Future<Either<String, bool>> deleteRating({required int id}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.deleteRating(id: id);
      return result.fold(
        (error) => Left(error),
        (success) => Right(success),
      );
    } else {
      return const Left('Sem conexão com a internet');
    }
  }

  @override
  Future<Either<String, double>> getUserRating({required int id}) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.getUserRating(id: id);
      return result.fold(
        (error) => Left(error),
        (rating) => Right(rating),
      );
    } else {
      return const Left('Sem conexão com a internet');
    }
  }
}
