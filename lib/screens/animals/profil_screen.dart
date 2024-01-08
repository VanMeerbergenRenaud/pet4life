import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/pet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/services/firestore.dart';
import '../main_screen.dart';
import 'create_screen.dart';
import '../../styles/spacings.dart';
import '../../styles/font.dart';
import '../../styles/colors.dart';
import '../../widgets/age_display.dart';
import '../../widgets/animals/profil_option.dart';

class PetProfileScreen extends StatefulWidget {
  const PetProfileScreen({required this.docID, super.key});

  final String docID;

  @override
  State<PetProfileScreen> createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late FirestoreService firestoreService;
  late Future<DocumentSnapshot> futureAnimal;

  @override
  void initState() {
    super.initState();
    firestoreService = FirestoreService(_auth.currentUser!.uid);
    futureAnimal = firestoreService.getAnimal(widget.docID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: futureAnimal,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          Pet data = snapshot.data!.data() as Pet;
          String name = data.name.capitalize();
          String imageUrl = data.imageUrl.toString();
          DateTime dob = DateTime.parse(data.dob.toString());
          String weight = data.weight.toString();
          String gender = data.gender.toString().capitalize();
          String race = data.race.toString().capitalize();
          // String vaccination = data.vaccination.toString();

          return Scaffold(
            appBar: AppBar(
              title: const Text('Profil de l‘animal'),
              // add action to modify the profil
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AnimalsPageScreenCreate(docID: widget.docID),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // image of the pet
                  imageUrl != ''
                      ? Image.network(
                          imageUrl,
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/img/default.png',
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                  Transform.translate(
                    offset: const Offset(0, -kPaddingL),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
                      child: Container(
                        padding: const EdgeInsets.all(kPaddingL * 2 / 3),
                        decoration: const BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                /*Expanded(
                                  child: Text(
                                    vaccination,
                                    style: kSmallTitle,
                                    textAlign: TextAlign.right,
                                  ),
                                ),*/
                              ],
                            ),
                            const SizedBox(height: kPaddingS),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  gender,
                                  style: kSmallTitle,
                                ),
                                AgeDisplay(dob: dob),
                                Text(
                                  race,
                                  style: kSmallTitle,
                                ),
                                Text(
                                  '${weight}kg',
                                  style: kSmallTitle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Nav links for other pages
                  Transform.translate(
                    offset: const Offset(0, -kPaddingL * 2 / 3),
                    child: const Column(
                      children: [
                        ProfilOption(
                          icon: Icons.heart_broken_sharp,
                          text: 'Rapport médicaux',
                          color: kSecondaryColor,
                        ),
                        ProfilOption(
                          icon: Icons.note_alt_rounded,
                          text: 'Notes de santé',
                          color: kYellow,
                        ),
                        ProfilOption(
                          icon: Icons.featured_play_list,
                          text: 'Liste des divers traitements',
                          color: kYellowLight,
                        ),
                        ProfilOption(
                          icon: Icons.checklist_sharp,
                          text: 'Liste des activités faites',
                          color: kBlueSoft,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreenPage(),
                            ),
                          );
                          await firestoreService.deleteAnimal(widget.docID);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: kWhite,
                          backgroundColor: kRed,
                        ),
                        child: Row(
                          children: [
                            Text('Supprimer $name'),
                            const SizedBox(width: kPaddingS),
                            const Icon(Icons.delete),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kPaddingL),
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: Text(
              'Aucun animal trouvé',
              style: kTitleStyle,
            ),
          );
        }
      },
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
