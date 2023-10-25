import 'package:agendamentos/models/account.dart';
import 'package:agendamentos/models/item.dart';
import 'package:agendamentos/repository/firebase_repository.dart';
import 'package:agendamentos/repository/global_repository.dart';
import 'package:agendamentos/utils/preferences_util.dart';

class ItemRepository extends FirebaseRepository implements GlobalRepository {
  ItemRepository._() : super(controller_name: 'item');

  static final instance = ItemRepository._();

  @override
  Future<Map> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Map> findAll() async {
    Account currentUser = await PreferencesUtil.getPrefsCurrentUser();
    List<Item> items = [];

    var res = await dio.get(
      apiURL,
      data: {
        'company_id': currentUser.company.id,
        'active': true,
      },
    );

    for (var data in res.data) {
      Item item = Item.fromJson(data);
      items.add(item);
    }

    items.sort((a, b) => a.description.compareTo(b.description));

    return {'items': items};
  }

  @override
  Future<Map> save(data) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<Map> update(data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
