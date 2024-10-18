import '../../../../core/platforms/network_info.dart';
import '../../domain/entities/search.dart';
import '../../domain/repos/i_search_repo.dart';
import '../datasource/remote_search_datasource.dart';

class SearchRepo implements ISearchRepo {
  const SearchRepo({
    required this.remoteSearchDatasource,
    required this.networkInfo,
  });

  final IRemoteSearchDatasource remoteSearchDatasource;
  final INetworkInfo networkInfo;

  @override
  Future<Search> searchByQuery(String query) async {
    if (await networkInfo.isConnected) {
      return remoteSearchDatasource.searchByQuery(query);
    } else {
      throw Error();
    }
  }
}
