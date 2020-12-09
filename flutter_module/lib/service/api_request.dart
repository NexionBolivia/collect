abstract class ApiRequest<T> {
  Future<Map> toMap();

  Future<T> fetch();
}
