import 'package:cloud_firestore/cloud_firestore.dart';

// async -> ne fait pas la même chose en même temps, cette fonction prend du temps

class FirestoreService {
  final CollectionReference animalsCollection = FirebaseFirestore.instance.collection('animals');

  // CREATE animal
  Future<dynamic> createAnimal(
    String imageUrl,
    String name,
    String dob,
    String weight,
    String gender,
    String race,
    String vaccination,
    Timestamp createdAt,
  ) {
    return animalsCollection.add({
      'imageUrl': imageUrl,
      'name': name,
      'dob': dob,
      'weight': weight,
      'gender': gender,
      'race': race,
      'vaccination': vaccination,
      'createdAt': Timestamp.now(),
    });
  }

  // READ animals
  Stream<QuerySnapshot> getAnimals() {
    final animals = animalsCollection.orderBy('createdAt', descending: true).snapshots();
    return animals;
  }

  // READ animal
  Future<DocumentSnapshot> getAnimal(String docID) {
    final animal = animalsCollection.doc(docID).get();
    return animal;
  }

  // UPDATE animal
  Future<dynamic> updateAnimal(
      String docID,
      String newImageUrl,
      String newName,
      String newDob,
      String newWeight,
      String newGender,
      String newRace,
      String newVaccination,
      Timestamp newCreatedAt) {
    return animalsCollection.doc(docID).update({
      'imageUrl': newImageUrl,
      'name': newName,
      'dob': newDob,
      'weight': newWeight,
      'gender': newGender,
      'race': newRace,
      'vaccination': newVaccination,
      'createdAt': Timestamp.now(),
    });
  }

  // DELETE animal
  Future<void> deleteAnimal(String docID) {
    return animalsCollection.doc(docID).delete();
  }
}
