import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:olx/models/anuncio.dart';
import 'package:olx/view/widgets/selectedAnuncio.dart';

class SelectedCategoria extends StatefulWidget {
  final String cat;
  const SelectedCategoria({Key? key, required this.cat}) : super(key: key);
  @override
  _SelectedCategoriaState createState() => _SelectedCategoriaState();
}

class _SelectedCategoriaState extends State<SelectedCategoria> {
  late Anuncio anuncio;
  Stream<QuerySnapshot> data(){
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
      .collection("Anuncios")
      .where("categoria", isEqualTo: widget.cat)
      .snapshots();
    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset("images/logo.png", width: 50),
        iconTheme: IconThemeData(
          color: Colors.purple
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: StreamBuilder(
          stream: data(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

            if(snapshot.hasError){
              return Center(
                child: Text("Erro ao recuperar dados no servidor", style: TextStyle(fontSize: 20)),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: SpinKitRipple(color: Colors.deepOrange),
              );
            }

            QuerySnapshot? todosAnuncios = snapshot.data;
            final anuncios = todosAnuncios!.docs;
            final resultado =  anuncios.map((documentSnapshot){
              return Anuncio.fromDocumentSnapshot(documentSnapshot);
            }).toList();

            return GridView.builder(
              shrinkWrap: true,
              itemCount: todosAnuncios.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 7,
              ),
              itemBuilder: (context, index){
                final anuncioIndividual = resultado[index];

                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: <Widget> [
                        GestureDetector(
                          child: Container(
                            height: 118,
                            width: 118,
                            child: Image.network(anuncioIndividual.fotos[0], fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress){
                                if (loadingProgress == null){
                                  return child;
                                }

                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context){
                                      return selectedAnuncio(anuncio: anuncioIndividual);
                                    }
                                )
                            );
                          },
                        ), SizedBox(height: 8),

                        Row(
                          children: <Widget> [
                            Text("${anuncioIndividual.titulo}", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, fontFamily: 'times'))
                          ],
                        ), SizedBox(height: 3.2),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget> [
                            Text("${anuncioIndividual.preco} Mt", style: TextStyle(fontSize: 19, fontFamily: 'times')),
                            GestureDetector(
                              child: Icon(Icons.favorite_outline),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
