import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/delete_rating.dart';
import '../../domain/usecases/get_user_rating.dart';
import '../../domain/usecases/set_rating.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit({
    required this.setRating,
    required this.deleteRating,
    required this.getUserRating,
  }) : super(const ReviewState());

  final SetRating setRating;
  final DeleteRating deleteRating;
  final GetUserRating getUserRating;

  updateReview(int id, double rating) async {
    emit(state.copyWith(status: ReviewStateStatus.loading));

    await setRating.call(id: id, rating: rating).then((result) {
      result.fold(
        (error) => emit(state.copyWith(status: ReviewStateStatus.error)),
        (success) => emit(state.copyWith(
          status: ReviewStateStatus.loaded,
          rating: rating,
        )),
      );
    });
  }

  deleteReview(int id) async {
    emit(state.copyWith(status: ReviewStateStatus.loading));

    await deleteRating.call(id).then((result) {
      result.fold(
        (error) => emit(state.copyWith(status: ReviewStateStatus.error)),
        (success) => emit(state.copyWith(
          status: ReviewStateStatus.loaded,
          rating: 0,
        )),
      );
    });
  }

  getReview(int id) async {
    emit(state.copyWith(status: ReviewStateStatus.loading));

    await getUserRating.call(id).then((result) {
      result.fold(
        (error) => emit(state.copyWith(status: ReviewStateStatus.error)),
        (rating) => emit(state.copyWith(
          status: ReviewStateStatus.loaded,
          rating: rating,
        )),
      );
    });
  }
}
