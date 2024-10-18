import '../../../../core/data/remote/http_manager.dart';
import '../../domain/entities/search.dart';

abstract class IRemoteSearchDatasource {
  Future<Search> searchByQuery(String query);
}

class RemoteSearchDatasource implements IRemoteSearchDatasource {
  const RemoteSearchDatasource({required this.httpClient});

  final HttpManager httpClient;

  @override
  Future<Search> searchByQuery(String query) {
    // TODO: implement searchByQuery
    throw UnimplementedError();
  }
}
