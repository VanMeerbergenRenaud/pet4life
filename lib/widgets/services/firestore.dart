import 'package:cloud_firestore/cloud_firestore.dart';

// async -> ne fait pas la même chose en même temps, cette fonction prend du temps

class FirestoreService {
  // get collection of animals
  final CollectionReference animalsCollection = FirebaseFirestore.instance.collection('animals');

  // CREATE animal
  Future<dynamic> createAnimal(String imageUrl, String name, Timestamp createdAt) {
    return animalsCollection.add({
      'imageUrl': imageUrl,
      'name': name,
      'createdAt': Timestamp.now(),
    });
  }

  // READ animal
  Stream<QuerySnapshot> getAnimals() {
    final animals = animalsCollection.orderBy('createdAt', descending: true).snapshots();
    return animals;
  }

  // UPDATE animal
  Future<dynamic> updateAnimal(String docID, String newImageUrl, String newName, Timestamp newCreatedAt) {
    return animalsCollection.doc(docID).update({
      'imageUrl': newImageUrl,
      'name': newName,
      'createdAt': Timestamp.now(),
    });
  }

  // DELETE animal
  Future<void> deleteAnimal(String docID) {
    return animalsCollection.doc(docID).delete();
  }
}