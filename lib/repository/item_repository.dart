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
  Future<String> save(data) async {
    DocumentReference doc = getFireCloud.doc(data.id);
    await doc.set(data.toMap());
    return doc.id;
  }

  @override
  Future<void> fetchAllStream(Function(List data) onDataProcessed) async {
    List<Item> items = [];

    await getFireCloud.snapshots().forEach((querySnapshot) async {
      items.clear();

      for (var doc in querySnapshot.docs) {
        var item = Item.fromJson(doc.data(), doc.id);
        items.add(item);
      }

      onDataProcessed(items);
    });
  }
}
