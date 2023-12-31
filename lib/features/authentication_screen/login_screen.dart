import 'package:all_events_practical/features/dashboard_screen/dashboard_screen.dart';
import 'package:all_events_practical/shared_preference/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSignedInValue = false;

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.white,
            ],
          ),
        ),
        child: Card(
          margin:
              const EdgeInsets.only(top: 200, bottom: 200, left: 30, right: 30),
          elevation: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "All Events",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              InkWell(
                // by onpressed we call the function signup function
                onTap: () {
                  handleSignIn(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blue[300],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/googleImage.png'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text("Sign In with Google")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkSignInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isSignedIn = prefs.getBool('is_signed_in') ?? false;
    setState(() {
      isSignedInValue = isSignedIn;
    });

    if (isSignedInValue) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()));
    }
  }

  // function to implement the google signin
  Future<void> handleSignIn(BuildContext context) async {
    // creating firebase instance
    final FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      // Store user information in SharedPreferences
      await SharedPreferenceController.storeUserInfo(
        googleSignInAccount.displayName ?? '',
        googleSignInAccount.email ?? '',
      );

      // Update sign-in status
      setState(() {
        isSignedInValue = true;
      });

      if (result != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()));
      } // if result not null we simply call the Material pageRoute,for go to the Dashboard screen

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blue,
          content: Text(
            'Login successfully',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      //the user cancelled the sign-in
      print('User cancelled sign-in');
      return;
    }
  }
}
