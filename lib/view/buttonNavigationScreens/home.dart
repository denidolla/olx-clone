import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:olx/models/anuncio.dart';
import 'package:olx/models/constantes.dart';
import 'package:olx/view/widgets/selectedAnuncio.dart';
import 'package:olx/view/widgets/selectedCategoria.dart';
import 'package:olx/view/widgets/todasCategorias.dart';
import 'package:olx/view/widgets/todosAnuncios.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  late Anuncio anuncio;
  @override
  void initState() {
    super.initState();
  }

  Stream<QuerySnapshot> dadosRecentes() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("Anuncios")
        .snapshots();
    return stream;
  }
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      children: <Widget> [

        Container(
          height: 50,
          child: Row(
            children: <Widget> [
              Expanded(
                flex: 4,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                      prefixIcon: Icon(Icons.search, color: Colors.deepOrange),
                      hintText: "Pesquisar",
                      hintStyle: TextStyle(color: Colors.black, fontFamily: 'times', fontSize: 19)
                  ),
                ),
              ), SizedBox(width: 5),

              Expanded(
                flex: 1,
                child:  Container(
                  height: 50,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)
                    ),
                    //color: Colors.deepOrange,
                    onPressed: (){},
                    child: Icon(MdiIcons.filterMenu, color: Colors.blue),
                  ),
                ),
              )

            ],
          )
        ), SizedBox(height: 10),

        Container(
          height: 240,
          width: double.infinity,
          child: Card(
            color: Colors.lightBlue,
            child: Padding(
              padding: EdgeInsets.only(left: 8, right: 12, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text("Seja Bem vindo,", style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'times')),
                  Row(
                    children: <Widget> [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 80,
                          child: Text("Compre e Anuncie \nQualquer tipo de artigo", style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 120,
                          child: Image.asset("images/icons/order.png", fit: BoxFit.cover,),
                        ),
                      )
                    ],
                  ), SizedBox(height: 15),

                  Row(
                    children: <Widget> [
                      Expanded(
                        flex: 1,
                        child: NeumorphicButton(
                          padding: EdgeInsets.only(top: 15, bottom: 15),
                          child: Text("Anunciar meus productos", style: TextStyle(fontFamily: 'times', fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center),
                          style: NeumorphicStyle(
                            color: Colors.white,
                          ),
                        ),
                      ), //SizedBox(width: 15),

                    ],
                  )

                ],
              ),
            ),
          ),
        ), SizedBox(height: 10),

        Text(" Categorias", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'times')), SizedBox(height: 5),

        Container(
          height: 130,
          child: ListView(
            padding: EdgeInsets.all(8),
            scrollDirection: Axis.horizontal,
            children: <Widget> [
              //veiculos
              GestureDetector(
                child: Card(
                  child: Container(
                    height: 100,
                    width: 130,
                    //color: Colors.yellow,
                    child: Column(
                      children: <Widget> [
                        Expanded(
                          flex: 3,
                          child: Image.asset("images/categorias/car.png", fit: BoxFit.cover,),
                        ),

                        Expanded(
                          flex: 1,
                          child: Text("Veículos", style: TextStyle(fontSize: 19, fontFamily: 'times', fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: (){
                  String c = "Veiculos";
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SelectedCategoria(cat: c);
                      }
                    )
                  );
                },
              ), SizedBox(width: 5),

              //computadores
              GestureDetector(
                child: Card(
                  child: Container(
                    height: 100,
                    width: 130,
                    //color: Colors.yellow,
                    child: Column(
                      children: <Widget> [
                        Expanded(
                          flex: 3,
                          child: Image.asset("images/categorias/laptop.png", fit: BoxFit.cover,),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text("Computadores", style: TextStyle(fontSize: 19, fontFamily: 'times', fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: (){
                  String c = "Computadores";
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return SelectedCategoria(cat: c);
                          }
                      )
                  );
                },
              ), SizedBox(width: 5),

              //consolas
              GestureDetector(
                child: Card(
                  child: Container(
                    height: 100,
                    width: 130,
                    //color: Colors.yellow,
                    child: Column(
                      children: <Widget> [
                        Expanded(
                          flex: 3,
                          child: Image.asset("images/categorias/ps.png", fit: BoxFit.cover,),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text("Consolas", style: TextStyle(fontSize: 19, fontFamily: 'times', fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: (){
                  String c = "Consolas e jogos";
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return SelectedCategoria(cat: c);
                          }
                      )
                  );
                },
              ), SizedBox(width: 5),

              //maisCategorias
              GestureDetector(
                child: Card(
                  child: Container(
                    height: 100,
                    width: 70,
                    //color: Colors.yellow,
                    child: Column(
                      children: <Widget> [
                        Expanded(
                          flex: 3,
                          child: Image.asset("images/categorias/more_3814.png", width: 60,),
                        ),

                        Expanded(
                          flex: 1,
                          child: Text("mais", style: TextStyle(fontSize: 19, fontFamily: 'times', fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        return TodasCategorias();
                      }
                    )
                  );
                },
              ), SizedBox(width: 5),
            ],
          ),
        ),

        SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget> [
            Text(" Anuncios Recentes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'times')), SizedBox(height: 10),
            GestureDetector(
              child: Text("see all ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'times')),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TodosAnuncios();
                    }
                  )
                );
              },
            ),
          ],
        ),

        StreamBuilder(
          stream: dadosRecentes(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot ){
            if (snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  CircularProgressIndicator(),
                  Text("Carregando anuncios recentes . . .")
                ],
              );
            }

            QuerySnapshot? todosAnuncios = snapshot.data;
            final anuncios = todosAnuncios!.docs;
            final resultado = anuncios.map((documentSnapshot) => Anuncio.fromDocumentSnapshot(documentSnapshot)).toList();

            return GridView.builder(
              shrinkWrap: true,
              itemCount: 2,
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
                            child: Image.network(anuncioIndividual.fotos[0], fit: BoxFit.cover,),
                          ),
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) {
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
        )

      ],
    );
  }
}
