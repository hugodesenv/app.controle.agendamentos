abstract class CrudInterface {
  Future<String> save(dynamic data);

  Future<List<dynamic>> fetchAll();

  Future<bool> delete(String id);
}
