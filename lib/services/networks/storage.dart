import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class StorageProvider extends ChangeNotifier {

  final FirebaseStorage storage = FirebaseStorage.instance;

  bool isLoading = false;

  showHUD(value) {
    isLoading = value;
    notifyListeners();
  }


}