import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jump_jump/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class PointsService {
//   String? username;

//   static savePoints({required int points, required String date, required String username})async{
//   await Firebase.initializeApp();
//   var db = FirebaseFirestore.instance;
//     final sessionData = <String, dynamic>{
//       "points": points,
//       "date": date,
//       "username": username
//     };
//     db.collection("points").add(sessionData);
//   }

//    Future<String?> getUsername() async{
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     var usernameString = prefs.getString('user');
//     username = usernameString;
//     return usernameString;
//   }
// }

class GameService {
  // Instância privada única da classe
  static final GameService _instance = GameService._internal();
  User? user;

  // Construtor privado
  GameService._internal();

  // Método estático para acessar a instância única
  factory GameService() {
    return _instance;
  }

  // Exemplo de método que o singleton pode ter
  static savePoints(
      {required int points,
      required String date,
      required String username}) async {
    await Firebase.initializeApp();
    var db = FirebaseFirestore.instance;
    final sessionData = <String, dynamic>{
      "points": points,
      "date": date,
      "username": username
    };
    db.collection("points").add(sessionData);
  }

  Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var usernameString = prefs.getString('user');
    var isInstagram = prefs.getBool('isInstagram');
    if (usernameString != null) {
      user = User(username: usernameString, isInstagram: isInstagram!);
      return user;
    }
    return null;
  }

  Future<void> setUser({required User user}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.username);
    prefs.setBool('isInstagram', user.isInstagram);
    user = user;
  }
}
