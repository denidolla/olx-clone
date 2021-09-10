import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:olx/models/constantes.dart';
class perfil extends StatefulWidget {

  @override
  _perfilState createState() => _perfilState();
}

class _perfilState extends State<perfil> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: auth.currentUser?.uid == null
        ? Center(
          child: Text("Nenhum usuário logado", style: textos,),
        )
        : ListView(
          padding: EdgeInsets.all(8),
          children: <Widget> [
            Container(
              height: 250,
              width: double.infinity,
              //color: Colors.yellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage("images/profile.jpg"),
                  ), SizedBox(height: 10),
                  Text(FirebaseAuth.instance.currentUser!.email.toString(), style: TextStyle(fontSize: 21, color: Colors.grey, fontFamily: 'times'))
                ],
              )
            )
          ],
        )
    );
  }
}
