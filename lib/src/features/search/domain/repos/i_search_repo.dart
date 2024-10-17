import '../entities/search.dart';

abstract class ISearchRepo {
  Future<Search> searchByQuery(String query);
}
