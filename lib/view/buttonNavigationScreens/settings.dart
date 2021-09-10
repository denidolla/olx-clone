import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class settings extends StatefulWidget {

  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {

  loginDialog(){
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context){
          return CupertinoAlertDialog(
            title: Text("Deseja sair ?", /*style: textos,*/),
            content: Text("Ao sair, o usuario sera deslogado"),
            actions: [
              CupertinoDialogAction(
                child: Text("Cancelar", style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text("Sair", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                onPressed: (){
                  Navigator.of(context).pop();
                  FirebaseAuth.instance.signOut();
                },
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
          padding: EdgeInsets.only(top: 14, left: 18, right: 18),
          children: [
            Text("Definições", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, fontFamily: 'times', color: Colors.blue)), SizedBox(height: 25),

            GestureDetector(
              onTap: (){},
              child: ListTile(
                leading: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue
                  ),
                  child: Icon(Icons.person, color: Colors.white,),
                ),
                title: Text("Alterar dados da conta", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text("Alterar dados tais como senha da conta, alterar a fotografia de perfil", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify),
                trailing: Icon(Icons.arrow_forward_ios_sharp, size: 20, color: Colors.grey),

              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 75, right: 15, top: 10, bottom: 5),
              child: Container(height: 1, color: Colors.grey,),
            ),

            GestureDetector(
              onTap: (){},
              child: ListTile(
                leading: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue
                  ),
                  child: Icon(Icons.notification_add, color: Colors.white,),
                ),
                title: Text("Central de notificacaoes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text("Defina o tipo de notificacoes que deseja receber da aplicacao", style: TextStyle(fontSize: 14,), textAlign: TextAlign.justify),
                trailing: Icon(Icons.arrow_forward_ios_sharp, size: 20, color: Colors.grey)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 75, right: 15, top: 10, bottom: 5),

            ),

            GestureDetector(
              onTap: (){},
              child: ListTile(
                leading: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue
                  ),
                  child: Icon(Icons.privacy_tip, color: Colors.white,),
                ),
                title: Text("Privacidade", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text("Regras e padroes adoptados para venda e compra de artigos na aplicacao", style: TextStyle(fontSize: 14,), textAlign: TextAlign.justify),
                trailing: Icon(Icons.arrow_forward_ios_sharp, size: 20, color: Colors.grey)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 75, right: 15, top: 10, bottom: 5),
              child: Container(height: 1, color: Colors.grey,),
            ),

            GestureDetector(
              onTap: (){},
              child: ListTile(
                leading: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue
                  ),
                  child: Icon(Icons.delete_forever, color: Colors.white,),
                ),
                title: Text("Apagar a conta", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Apague a tua conta, isso remove todos teus dados, incluindo seus anuncios", style: TextStyle(fontSize: 14), textAlign: TextAlign.justify),
                trailing: Icon(Icons.arrow_forward_ios_sharp, size: 20, color: Colors.grey)
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 75, right: 15, top: 10, bottom: 5),
              child: Container(height: 1, color: Colors.grey,),
            ),

            GestureDetector(
              onTap: (){
                loginDialog();
              },
              child: ListTile(
                leading: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red
                  ),
                  child: Icon(Icons.login, color: Colors.white,),
                ),
                title: Text("Sair", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text("Deslogar a conta", style: TextStyle(fontSize: 14),
                ),
                trailing: Icon(Icons.arrow_forward_ios_sharp, size: 20, color: Colors.grey)
              ),
            ),
          ],
        )
    );
  }
}
