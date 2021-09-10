import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:olx/models/constantes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:olx/models/usuario.dart';
import 'package:validadores/Validador.dart';
import 'login.dart';
import 'package:async/async.dart';

class cadastrar extends StatefulWidget {
  const cadastrar({Key? key}) : super(key: key);
  @override
  _cadastrarState createState() => _cadastrarState();
}

class _cadastrarState extends State<cadastrar> {
  @override
  late user _user;
  void initState() {
    super.initState();
    _user = user();
  }
  final key = GlobalKey<FormState>();
  TextEditingController nomeCadastro = new TextEditingController();
  TextEditingController apelidoCadastro = new TextEditingController();
  TextEditingController emailCadastro = new TextEditingController();
  TextEditingController senhaCadastro1 = new TextEditingController();
  TextEditingController senhaCadastro2 = new TextEditingController();
  final picker = ImagePicker();
  late final _fotografia;

  //delay
  Future myFuture() async {
    await new Future.delayed(new Duration(seconds: 10));
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  _saveData() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("UsersList")
      .doc(_user.id)
      .set(_user.toMap());
  }

  _verificarSenhas () {
    if (senhaCadastro1.text == senhaCadastro2.text){
      _cadastrarLoading();
      _cadastrar();
    }
    else {
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                Icon(Icons.error_outline, color: Colors.red, size: 60), SizedBox(height: 8),
                Text("As senhas não combinam", style: TextStyle(fontSize: 24, fontFamily: 'times')), SizedBox(height: 10),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("     Tentar novamente     ", style: TextStyle(fontSize: 19, fontFamily: 'times')),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        }
      );
    }
  }

  _cadastrar () {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
      email: this.emailCadastro.text,
      password: this.senhaCadastro1.text
    );
    auth.signOut();
  }

  //pegar imagem
  void pegarImagem(ImageSource source) async{
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      _fotografia = File(pickedFile!.path);
    });
  }

  //bottomSheet
  void showBottomSheet (){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          color: Colors.white,
          height: 80,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      height: 45,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)
                        ),
                        padding: EdgeInsets.fromLTRB(35, 10, 35, 10),
                        onPressed: (){
                          pegarImagem(ImageSource.camera);
                          Navigator.of(context).pop();
                        },
                        color: Colors.white,
                        child: Row(
                          children: <Widget> [
                            Icon(Icons.photo_camera_rounded),
                            Text("   Camera", style: TextStyle(fontSize: 21, fontFamily: 'times'))
                          ],
                        ),
                      ),
                    ),
                  ), SizedBox(width: 10),

                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.only(right: 20),
                      height: 45,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)
                        ),
                        padding: EdgeInsets.fromLTRB(35, 10, 35, 10),
                        onPressed: (){
                          pegarImagem(ImageSource.gallery);
                          Navigator.of(context).pop();
                        },
                        color: Colors.white,
                        child: Row(
                          children: <Widget> [
                            Icon(Icons.photo),
                            Text("   Galeria", style: TextStyle(fontSize: 21, fontFamily: 'times'))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      }
    );
  }

  //dialog de loading
  _cadastrarLoading(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget> [
                SpinKitRipple(color: Colors.blue, size: 60,),SizedBox(height: 10),
                Text("Cadastrando . . .", style: TextStyle(fontSize: 17, fontFamily: 'times'),)
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset("images/logo.png", width: 50),
          iconTheme: IconThemeData(
            color: Colors.deepPurple
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(14, 10, 14, 32),
          child: Form(
            key: key,
            child: Column(
              children: <Widget> [
                //foto de perfil
                Row(
                  children: <Widget> [
                    GestureDetector(
                      child: Stack(
                        children: <Widget> [
                          CircleAvatar(
                              radius: 70,
                              backgroundImage: AssetImage("images/profile.jpg")
                          ),
                          Positioned(
                            bottom: 20,
                            right: 15,
                            child: Icon(Icons.photo_camera_rounded, size: 35, color: Colors.purpleAccent),
                          )
                        ],
                      ),
                      onTap: (){
                        showBottomSheet();
                      },
                    )
                  ],
                ),

                //Nome
                SizedBox(height: 15),
                TextFormField(
                  onSaved: (nome){
                    _user.nome = nome.toString();
                  },
                  validator: (texto){
                    return Validador().add(Validar.OBRIGATORIO, msg: 'Campo Obrigatorio').valido(texto);
                  },
                  controller: nomeCadastro,
                  keyboardType: TextInputType.emailAddress,
                  style: textos,
                  maxLength: 14,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      prefixIcon: Icon(Icons.person, color: Colors.purple),
                      hintText: "Primeiro nome",
                      hintStyle: hintTextos
                  ),
                ),SizedBox(height: 10),

                //sobrenome
                TextFormField(
                  onSaved: (sobrenome){
                    _user.apelido = sobrenome.toString();
                  },
                  validator: (texto){
                    return Validador().add(Validar.OBRIGATORIO, msg: 'Campo Obrigatorio').valido(texto);
                  },
                  controller: apelidoCadastro,
                  keyboardType: TextInputType.emailAddress,
                  style: textos,
                  maxLength: 14,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      prefixIcon: Icon(Icons.person, color: Colors.purple),
                      hintText: "Apelido",
                      hintStyle: hintTextos
                  ),
                ),SizedBox(height: 10),

                //email
                TextFormField(
                  onSaved: (email){
                    _user.email = email.toString();
                  },
                  validator: (texto){
                    return Validador().add(Validar.OBRIGATORIO, msg: 'Campo Obrigatorio').valido(texto);
                  },
                  controller: emailCadastro,
                  keyboardType: TextInputType.emailAddress,
                  style: textos,
                  maxLength: 30,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      prefixIcon: Icon(Icons.mail, color: Colors.purple),
                      hintText: "Digite o teu email",
                      hintStyle: hintTextos
                  ),
                ),SizedBox(height: 10),

                //senha
                TextFormField(
                  onSaved: (senha){
                    _user.senha = senha.toString();
                  },
                  validator: (texto){
                    return Validador().add(Validar.OBRIGATORIO, msg: 'Campo Obrigatorio').valido(texto);
                  },
                  controller: senhaCadastro1,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  style: textos,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      prefixIcon: Icon(Icons.lock, color: Colors.purple),
                      hintText: "Escolhe uma senha",
                      suffixIcon: Icon(Icons.remove_red_eye),
                      hintStyle: hintTextos
                  ),
                ),SizedBox(height: 10),

                //senha
                TextFormField(
                  validator: (texto){
                    return Validador().add(Validar.OBRIGATORIO, msg: 'Campo Obrigatorio').valido(texto);
                  },
                  controller: senhaCadastro2,
                  keyboardType: TextInputType.emailAddress,
                  style: textos,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      prefixIcon: Icon(Icons.lock, color: Colors.purple),
                      suffixIcon: Icon(Icons.remove_red_eye),
                      hintText: "Re-escreva a senha",
                      hintStyle: hintTextos
                  ),
                ),SizedBox(height: 20),

                RaisedButton(
                  color: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(136, 16, 136, 16),
                    child: Text("Cadastrar", style: TextStyle(fontSize: 20, fontFamily: 'times', fontWeight: FontWeight.bold)),
                  ),
                  onPressed: (){
                    if (key.currentState!.validate()) {
                      key.currentState!.save();
                      _saveData();
                      _verificarSenhas(); //verifica senhas e chama o metodo de cadastrar
                      myFuture();
                    }
                  },
                )
              ],
            ),
          ),
        )
    );
  }
  Widget BuildFileImage(){
    return Image.file(_fotografia);
  }
}
