import 'dart:core';
import 'dart:core';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Anuncio {
  String _id = "";
  String _provinciaB = "";
  String _categoria = "";
  String _titulo = "";
  String _preco = "";
  String _descricao = "";
  String _telefone = "";
  List _fotos = <String> [];

  Anuncio(){
    _pegarID();
  }

  _pegarID() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference anuncio = db.collection("Meus_anuncios"); //acessar pasta anuncio
    this.id = await anuncio.doc().id as String; //pegar o id gerado do anuncio e inicializar-lo  na variavel id
    this.fotos = [];
  }

  Anuncio.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.id = documentSnapshot["id"];
    this.provinciaB = documentSnapshot["provinciaB"];
    this.categoria = documentSnapshot["categoria"];
    this.titulo     = documentSnapshot["titulo"];
    this.preco      = documentSnapshot["preco"];
    this.telefone   = documentSnapshot["telefone"];
    this.descricao  = documentSnapshot["descricao"];
    this.fotos  = List<String>.from(documentSnapshot["fotos"]);
  }

  Map<String, dynamic> toMap()  {
    Map<String, dynamic> map =  {
    "id": this.id,
    "provinciaB": this.provinciaB,
    "categoria": this.categoria,
    "titulo": this.titulo,
    "preco": this._preco,
    "descricao": this.descricao,
    "telefone": this.telefone,
    "fotos": this.fotos,
    };
    return map;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get provinciaB => _provinciaB;

  set provinciaB(String value) {
    _provinciaB = value;
  }

  String get categoria => _categoria;

  set categoria(String value) {
    _categoria = value;
  }

  List get fotos => _fotos;

  set fotos(List value) {
    _fotos = value;
  }

  String get telefone => _telefone;

  set telefone(String value) {
    _telefone = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  String get preco => _preco;

  set preco(String value) {
    _preco = value;
  }

  String get titulo => _titulo;

  set titulo(String value) {
    _titulo = value;
  }
}