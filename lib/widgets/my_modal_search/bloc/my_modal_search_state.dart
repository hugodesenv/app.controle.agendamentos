import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MyModalSearchState {}

class MyModalSearchStateInitial extends MyModalSearchState {}

/// when the modal is open and fetch all data
class MyModalSearchStateLoadingAll extends MyModalSearchState {}

/// when the data is loaded, returns the list
class MyModalSearchStateLoaded extends MyModalSearchState {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> data;

  MyModalSearchStateLoaded(this.data);
}

/// with the id passed, returns the description
class MyModalSearchStateLoadedById extends MyModalSearchState {
  final String description;

  MyModalSearchStateLoadedById(this.description);
}

/// when the data by id is loading (to show to user that data is loading)
class MyModalSearchStateLoadingById extends MyModalSearchState {}
