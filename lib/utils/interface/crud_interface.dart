abstract class CrudInterface {
  Future<String> save(dynamic data);

  Future<void> fetchAllStream(Function(List data) onDataProcessed);

  Future<bool> delete(String id);
}
