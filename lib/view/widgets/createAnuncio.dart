import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:olx/models/anuncio.dart';
import 'package:validadores/Validador.dart';
import '../dashboard.dart';

class criarAnuncios extends StatefulWidget {
  const criarAnuncios({Key? key}) : super(key: key);
  @override
  _criarAnunciosState createState() => _criarAnunciosState();
}

class _criarAnunciosState extends State<criarAnuncios> {
  var maskFormatterNumero = new MaskTextInputFormatter(mask: '+258 ## ### ####', filter: { "#": RegExp(r'[0-9]') }); //criar propria mascara
  @override
  late Anuncio _anuncio; //criar uma variavel "_anuncio" do tipo Anuncio
  void initState() {
    super.initState();
    _anuncio = Anuncio(); //instanciar o construtor e consequetimente gerar um id, pois no construtor ja pegamos o id
  }

  final chave = GlobalKey<FormState>(); //chave
  List arrayImagens = <File> []; //aray de imagens
  final picker = ImagePicker(); //variavel tipo ImagePicker
  late File imagemSelecionada;

  //metodo de arir galeria, selecionar iamgem e colocar-la no array
  _abrirGaleria () async {
    final imagemTemporaria = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      arrayImagens.add(File(imagemTemporaria!.path)); //coloca a imagem selecionada no array
    });
    return arrayImagens; //retorna o array de imagem para ser usado
  }

  List arrayProvincias = <DropdownMenuItem> []; //array de provincias que recebe dropdownmenuitem
  List Provincias =  ["Maputo", "Gaza", "Inhambane", "Manica", "Sofala", "Tete", "Zambezia", "Nampula", "Niassa", "C. Delgado"];//array com lista de provincias nacionais
  dynamic provinciaSelecionada; //variavel que vai receber a provincia que o user vai escolher

  //metodo de preencher o array de provincias com cada provincia no array existente
  _dropProvincias(){
    for(var x in Provincias){
      arrayProvincias.add(DropdownMenuItem(child: Text(x), value: x));
      if(arrayProvincias.length > 10){ //vai remover qualquer indice acima de 9
        arrayProvincias.removeRange(10, 11);
      }
    }
    return arrayProvincias;
  }

  List arrayCategorias = <DropdownMenuItem> [];//array de categorias que recebe dropdownmenuitem
  List Categorias = <dynamic> ["Veiculos", "Casas", "Celulares", "Electrodomesticos", "Vestuario", "Crianças e bebes", "Serviços", "Consolas e jogos", "Livros", "Computadores"];//array com lista de categorias
  dynamic categoriaSelecionada; //variavel que vai receber a categoria que o user vai escolher

  _dropCategoria(){
    for(var y in Categorias){
      arrayCategorias.add(DropdownMenuItem(child: Text(y), value: y));
      if(arrayCategorias.length > 10){
        arrayCategorias.removeRange(10, 11);//vai remover qualquer indice acima de 9
      }
    }
    return arrayCategorias;
  }

  //upload das imagens no "storage" e retorno das URL's de cada imagem
  Future _uploadImagens() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    
    final storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();

    for(var photos in arrayImagens){
      String imgName = DateTime.now().microsecondsSinceEpoch.toString();
      Reference arquivo = pastaRaiz //local de armazenar imagens
          .child("Meus_anuncios") // pasta
          .child(_anuncio.id) //id do anuncio
          .child(imgName); //nome da imagem

      UploadTask uploadTask = arquivo.putFile(photos);
      TaskSnapshot taskSnapshot = await uploadTask;

      String url = await taskSnapshot.ref.getDownloadURL();
      _anuncio.fotos.add(url);
    }
  }

  //Salvar anuncio
  _salvarAnuncio () async {
    _abrirDialog();
    FirebaseAuth auth = FirebaseAuth.instance; //criar uma instancia de firebase auth chamada "auth"
    User usuario = await auth.currentUser!; //pegar todos dados do usuario
    String idUserLogado = usuario.uid; //recuperar apenas o id do usuario

    await _uploadImagens(); //Metodo de upload de imagens

    //salvar anuncio
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("Meus_anuncios")
        .doc(idUserLogado)
        .collection("Anuncios")
        .doc(_anuncio.id)//id
        .set(_anuncio.toMap()).then((_){ //usa o metodo set para salvar os dados preenchidos
          Navigator.of(context).pop();//fechar o dialog
          //Navigator.of(context).pop();//fechar a tela de criar anuncio e voltar para a ultima
        });

    FirebaseFirestore bd = FirebaseFirestore.instance;
    bd.collection("Anuncios")
        .doc(_anuncio.id)//id
        .set(_anuncio.toMap()).then((_){
          Navigator.of(context).pop();//voltar para tela meus anuncios
        });
  }

  //Dialog de processamento de salvar anuncio
  _abrirDialog(){
    showDialog(
        context: context,
        barrierDismissible: false, //serve para impedir o user de mexer o app enquanto o dialog estiver aberto
        builder: (context){
          return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget> [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Publicando anuncio...", style: TextStyle(fontSize: 17, fontFamily: 'times'))
                ],
              )
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Criar anúncio", style: TextStyle(fontSize: 20, fontFamily: 'times', fontWeight: FontWeight.bold, color: Colors.white),)
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Container(
          child: Form(
            key: chave,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget> [
                FormField<List>(
                  initialValue: arrayImagens,
                  builder: (state){
                    return Column(
                      children: <Widget> [
                        Container(
                          height: 100,
                          child: ListView.builder(
                            itemCount: arrayImagens.length + 1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              if(index == arrayImagens.length){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.grey.shade400,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget> [
                                          Icon(Icons.add_a_photo_outlined, color: Colors.deepPurple, size: 40),
                                        ],
                                      ),
                                    ),
                                    onTap: (){_abrirGaleria();},
                                  ),
                                );
                              }

                              if (arrayImagens.length > 0){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage: FileImage(arrayImagens[index]),
                                      child: Container(
                                        color: Color.fromRGBO(255, 255, 255, 0.4),
                                        alignment: Alignment.center,
                                        child: Icon(Icons.delete, color: Colors.red),
                                      ),
                                    ),
                                    onTap: (){
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget> [
                                              Image.file(arrayImagens[index]),
                                              FlatButton(
                                                onPressed: (){
                                                  setState(() {
                                                    arrayImagens.removeAt(index);
                                                    Navigator.of(context).pop();
                                                  });

                                                },
                                                child: Text("Apagar", style: TextStyle(color: Colors.red, fontFamily: 'times'),),
                                              )
                                            ],
                                          ),
                                        )
                                      );
                                    },
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        )
                      ],
                    );
                  },
                ),

                Row(
                  children: <Widget> [
                    //provincias
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField(
                        value: provinciaSelecionada,
                        items: _dropProvincias(),
                        validator: (valor){
                          return Validador().add(Validar.OBRIGATORIO, msg: "Campo Obrigatorio").valido(valor.toString());
                        },
                        hint: Text('Provincias', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'times'),),
                        onChanged: (valor){
                          setState(() {
                            provinciaSelecionada = valor;
                          });
                        },
                        onSaved: (value){
                          _anuncio.provinciaB = value.toString();
                        },
                      ),
                    ), SizedBox(width: 10),

                    //categorias
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField(
                        value: categoriaSelecionada,
                        items: _dropCategoria(),
                        validator: (valor){
                          return Validador().add(Validar.OBRIGATORIO, msg: "Campo Obrigatorio").valido(valor.toString());
                        },
                        hint: Text('Categorias', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'times')),
                        onChanged: (valor){
                          setState(() {
                            categoriaSelecionada = valor;
                          });
                        },
                        onSaved: (value){
                          _anuncio.categoria = value.toString();
                        },
                      ),
                    ),
                  ],
                ),SizedBox(height: 15),

                //Titulo
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Titulo',
                    hintStyle: TextStyle(fontSize: 19, fontFamily: 'times', fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)
                    )
                  ),
                  validator: (valor){
                    return Validador().add(Validar.OBRIGATORIO, msg: "Campo obrigatorio").valido(valor);
                  },
                  onSaved: (valor){
                    _anuncio.titulo = valor.toString();
                  },
                ), SizedBox(height: 15),

                //Descricao
                TextFormField(
                  maxLines: null,
                  decoration: InputDecoration(
                    hintMaxLines: 150,
                    hintText: 'Descrição',
                    hintStyle: TextStyle(fontSize: 19, fontFamily: 'times', fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)
                    )
                  ),
                  validator: (valor){
                    return Validador().add(Validar.OBRIGATORIO, msg: "Campo obrigatorio").valido(valor);
                  },
                  onSaved: (valor){
                    _anuncio.descricao = valor.toString();
                  },
                ), SizedBox(height: 15),

                //Contacto
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    maskFormatterNumero
                  ],
                  decoration: InputDecoration(
                    hintText: 'Contacto',
                    hintStyle: TextStyle(fontSize: 19, fontFamily: 'times', fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)
                    )
                  ),
                  validator: (valor){
                     return Validador().add(Validar.OBRIGATORIO, msg: "Campo obrigatorio").valido(valor);
                  },
                  onSaved: (valor){
                    _anuncio.telefone = valor.toString();
                  },
                ), SizedBox(height: 15),

                //preco
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    RealInputFormatter(centavos: false)
                  ],
                  decoration: InputDecoration(
                    hintText: 'Preço',
                    hintStyle: TextStyle(fontSize: 19, fontFamily: 'times', fontWeight: FontWeight.bold),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)
                    )
                  ),
                  validator: (valor){
                    return Validador().add(Validar.OBRIGATORIO, msg:"Campo obrigatorio").valido(valor);
                  },
                  onSaved: (valor){
                    _anuncio.preco = valor.toString();
                  },
                ), SizedBox(height: 15),

                RaisedButton(
                    color: Colors.blueAccent,
                    onPressed: (){
                      if (chave.currentState!.validate()){
                        chave.currentState!.save();
                        _salvarAnuncio();
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(70, 15, 70, 15),
                      child: Text("Publicar anúncio", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'times', color: Colors.white),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}