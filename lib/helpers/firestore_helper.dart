import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper_Firebase{
  
 Future getDocId() async{
  List<String> docIDs = [];
  await FirebaseFirestore.instance.collection('stores').where('favorite', isEqualTo: true).get().then((snapshot) => snapshot.docs.forEach((document) {
    print(document.reference);
    docIDs.add(document.reference.id);}));
    return docIDs;
 }
}
