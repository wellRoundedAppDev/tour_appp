import 'package:firebase_storage/firebase_storage.dart';

final storage = FirebaseStorage.instance;
class Connection{
  final image;
  final path;
  Connection(this.image,this.path);
  static String? _downloadUrl;

  Future<void> fireStorageService(image,path) async {
    try {
      _downloadUrl = await storage.ref().child(path).child(image).getDownloadURL();
    }catch(e){
      print('image not found || $e');
    }
    }

  Future<String?> getData() async {
    try {
      await fireStorageService(image,path);
      return _downloadUrl;
    }catch(e){
      print('error in connection \n error : $e');
      return null;
    }
  }
}
