
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:genie/models/user%20model.dart';

import 'api.dart';

class FirebaseFunctions {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final APImanager _apiManager = APImanager();

  Future<String?> uploadImageToFirebase(File? image) async {
    if (image == null) return null;

    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageRef = _storage.ref().child('images/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);

      TaskSnapshot snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        String downloadUrl = await snapshot.ref.getDownloadURL();
        String userId = FirebaseAuth.instance.currentUser!.uid; // Get current user ID
        String caption = await _apiManager.generateCaption(image);

        await _firestore.collection('images').add({
          'url': downloadUrl,
          'userId': userId,
          'caption': caption,// Add user ID to Firestore document
        });

        print("Upload successful: $downloadUrl");
        print("Caption: $caption");

        return downloadUrl;
      } else {
        print('Upload task failed with state: ${snapshot.state}');
        return null;
      }
    } catch (e) {
      print('Failed to upload image: $e');
      return null;
    }
  }

  Future<List<String>> getImagesFromFirestore() async {
    List<String> imageUrls = [];

    try {
      QuerySnapshot querySnapshot = await _firestore.collection('images').get();
      for (var doc in querySnapshot.docs) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          if (data.containsKey('url')) {
            imageUrls.add(data['url']);
          }
        }
      }
    } catch (e) {
      print('Failed to fetch images: $e');
    }

    return imageUrls;
  }


  CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }

  Future<void> addUser(UserModel user) {
    var collection = getUsersCollection();
    var docRef = collection.doc(user.id);
    return docRef.set(user);
  }

  creatAccount({required String email,
    required String password,
    required String userName,
    required String phone,
    required Function onSuccess,
    required Function onError}) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.sendEmailVerification();
      UserModel usermodel = UserModel(id: credential.user!.uid,
          email: email,
          userName: userName,
          phone: phone);
      await addUser(usermodel);
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(e.message);
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError(e.message);
        print('The account already exists for that email.');
      }
      onError(e.message);
    } catch (e) {
      print(e);
      onError(e.toString());
    }
  }

  login(String email, String password, Function onSuccess,
      Function onError) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // if (credential.user!.emailVerified) {
      onSuccess();
      // }
      // else {onError("please verify your account");}
    } on FirebaseAuthException catch (e) {
      onError(e.code);
    }
  }


  Future<UserModel?> readUser() async {
    String id = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot<UserModel> documentSnapshot =
    await getUsersCollection().doc(id).get();
    return documentSnapshot.data();
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

