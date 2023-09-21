import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class PickedImage extends ChangeNotifier {
  // Declare the picked image file
  File? pickedImage;
  String? downloadURL;
  // String? imgpath;
  // Picked from Gallery
  Future<void> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      // String fileName = (pickedImage!.path);
      // FirebaseStorage.instance.ref().child(fileName);
      uploadImageToFirebase();
      notifyListeners();
    }
  }

  // Picked from Camera
  Future<void> pickedImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      // String fileName = (pickedImage!.path);
      pickedImage = File(pickedFile.path);
      uploadImageToFirebase();
      // FirebaseStorage.instance.ref().child(fileName);
      notifyListeners();
    }
  }

  Future<void> uploadImageToFirebase() async {
    try {
      String fileName = DateTime.now()
          .millisecondsSinceEpoch
          .toString(); // Generate a unique filename
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('userImages')
          .child('$fileName.jpg');
      await storageReference.putFile(File(pickedImage!.path));
      // Get the download URL for the uploaded image
      downloadURL = await storageReference.getDownloadURL();
      print("Image uploaded: $downloadURL");
    } catch (error) {
      print("Error uploading image: $error");
    }
  }

  // Save Image to Shared pref
  // Future<void> saveImageToFirebase() async {
  //   // final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String fileName = (pickedImage!.path);
  //   FirebaseStorage.instance.ref().child(fileName);
  //   // prefs.setString('img', value);
  //   // notifyListeners();
  //   getImageFromShared();
  // }

  //Get image from shared
  // Future<void> getImageFromShared() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   imgpath = prefs.getString('img');
  //   if (imgpath != null) {
  //     pickedImage = File(imgpath!);
  //     notifyListeners();
  //   }
  // }

  Future<void> deleteImage() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    // im = null;
    pickedImage = null;
    notifyListeners(); // Notify listeners after deleting the image
  }
}
