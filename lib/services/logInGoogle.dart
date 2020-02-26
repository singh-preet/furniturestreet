import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class SignIn{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid, email, phoneNumber, displayName, photoUrl;

  Future<FirebaseUser> handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print(user.email);
    print("signed in " + user.email);
//    print(user.uid + user.email+ user.phoneNumber+ user.displayName);
    return user;
  }

  Future handleSignOut() async{
    _googleSignIn.signOut().whenComplete(()=>print('You have been signed out'));
  }

}