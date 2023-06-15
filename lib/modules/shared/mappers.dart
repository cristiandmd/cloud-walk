extension Any<T> on T? {
  U? map<U>(U Function(T) mapper) {
    if (this != null) {
      return mapper(this as T);
    }
    return null;
  }

  U mapTo<U>() {
    return this as U;
  }
}

extension AnyMap on Map<String, dynamic> {
  T mapKey<T>(String key) {
    return this[key] as T;
  }
}
