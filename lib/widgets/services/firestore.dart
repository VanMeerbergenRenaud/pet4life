import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/pet.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  void createAnimal(Pet currentPet) async {
    await animalsCollection.add(currentPet);
  }

  Stream<QuerySnapshot<Pet>> getAnimals() {
    final animals =
        animalsCollection.orderBy('createdAt', descending: true).snapshots();
    return animals;
  }

  Future<DocumentSnapshot> getAnimal(String docID) {
    final animal = animalsCollection.doc(docID).get();
    return animal;
  }

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

  Future<void> deleteAnimal(String docID) {
    return animalsCollection.doc(docID).delete();
  }

  Future<String> uploadImageToFirebase(Uint8List file) async {
    Reference ref = FirebaseStorage.instance.ref().child('petImage');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> saveData({required Uint8List file}) async {
    String resp = "Something went wrong";
    try {
      String imageUrl = await uploadImageToFirebase(file);
      await _firestore.collection('pets').add({
        'imageUrl': imageUrl,
      });
      resp = "Data saved successfully";
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
