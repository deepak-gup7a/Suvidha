import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mad_project/modals/items.dart';

class ItemDatabase{

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('Item');

  List<Item>itemListFromSnap(QuerySnapshot snap){
    return snap.docs.map((e){
      dynamic dt = Map<String, dynamic>.from(e.data());
      return Item(
        name: dt["name"],
        description: dt["description"],
        price: dt["price"],
        tags: dt["tags"].cast<String>()
      );
    }).toList();
  }



  Stream<List<Item>> get items {
    return collectionReference.snapshots()
        .map(itemListFromSnap);
  }

}