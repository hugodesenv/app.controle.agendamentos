import 'package:agendamentos/models/item.dart';
import 'package:agendamentos/repository/firebase_repository.dart';
import 'package:agendamentos/utils/preferences_util.dart';

class ItemRepository extends FirebaseRepository implements CrudRepository {
  ItemRepository._() : super(controller_name: 'item');
  static final instance = ItemRepository._();

  @override
  Future<Map> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Map> findAll() async {
    final currentUser = await PreferencesUtil.usuarioAtual();
    final res = await dio.get(
      apiURL,
      data: {'company_id': currentUser.empresa.id},
    );

    List<Item> items = [];
    for (var data in res.data) {
      Item item = Item.fromJson(data);
      items.add(item);
    }

    items.sort((a, b) => a.description.compareTo(b.description));

    return {'itens': items};
  }

  @override
  Future<Map> save(data) async {
    Item item = data as Item;
    final res = await dio.post(apiURL, data: item.toJson());
    return {'dados': res.data};
  }

  @override
  Future<Map> update(data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
