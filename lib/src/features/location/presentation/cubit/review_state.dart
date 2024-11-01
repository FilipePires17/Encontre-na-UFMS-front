part of 'review_cubit.dart';

enum ReviewStateStatus { initial, loading, loaded, error }

class ReviewState extends Equatable {
  const ReviewState({
    this.status = ReviewStateStatus.initial,
    this.rating = 0.0,
  });

  final ReviewStateStatus status;
  final double rating;

  ReviewState copyWith({
    ReviewStateStatus? status,
    double? rating,
  }) {
    return ReviewState(
      status: status ?? this.status,
      rating: rating ?? this.rating,
    );
  }

  @override
  List<Object> get props => [status, rating];
}
