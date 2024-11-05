import 'package:bloc/bloc.dart';

import '../../../multimedia/domain/entities/multimedia.dart';

class PhotosCubit extends Cubit<List<Multimedia>> {
  PhotosCubit() : super([]);

  void addPhoto(Multimedia photo) {
    final aux = (List<Multimedia>.from(state))..add(photo);
    emit(aux);
  }

  void removePhoto(int index) {
    final aux = (List<Multimedia>.from(state))..removeAt(index);
    emit(aux);
  }

  void resetPhotos() {
    emit([]);
  }
}
