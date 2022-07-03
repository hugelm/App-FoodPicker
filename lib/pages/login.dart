import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/pages/loading.dart';
import 'package:flutter_applicationtest/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({ Key? key }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  String error = "";

  bool loading = false;

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
   return loading ? Loading() : Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Image.asset('assets/icons/logo.jpg', height: 300, width: 300),
            /*
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'get some stuff',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            */
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Hol dir deinen Snack!',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                obscureText: true,
                controller: pwdController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Passwort',
                ),
              ),
            ),
            Text(
                  error,
                  style: TextStyle(color: Colors.red),
                ),
            const SizedBox(height: 20),
            /*
            TextButton(
              onPressed: () async {
                setState(() => { loading = true});
                dynamic res = await _auth.signInAnonymous();
                if (res==null){
                  print("error signing in");
                  setState(() => { loading = false});
                } else {
                  print("singned in");
                }
              },
              child: const Text('als Gast anmelden',),
            ),
            */
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    setState(() => { loading = true});
                    dynamic res = await _auth.signInWithEmailAndPassowrd(nameController, pwdController);
                    if (res==null){
                        print("error signing in");
                        setState(() => { loading = false});
                        setState(() => error = "E-Mail oder Passwort ist falsch.");
                    } else {
                        print("singned in");
                    }
                  },
                )
            ),
            Row(
              children: <Widget>[
                const Text('Noch keinen Account?'),
                TextButton(
                  child: const Text(
                    'Jetzt registieren',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    if (nameController.text == "" || pwdController.text.length < 6){
                        setState(() => error = "Das Passwort muss min. 6 Zeichen enthalten.");
                    } else {
                        setState(() => {loading = true});
                        dynamic res = await _auth.registerWithEmailAndPassowrd(nameController, pwdController);
                        if (res==null){
                          print("registration failed");
                          setState(() => { loading = false});
                          setState(() => error = "Die eingegebene E-Mail ist ungültig.");
                        } else {
                          print("registration successful");
                        }
                    }
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}