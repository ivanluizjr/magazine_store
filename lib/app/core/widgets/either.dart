abstract class Either<L, R> {
  const Either();

  T fold<T>({
    required T Function(L) onLeft,
    required T Function(R) onRight,
  });
}

class Left<L, R> extends Either<L, R> {
  final L value;

  const Left(this.value);

  @override
  T fold<T>({
    required T Function(L) onLeft,
    required T Function(R) onRight,
  }) {
    return onLeft(value);
  }
}

class Right<L, R> extends Either<L, R> {
  final R value;

  const Right(this.value);

  @override
  T fold<T>({
    required T Function(L) onLeft,
    required T Function(R) onRight,
  }) {
    return onRight(value);
  }
}
