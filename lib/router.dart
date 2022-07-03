import 'package:flutter/material.dart';
import 'package:flutter_applicationtest/pages/appBar.dart';
import 'package:flutter_applicationtest/pages/login.dart';
import 'package:flutter_applicationtest/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_applicationtest/model/user.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Wrapper> createState() => WrapperS();
}

class WrapperS extends State<Wrapper> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context){
    final user = Provider.of<UserModel?>(context);
    if (user == null){
      return Scaffold(
        appBar: AppBar(
          title: const Text("Anmelden"),
        ),
        body: const SignIn(),
      );
    } else {
      return StreamProvider<UserModel>.value(
        value: AuthService().user,
        //catchError: (_,__) {},
        initialData: UserModel(UID: ""),
        child: const AppNavigation()
      );
    }
  }
}