abstract interface class INetworkService {
  void init();

  Future<dynamic> get(String endpoint, data);
  Future<dynamic> put(String endpoint, data);
  Future<dynamic> post(String endpoint, data);
  Future<dynamic> delete(String endpoint, data);
}
