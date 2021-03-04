import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prueba_empleo/tools/colors.dart';
import 'package:prueba_empleo/widgets/common_appbar.dart';
import 'package:random_string/random_string.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _stockController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = Firestore.instance;

  createProduct() async {
    String productId = randomString(10);

    DocumentReference refProduct =
        db.collection('products').document(productId);
    Map<String, dynamic> product = {
      "name": _nameController.text,
      "description": _descriptionController.text,
      "price": int.parse(_priceController.text.toString()),
      "stock": int.parse(_stockController.text.toString()),
      "id": productId,
    };

    refProduct.setData(product);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar(context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crear producto',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 20.0, // soften the shadow
                        spreadRadius: 2.0, //extend the shadow
                        offset: Offset(
                          10.0, // Move to right 10  horizontally
                          10.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Debes poner un nombre';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        decoration:
                            InputDecoration(labelText: "Nombre del producto"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Debes poner una descripción';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        maxLines: 6,
                        maxLength: 200,
                        decoration: InputDecoration(
                            labelText: "Descripción del producto"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _priceController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Debes poner un precio';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        decoration:
                            InputDecoration(labelText: "Precio del producto"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _stockController,
                        validator: (String value) {
                          if (value.isEmpty || value == '0') {
                            return 'Debes poner existencias';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        decoration:
                            InputDecoration(labelText: "Cantidad del producto"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            createProduct();
                          } else {
                            return null;
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              stops: [0.2, 0.5],
                              colors: [WacoColors.blue, WacoColors.green],
                            ),
                          ),
                          child: Text(
                            'Crear producto',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
