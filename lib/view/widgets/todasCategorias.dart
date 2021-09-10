import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:olx/view/widgets/selectedCategoria.dart';

class TodasCategorias extends StatefulWidget {
  const TodasCategorias({Key? key}) : super(key: key);

  @override
  _TodasCategoriasState createState() => _TodasCategoriasState();
}

class _TodasCategoriasState extends State<TodasCategorias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset("images/logo.png", width: 50,),
        iconTheme: IconThemeData(
          color: Colors.purple
        ),
      ),

      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          GestureDetector(
            child: ListTile(
              title: Text("Veiculos", style: TextStyle(fontSize: 21, fontFamily: 'times')),
              subtitle: Text("Adquiri ou alugue veiculos", style: TextStyle(fontSize: 17, fontFamily: 'times')),
              leading: Container(
                height: 40,
                width: 40,
                child: Image.asset("images/categorias/car.png"),
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey, size: 20),
            ),
            onTap: (){
              String categoria = "Veiculos";
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context){
                    return SelectedCategoria(cat: categoria);
                  }
                )
              );
            },
          ),
          Container(height: 1, color: Colors.grey,),

          GestureDetector(
            child: ListTile(
              title: Text("Casas", style: TextStyle(fontSize: 21, fontFamily: 'times')),
              subtitle: Text("Adquire e arende casas", style: TextStyle(fontSize: 17, fontFamily: 'times')),
              leading: Container(
                height: 40,
                width: 40,
                child: Image.asset("images/categorias/casa.png"),
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey, size: 20),
            ),
            onTap: (){
              String categoria = "Casas";
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return SelectedCategoria(cat: categoria);
                      }
                  )
              );
            },
          ),
          Container(height: 1, color: Colors.grey,),

          GestureDetector(
            child: ListTile(
              title: Text("Computadores", style: TextStyle(fontSize: 21, fontFamily: 'times')),
              subtitle: Text("Compre aqui seus computadores", style: TextStyle(fontSize: 17, fontFamily: 'times')),
              leading: Container(
                height: 40,
                width: 40,
                child: Image.asset("images/categorias/laptop.png"),
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey, size: 20),
            ),
            onTap: (){
              String categoria = "Computadores";
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return SelectedCategoria(cat: categoria);
                      }
                  )
              );
            },
          ),
          Container(height: 1, color: Colors.grey,),

          GestureDetector(
            child: ListTile(
              title: Text("Electrodomesticos", style: TextStyle(fontSize: 21, fontFamily: 'times')),
              subtitle: Text("Geleiras, microondas, TV's, etc...", style: TextStyle(fontSize: 17, fontFamily: 'times')),
              leading: Container(
                height: 40,
                width: 40,
                child: Image.asset("images/categorias/electrodomestico.png"),
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey, size: 20),
            ),
            onTap: (){
              String categoria = "Electrodomesticos";
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return SelectedCategoria(cat: categoria);
                      }
                  )
              );
            },
          ),
          Container(height: 1, color: Colors.grey,),

          GestureDetector(
            child: ListTile(
              title: Text("Vestuario", style: TextStyle(fontSize: 21, fontFamily: 'times')),
              subtitle: Text("Compre aqui roupas, calcados, etc..", style: TextStyle(fontSize: 17, fontFamily: 'times')),
              leading: Container(
                height: 40,
                width: 40,
                child: Image.asset("images/categorias/roupa.png"),
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey, size: 20),
            ),
            onTap: (){
              String categoria = "Vestuario";
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return SelectedCategoria(cat: categoria);
                      }
                  )
              );
            },
          ),
          Container(height: 1, color: Colors.grey,),

          GestureDetector(
            child: ListTile(
              title: Text("Crianças e bebes", style: TextStyle(fontSize: 21, fontFamily: 'times')),
              subtitle: Text("Brinquedos, roupas de bebes", style: TextStyle(fontSize: 17, fontFamily: 'times')),
              leading: Container(
                height: 40,
                width: 40,
                child: Image.asset("images/categorias/bebe.png"),
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey, size: 20),
            ),
            onTap: (){
              String categoria = "Crianças e bebes";
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return SelectedCategoria(cat: categoria);
                      }
                  )
              );
            },
          ),
          Container(height: 1, color: Colors.grey,),

          GestureDetector(
            child: ListTile(
              title: Text("Serviços", style: TextStyle(fontSize: 21, fontFamily: 'times')),
              subtitle: Text("Jardinagem, construicao, etc...", style: TextStyle(fontSize: 17, fontFamily: 'times')),
              leading: Container(
                height: 40,
                width: 40,
                child: Image.asset("images/categorias/servicos.png"),
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey, size: 20),
            ),
            onTap: (){
              String categoria = "Serviços";
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return SelectedCategoria(cat: categoria);
                      }
                  )
              );
            },
          ),
          Container(height: 1, color: Colors.grey,),

          GestureDetector(
            child: ListTile(
              title: Text("Consolas e jogos", style: TextStyle(fontSize: 21, fontFamily: 'times')),
              subtitle: Text("Jogos, acessorios de video-games", style: TextStyle(fontSize: 17, fontFamily: 'times')),
              leading: Container(
                height: 40,
                width: 40,
                child: Image.asset("images/categorias/ps.png"),
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey, size: 20),
            ),
            onTap: (){
              String categoria = "Consolas e jogos";
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return SelectedCategoria(cat: categoria);
                      }
                  )
              );
            },
          ),
          Container(height: 1, color: Colors.grey,),

          GestureDetector(
            child: ListTile(
              title: Text("Livros", style: TextStyle(fontSize: 21, fontFamily: 'times')),
              subtitle: Text("Obras literarias", style: TextStyle(fontSize: 17, fontFamily: 'times')),
              leading: Container(
                height: 40,
                width: 40,
                child: Image.asset("images/categorias/livro.png"),
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey, size: 20),
            ),
            onTap: (){
              String categoria = "Livros";
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return SelectedCategoria(cat: categoria);
                      }
                  )
              );
            },
          ),
          Container(height: 1, color: Colors.grey,),

          GestureDetector(
            child: ListTile(
              title: Text("Celulares e acessorios", style: TextStyle(fontSize: 21, fontFamily: 'times')),
              subtitle: Text("Celulares, baterias, acessorios, etc...", style: TextStyle(fontSize: 17, fontFamily: 'times')),
              leading: Container(
                height: 40,
                width: 40,
                child: Image.asset("images/categorias/cell.png"),
              ),
              trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.grey, size: 20),
            ),
            onTap: (){
              String categoria = "Celulares";
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return SelectedCategoria(cat: categoria);
                      }
                  )
              );
            },
          ),
        ],
      )

    );
  }
}
