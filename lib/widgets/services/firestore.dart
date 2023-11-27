import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  // get collection of animals
  final CollectionReference animalsCollection = FirebaseFirestore.instance.collection('animals');

  // CREATE animal
  Future<void> createAnimal(String name, String description, String imageUrl) {
    return animalsCollection.add({
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    });
  }

  // READ animal

  // UPDATE animal

  // DELETE animal

}