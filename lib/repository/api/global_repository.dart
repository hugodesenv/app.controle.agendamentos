abstract class GlobalRepository {
  Future<Map> delete(String id);

  Future<Map> save(data);

  Future<Map> update(data);

  Future<List> findAll();
}
