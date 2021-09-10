import 'package:flutter/material.dart';

final decoracoesBox = BoxDecoration(
  borderRadius: BorderRadius.circular(12),
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Colors.deepPurple,
      blurRadius: 10,
      offset: Offset(0, 2)
    )
  ]
);

final textos = TextStyle(
  color: Colors.black,
  fontSize: 19,
  //fontWeight: FontWeight.bold,
  fontFamily: 'times'
  //fontFamily: 'OpenSans'
);

final hintTextos = TextStyle(
  color: Colors.grey,
  fontSize: 19,
  //fontWeight: FontWeight.bold,
  fontFamily: 'times'
  //fontFamily: 'OpenSans'
);

final textosTitulo = TextStyle(
  color: Colors.black,
  fontSize: 19,
  fontFamily: 'times'
  //fontFamily: 'OpenSans'
);

final textosIcon = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontFamily: 'times'

);


final textosSub = TextStyle(
  color: Colors.black,
  fontSize: 15,
  //fontWeight: FontWeight.bold,
  fontFamily: 'times'
  //fontFamily: 'OpenSans'
);

final textosBotoes = TextStyle(
  color: Colors.deepOrange,
  fontSize: 18,
  fontWeight: FontWeight.bold,
  fontFamily: 'times',
  letterSpacing: 1.5
);

final decoracoesBoxCadastro = BoxDecoration(
  //borderRadius: BorderRadius.circular(12),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
          color: Colors.deepPurple,
          blurRadius: 10,
          offset: Offset(0, 2)
      )
    ]
);