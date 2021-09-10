import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class user{
  late String _id;
  late String _nome;
  late String _apelido;
  late String _email;
  late String _senha;
  List _fotos = <String> [];

  user(){
    _userpegarID();
  }

  _userpegarID() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference user = db.collection("Usuarios");
    this.id = await user.doc().id as String;
  }

  Map<String, dynamic> toMap()  {
    Map<String, dynamic> map =  {
      "id": this.id,
      "nome": this.nome,
      "apelido": this.apelido,
      "email": this.email,
      "senha": this.senha,
      "fotos": this.fotos,
    };
    return map;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  List get fotos => _fotos;

  set fotos(List value) {
    _fotos = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get apelido => _apelido;

  set apelido(String value) {
    _apelido = value;
  }
}

