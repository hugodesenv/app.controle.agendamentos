import 'package:agendamentos/interface/crud_interface.dart';
import 'package:agendamentos/model/item.dart';
import 'package:agendamentos/repository/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemRepository extends FirebaseRepository implements CrudInterface {
  ItemRepository._() : super(collection: 'item');

  static final instance = ItemRepository._();

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<dynamic>> fetchAll() async {
    var collections = await getFireCloud.get();

    List<Item> items = [];
    for (var doc in collections.docs) {
      var item = Item.fromJson(doc.data(), doc.id);
      items.add(item);
    }

    return items;
  }

  @override
  Future<String> save(data) async {
    DocumentReference reference = getFireCloud.doc(data.id);
    await reference.set(data.toMap());
    return reference.id;
  }
}
