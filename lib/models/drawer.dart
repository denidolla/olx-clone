import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class drawer extends StatefulWidget {

  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {

  final email = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget> [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("images/profile.jpg")
                      )
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(email.toString(),
                    style: TextStyle(
                      fontSize: 21,
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'times',
                      color: Colors.black,
                      //fontWeight: FontWeight.bold
                    ),

                  ),
                )
              ],
            ),
            height: 230,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                    color: Colors.black,
                    width: 1
                )
              )
            )
          ),

          ListTile(
            leading: Icon(Icons.favorite, size: 25),
            title: Text(
              "Favoritos",
              style: TextStyle(
                  fontSize: 18
              ),
            ),
            onTap: (){},
          ),

          ListTile(
            leading: Icon(Icons.contact_page_outlined, size: 25),
            title: Text(
                "Privacidade",
                style: TextStyle(
                    fontSize: 18
                )
            ),
            onTap: (){},
          ),

          ListTile(
            leading: Icon(Icons.help_center, size: 25),
            title: Text(
                "Sobre Nós",
                style: TextStyle(
                    fontSize: 18
                )
            ),
            onTap: (){},
          ),

          Container(
            height: 1,
            color: Colors.grey,
          ),

          ListTile(
            leading: Icon(Icons.logout, size: 25, color: Colors.red),
            title: Text(
              "Sair",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.red
              ),
            ),
            onTap: (){},
          )

        ],
      ),
    );
  }
}
