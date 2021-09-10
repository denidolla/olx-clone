import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:olx/models/drawer.dart';
import 'package:olx/view/buttonNavigationScreens/home.dart';
import 'package:olx/view/buttonNavigationScreens/meusAnuncios.dart';
import 'package:olx/view/buttonNavigationScreens/perfil.dart';
import 'package:olx/view/buttonNavigationScreens/settings.dart';

class dash extends StatefulWidget {
  @override
  _dashState createState() => _dashState();
}

class _dashState extends State<dash> {

  FirebaseAuth auth = FirebaseAuth.instance;

  int indice = 0;
  List arraytelas =  [home(), meus(), perfil(), settings()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset("images/logo.png", width: 50),
        iconTheme: IconThemeData(
          color: Colors.deepPurple
        ),
      ),
      drawer: auth.currentUser?.uid != null
        ? drawer()
        : null,
      body: arraytelas[indice],
      bottomNavigationBar: Container(
          padding: EdgeInsets.only(left: 36, right: 36, bottom: 12),
          child: Container(
            height: 49,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.blueAccent,
            ),
            child: SafeArea(
              child: GNav(
                gap: 14,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 500),
                tabBackgroundColor: Colors.purpleAccent,
                color: Colors.white,
                tabs: [
                  GButton(
                    icon: Icons.home_rounded,
                    onPressed: (){
                      setState(() {
                        indice = 0;
                      });
                    },
                  ),

                  GButton(
                    icon: Icons.addchart_sharp,
                    onPressed: (){
                      setState(() {
                        indice = 1;
                      });
                    },
                  ),

                  GButton(
                    icon: Icons.person,
                    onPressed: (){
                      setState(() {
                        indice = 2;
                      });
                    },
                  ),

                  GButton(
                    icon: Icons.settings,
                    onPressed: (){
                      setState(() {
                        indice = 3;
                      });
                    },
                  ),

                ],
              ),
            ),
          )
      ),
    );
  }
}
