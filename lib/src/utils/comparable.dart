mixin ComparableOperatorsMixin<T> on Comparable<T> {
  int getHashCode();

  @override
  bool operator ==(other) => other is T && compareTo(other as T) == 0;

  @override
  int get hashCode => getHashCode();

  bool operator <=(T other) => compareTo(other) <= 0;

  bool operator >=(T other) => compareTo(other) >= 0;

  bool operator <(T other) => compareTo(other) < 0;

  bool operator >(T other) => compareTo(other) > 0;
}
