import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/pet.dart';

// async -> ne fait pas la même chose en même temps, cette fonction prend du temps
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final String _userId;

  FirestoreService(userId) {
    _userId = userId;
  }

  CollectionReference<Pet> get animalsCollection => _firestore
      .collection('users')
      .doc(_userId)
      .collection('pets')
      .withConverter<Pet>(
        fromFirestore: (snapshot, _) => Pet.fromJson(snapshot.data()!),
        toFirestore: (pet, _) => pet.toJson(),
      );

  // CREATE animal
  void createAnimal(Pet currentPet) async {
    await animalsCollection.add(currentPet);
  }

  // READ animals
  Stream<QuerySnapshot<Pet>> getAnimals() {
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
      DateTime newDob,
      double newWeight,
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
