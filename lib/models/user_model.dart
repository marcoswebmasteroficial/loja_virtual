import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;

  Map<String, dynamic> userData = Map();
  bool isLoading = false;
static UserModel of(BuildContext context)=> ScopedModel.of<UserModel>(context);
  @override
  Future<void> addListener(VoidCallback listener) async {
    super.addListener(listener);
    await _loadCurrentUser();

  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback OnSucess,
      @required VoidCallback OnFail}) {
    isLoading = true;
    notifyListeners();
    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((AuthResult authResult) async {
      firebaseUser = authResult.user;

      isLoading = false;
      await _saveUserData(userData);
      OnSucess();
      notifyListeners();
    }).catchError((e) {
      OnFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback OnSucess,
      @required VoidCallback OnFail}) async {
    isLoading = true;
    notifyListeners();
 _auth.signInWithEmailAndPassword(email: email, password: pass).then((AuthResult authResult) async{
   firebaseUser = authResult.user;
   isLoading = false;
   await _loadCurrentUser();
   OnSucess();

   notifyListeners();
 }).catchError((e){
   OnFail();
   isLoading = false;
   notifyListeners();
 });
  }

  void recoverPass(@required String email) {
_auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }
  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }
  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .setData(userData);
  }
}
