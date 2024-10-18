import '../repos/i_search_repo.dart';

class SearchByQuery {
  final ISearchRepo repo;

  const SearchByQuery({required this.repo});

  Future<void> call(String query) async {
    await repo.searchByQuery(query);
  }
}
