import 'package:agendamentos/models/account.dart';
import 'package:agendamentos/repository/api/firebase_repository.dart';
import 'package:agendamentos/repository/api/global_repository.dart';
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

    var res = await dio.get(
      apiURL,
      data: {'fk_company': currentUser.company.id},
    );
    
    return {"data": {}};
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
