import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get collection of animals
  final CollectionReference animalsCollection = FirebaseFirestore.instance.collection('animals');

  // CREATE animal
  Future<void> createAnimal(String name, String imageUrl, createdAt) {
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

  // DELETE animal

}