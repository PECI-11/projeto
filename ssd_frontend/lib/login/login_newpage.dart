import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';

import '../features_empresa/features_empresa.dart';

class LoginNewPage extends StatelessWidget {
  const LoginNewPage({Key? key}) : super(key: key);
  static const String _title = 'Login';

  //This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
          leading: const BackButton(
            color: Colors.white,
          ),
        ),
        body: const LoginNewPageState(),
      ),
    );
  }
}

class LoginNewPageState extends StatefulWidget {
  const LoginNewPageState({Key? key}) : super(key: key);

  @override
  State<LoginNewPageState> createState() => _LoginNewPageState();
}

class _LoginNewPageState extends State<LoginNewPageState> {

  @override
  Widget build (BuildContext context) {

    return MaterialApp(
      home: PageScreen(),

    );

  }

}

class PageScreen extends StatefulWidget {
  const PageScreen({Key? key}) : super (key: key);

  @override
  _PageScreenState createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {

  // Initialize Firebase App
  Future<FirebaseApp> _initializeFirebase () async {

    FirebaseApp firebaseapp = await Firebase.initializeApp();
    return firebaseapp;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

}



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super (key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

  class _LoginScreenState extends State<LoginScreen> {

    // Login function
    static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user;

      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
          if (e.code == "user-not-found")
            print ("Não há nenhum utilizador para este endereço de email");
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {

      // create the textField controller
      TextEditingController _emailController = TextEditingController();
      TextEditingController _passwordController = TextEditingController();


    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Login Page",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Text(
            "Faça o login",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 30,
          ),

          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Mail do User",
              prefixIcon: Icon(Icons.mail, color: Colors.black),
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          TextField(
            controller: _passwordController,
            obscureText: true,
            //keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Password do User",
              prefixIcon: Icon(Icons.lock, color: Colors.black),
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          const Text("Não se recorda da Password?",
            style: TextStyle(
              color: Colors.blue
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          Container(
            width: double.infinity,
            child: RawMaterialButton(
                fillColor: Colors.blue,
                elevation: 0.0,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)
                ),
                onPressed: () async {
                  // test the app
                  User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                  print(user);
                  if (user != null) {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => FeaturesEmpresa())
                    );
                  }
                },
                child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                ),
            ),
          ),

        ],
      ),
    );
  }
}




