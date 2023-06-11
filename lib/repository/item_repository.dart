import 'package:agendamentos/model/product.dart';
import 'package:agendamentos/repository/firebase_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemRepository extends FirebaseRepository {
  ItemRepository._() : super(collection: 'product');

  static final instance = ItemRepository._();

  Future productSave(Product product) async {
    DocumentReference reference = getFireCloud.doc(product.id);
    await reference.set(product.toMap());
    return reference.id;
  }
}
