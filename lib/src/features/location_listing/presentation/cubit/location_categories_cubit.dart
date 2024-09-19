import 'package:bloc/bloc.dart';

import '../../domain/enums/enum_location.dart';

class LocationCategoriesCubit extends Cubit<List<EnumLocation>> {
  LocationCategoriesCubit() : super([]);

  updateCategories(EnumLocation category) {
    final Set<EnumLocation> currentCategories = Set.from(state);
    if (currentCategories.contains(category)) {
      currentCategories.remove(category);
    } else {
      currentCategories.add(category);
    }
    emit(List.from(currentCategories));
  }

  clearCategories() {
    emit([]);
  }
}
