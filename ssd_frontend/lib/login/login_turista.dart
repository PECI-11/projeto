import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../features_empresa/features_empresa.dart';

class LoginTurista extends StatelessWidget {
  const LoginTurista({Key? key}) : super(key: key);
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
        body: const LoginTuristaState(),
      ),
    );
  }
}

class LoginTuristaState extends StatefulWidget {
  const LoginTuristaState({Key? key}) : super(key: key);

  @override
  State<LoginTuristaState> createState() => _LoginTuristaState();
}



class _LoginTuristaState extends State<LoginTuristaState> {

  // Login function
  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
      print('Login done');
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found")
        print ("Não há nenhum utilizador para este endereço de email");
    }
    return user;
  }

  // Initialize Firebase App
  Future<FirebaseApp> _initializeFirebase () async {

    FirebaseApp firebaseapp = await Firebase.initializeApp();
    return firebaseapp;

  }

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text('Forgot Password',),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: Text('LOGIN'),
                  onPressed: () async {
                    User? user = await loginUsingEmailPassword(email: emailController.text, password: passwordController.text, context: context);
                    print(user);
                    print(emailController.text);
                    print(passwordController.text);
                    if (user != null) {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => FeaturesEmpresa())
                      );
                    }
                  },
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
            ),
          ],
        ));
  }
}