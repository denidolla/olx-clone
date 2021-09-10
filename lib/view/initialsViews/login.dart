import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:olx/models/constantes.dart';
import 'package:olx/view/dashboard.dart';
import 'package:olx/view/initialsViews/cadastrar.dart';
import 'package:validadores/Validador.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class login extends StatefulWidget {
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {

  TextEditingController email = new TextEditingController();
  TextEditingController senha = new TextEditingController();
  final chave = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  _Logindialog(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              SpinKitRipple(color: Colors.purple, size: 40),SizedBox(height: 20),
              Text("Entrando . . .", style: TextStyle(fontSize: 17, fontFamily: 'times'),)
            ],
          ),
        );
      }
    );
  }

  _invalidPassDialog(){
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context){
          return CupertinoAlertDialog(
            title: Text("Senha ou usuário inválido", /*style: textos,*/),
            content: Text("Tem certeza de que a senha inserida esta correcta?"),
            actions: [
              CupertinoDialogAction(
                child: Text("Tentar novamente", /*style: TextStyle(fontSize: 21, fontFamily: 'times')*/),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

  _login(){
    _Logindialog();
    //FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
      email: this.email.text,
      password: this.senha.text
    ).then((valor){
      Navigator.of(context).pop(); //Fechar o Dialog de Loading
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => dash()
        )
      );
    }).catchError((error){
      Navigator.of(context).pop(); //Fechar o Dialog de Loading
      _invalidPassDialog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset("images/logo.png", width: 50),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(32, 1, 32, 32),
        child: Form(
          key: chave,
          child: Column(
            children: <Widget> [
              Image.asset("images/logo.png", width: 200),

              TextFormField(
                validator: (valor){
                  return Validador().add(Validar.OBRIGATORIO, msg: "Campo Obrigatorio").valido(valor);
                },
                controller: email,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black, fontFamily: 'times', fontSize: 19),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    prefixIcon: Icon(Icons.mail, color: Colors.deepOrange),
                    hintText: "Digite o teu email",
                    hintStyle: TextStyle(color: Colors.black, fontFamily: 'times', fontSize: 19)
                ),
              ),SizedBox(height: 10),

              TextFormField(
                validator: (valor){
                  return Validador().add(Validar.OBRIGATORIO, msg: "Campo Obrigatorio").valido(valor);
                },
                controller: senha,
                keyboardType: TextInputType.emailAddress,
                style: textos,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    prefixIcon: Icon(Icons.lock, color: Colors.deepOrange),
                    hintText: "Digite a senha",
                    hintStyle: textos
                ),
              ),SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget> [
                  GestureDetector(
                    child: Text("cadastrar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'times', color: Colors.purple)),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return cadastrar();
                              }
                          )
                      );
                    },
                  )
                ],
              ),SizedBox(height: 10),

              RaisedButton(
                color: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(133, 14, 133, 14),
                  child: Text("Entrar", style: TextStyle(fontSize: 19, fontFamily: 'times', fontWeight: FontWeight.bold)),
                ),
                onPressed: (){
                  if (chave.currentState!.validate()){
                    _login();
                  }
                },
              ),SizedBox(height: 5),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Text("Ou", style: TextStyle(fontSize: 17, fontFamily: 'times'),)
                ],
              ),SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  GestureDetector(
                    onTap: (){},
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("images/icons/gmail.png"),
                    ),
                  ), SizedBox(width: 10),

                  GestureDetector(
                    onTap: (){},
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("images/icons/facebook.png"),
                    ),
                  ), SizedBox(width: 10),

                  GestureDetector(
                    onTap: (){},
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("images/icons/twitter.png"),
                    ),
                  ), SizedBox(width: 10),


                ],
              ), SizedBox(height: 10),

            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(25),
        ),
      ),
    );
  }
}
