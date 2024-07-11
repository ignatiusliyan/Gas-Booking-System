import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication{

  final FirebaseAuth _auth= FirebaseAuth.instance;

  Future<User?> signUpUserWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch(e){
      print('Error Occured');
    }
    return null;
  }

  Future<User?> logInUserWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    }catch(e){
      print('Error Occured');
    }
    return null;
  }

  User? currentuser()
  {
    User? user =FirebaseAuth.instance.currentUser;
    return user;
  }

  FirebaseAuth getFirebaseInstance(){
    return FirebaseAuth.instance;
  }
  void signOut(){
    try{
      FirebaseAuth.instance.signOut();
    }
    catch(e){
      print('Signout Error');
    }
  }
}