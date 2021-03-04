import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:provider/provider.dart';
import 'package:prueba_empleo/models/products_model.dart';
import 'package:prueba_empleo/screens/add/add_product_page.dart';
import 'package:prueba_empleo/screens/edit/edit_product_page.dart';
import 'package:prueba_empleo/tools/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  deleteProduct(String documentId) {
    Firestore.instance.collection('products').document(documentId).delete();
  }

  @override
  Widget build(BuildContext context) {
    List<Products> productsList = Provider.of<List<Products>>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Text(
                'Productos disponibles',
                style: TextStyle(color: Colors.black),
              ),
              Spacer(),
              Image.asset(
                'assets/logo.png',
                width: 30,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(PageTransition(
                type: PageTransitionType.transferRight,
                child: AddProductPage(),
                duration: Duration(milliseconds: 600)));
          },
          child: Icon(
            Icons.add,
            color: WacoColors.green,
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.white,
        body: (productsList != null)
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: productsList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == productsList.length) {
                    return Container();
                  } else {
                    return Row(
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            margin: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      productsList[index].name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      '\$' +
                                          productsList[index].price.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            PageTransition(
                                                type: PageTransitionType
                                                    .transferRight,
                                                child: EditProductPage(
                                                  documentRoute:
                                                      productsList[index].id,
                                                  description:
                                                      productsList[index]
                                                          .description,
                                                  name:
                                                      productsList[index].name,
                                                  price:
                                                      productsList[index].price,
                                                  stock:
                                                      productsList[index].stock,
                                                ),
                                                duration: Duration(
                                                    milliseconds: 600)));
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.edit_rounded,
                                          color: WacoColors.green,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              '¿Seguro de eliminar ${productsList[index].name}?'),
                                          action: SnackBarAction(
                                            textColor: WacoColors.green,
                                            label: 'Confirmar',
                                            onPressed: () {
                                              deleteProduct(
                                                  productsList[index].id);
                                            },
                                          ),
                                        ));
                                      },
                                      child: Container(
                                        child: Icon(
                                          Icons.delete_forever_rounded,
                                          color: WacoColors.green,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  productsList[index].description,
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ))
                      ],
                    );
                  }
                },
              )
            : Text('Cargando...'));
  }
}
