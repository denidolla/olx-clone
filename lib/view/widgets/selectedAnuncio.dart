import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:olx/models/anuncio.dart';

class selectedAnuncio extends StatefulWidget {
  final Anuncio anuncio;
  const selectedAnuncio({Key? key, required this.anuncio}) : super(key: key);
  @override
  _selectedAnuncioState createState() => _selectedAnuncioState();
}

class _selectedAnuncioState extends State<selectedAnuncio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset("images/logo.png", width: 80),
        iconTheme: IconThemeData(
          color: Colors.deepPurple
        ),
      ),

      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        children: <Widget> [
          Container(
            height: 320,
            width: double.infinity,
            child: Image.network(widget.anuncio.fotos[0], fit: BoxFit.cover),
          ), SizedBox(height: 15),

          Text("${widget.anuncio.titulo}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'times'),),SizedBox(height: 10),
          Text("${widget.anuncio.preco},00 Meticais", style: TextStyle(fontSize: 19, fontFamily: 'times'),), SizedBox(height: 10),
          Text("Provincia de ${widget.anuncio.provinciaB}", style: TextStyle(fontSize: 19, fontFamily: 'times'),), SizedBox(height: 10),

          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Colors.grey,
                      width: 1
                  ),
                  bottom: BorderSide(
                      color: Colors.grey,
                      width: 1
                  ),
                  left: BorderSide(
                      color: Colors.grey,
                      width: 1
                  ),
                  right: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                )
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(widget.anuncio.descricao, textAlign: TextAlign.justify, style: TextStyle(fontSize: 19, height: 1.2, fontFamily: 'times'),),
            ),
          )
        ],
      ),

      bottomNavigationBar: Row(
        children: <Widget> [
          Expanded(
            flex: 3,
            child: RaisedButton(
              color: Colors.blue,
              child: Icon(MdiIcons.phoneDial, size: 50,),
              onPressed: (){},
            ),
          ), SizedBox(width: 5),

           Expanded(
            flex: 1,
            child: RaisedButton(
              color: Colors.green,
              child: Icon(MdiIcons.whatsapp, size: 50),
              onPressed: (){},
            ),
          ),


        ],
      ),

    );
  }
}
