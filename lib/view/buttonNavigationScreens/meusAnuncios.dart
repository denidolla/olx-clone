import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:olx/models/anuncio.dart';
import 'package:olx/models/constantes.dart';
import 'package:olx/view/initialsViews/login.dart';
import 'package:olx/view/widgets/selectedAnuncio.dart';
import '../widgets/createAnuncio.dart';

class meus extends StatefulWidget {
  @override
  _meusState createState() => _meusState();
}

class _meusState extends State<meus> {
  late Anuncio anuncio;
  late String idUserLogado;
  var verifyUserState;
  late final RouteSettings settings;

  @override
  void initState() {
    super.initState();
  }

  _UserID(){
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuario = auth.currentUser!;
    idUserLogado = usuario.uid;
  }

  _apagarAnuncios(String idAnuncioSelecionado){
    FirebaseFirestore dbPrivada = FirebaseFirestore.instance;
    FirebaseFirestore dbPublica = FirebaseFirestore.instance;
    dbPrivada.collection("Meus_anuncios")
        .doc(idUserLogado)
        .collection("Anuncios")
        .doc(idAnuncioSelecionado)
        .delete();

    dbPublica.collection("Anuncios")
        .doc(idAnuncioSelecionado)
        .delete();
  }

  _apagarAnunciosPublicos(String idAnuncioSelecionado){
    FirebaseFirestore dbPublica = FirebaseFirestore.instance;
    dbPublica.collection("Anuncios")
        .doc(idAnuncioSelecionado)
        .delete();
  }

  Stream<QuerySnapshot> recuperarDadosSalvos() {
    _UserID();
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("Meus_anuncios")
        .doc(idUserLogado)
        .collection("Anuncios")
        .snapshots();
    return stream;
  }

  loginDialog(){
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context){
        return CupertinoActionSheet(
          title: Text("Nenhum usuário logado", style: TextStyle(fontSize: 24, fontFamily: 'times', color: Colors.grey),),
          cancelButton: Container(
            height: 52,
            child: Center(
              child: Text("Cancelar", style: TextStyle(fontSize: 20, color: Colors.red, fontFamily: 'times', fontWeight: FontWeight.bold,)),
            ),
          ),
          actions: <Widget> [
            CupertinoActionSheetAction(
              child: Text("Logar", style: TextStyle(fontSize: 20, color: Colors.blue, fontFamily: 'times', fontWeight: FontWeight.bold)),
              onPressed: (){
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return login();
                    }
                  )
                );
              },
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        onPressed: (){
          if(FirebaseAuth.instance.currentUser?.uid != null){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => criarAnuncios()
                )
            );
          } else {
            loginDialog();
          }
        },
      ),

      body: FirebaseAuth.instance.currentUser?.uid == null
        ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Center(
              child: Text("Nenhum usuário logado", style: textos),
            )
          ],
        )
        : StreamBuilder(
          stream: recuperarDadosSalvos(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot ){
            if (snapshot.hasError) {
             return Center(
                child: Text("Erro"),
             );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    SpinKitRipple(color: Colors.purple, size: 35), SizedBox(height: 15),
                    Text("Carregando os teus anuncios . . .")
                  ],
                ),
              );
            }

            QuerySnapshot? todosAnuncios = snapshot.data;
            final anuncios = todosAnuncios!.docs;
            final res = anuncios.map((d) => Anuncio.fromDocumentSnapshot(d)).toList();

            return ListView.builder(
              itemCount: res.length,
              itemBuilder: (context, index){

                final anuncio = res[index];

               return GestureDetector(
                 onTap: (){
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context){
                             return selectedAnuncio(anuncio: anuncio);
                           }
                       )
                   );
                 },
                 child: Card(
                   child: Padding(
                     padding: EdgeInsets.all(14),
                     child: Row(
                       children: <Widget> [
                         Container(
                           height: 100,
                           width: 120,
                           child: Image.network(anuncio.fotos[0], fit: BoxFit.cover),
                         ),
                         Expanded(
                             flex: 3,
                             child: Padding(
                               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget> [
                                   Text(anuncio.titulo, style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, fontFamily: 'times')),SizedBox(height: 10),
                                   Text("${anuncio.preco} Mzn", style: TextStyle(fontSize: 17, fontFamily: 'times')),SizedBox(height: 10),
                                   Text("Provincia de ${anuncio.provinciaB}", style: TextStyle(fontSize: 17, fontFamily: 'times'))
                                 ],
                               ),
                             )
                         ),

                         Expanded(
                           flex: 1,
                           child: FlatButton(
                             color: Colors.red,
                             child: Icon(Icons.delete_forever_sharp, color: Colors.white,),
                             onPressed: (){
                               showDialog(
                                   context: context,
                                   barrierDismissible: false,
                                   builder: (context){
                                     return AlertDialog(
                                       content: Column(
                                         mainAxisSize: MainAxisSize.min,
                                         children: <Widget> [
                                           Icon(Icons.delete_forever_outlined, size: 60, color: Colors.red),SizedBox(height: 7),
                                           Text("Deseja Apagar este anúncio?", style: TextStyle(color: Colors.black, fontSize: 17, fontFamily: 'times')),SizedBox(height: 7),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                             children: <Widget> [
                                               FlatButton(
                                                 onPressed: (){
                                                   Navigator.of(context).pop();
                                                 },
                                                 child: Text("Cancelar", style: TextStyle(fontSize: 17, fontFamily: 'times')),
                                                 color: Colors.blue,
                                               ),

                                               FlatButton(
                                                 onPressed: (){
                                                   _apagarAnuncios(anuncio.id);
                                                   _apagarAnunciosPublicos(anuncio.id);
                                                   Navigator.of(context).pop();
                                                 },
                                                 child: Text("Apagar", style: TextStyle(fontSize: 17, fontFamily: 'times')),
                                                 color: Colors.red,
                                               ),
                                             ],
                                           )
                                         ],
                                       ),
                                     );
                                   }
                               );
                             },
                           ),
                         )
                       ],
                     )
                   ),
                 ),
               );
              },
            );
        },
      )
    );
  }
}