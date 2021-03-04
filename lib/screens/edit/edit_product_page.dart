import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prueba_empleo/tools/colors.dart';
import 'package:prueba_empleo/widgets/common_appbar.dart';

class EditProductPage extends StatefulWidget {
  final String documentRoute;
  final String name;
  final String description;
  final int price;
  final int stock;
  EditProductPage(
      {this.documentRoute,
      this.description,
      this.name,
      this.price,
      this.stock});
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _stockController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final db = Firestore.instance;

  createProduct() async {
    DocumentReference refProduct =
        db.collection('products').document(widget.documentRoute);
    print(widget.documentRoute.toString() +
        '0000000000000000000000000000000000000000000000000000000000000000000');
    Map<String, dynamic> product = {
      "name": _nameController.text,
      "description": _descriptionController.text,
      "price": int.parse(_priceController.text.toString()),
      "stock": int.parse(_stockController.text.toString())
    };

    refProduct.updateData(product);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _descriptionController.text = widget.description;
      _nameController.text = widget.name;
      _priceController.text = widget.price.toString();
      _stockController.text = widget.stock.toString();
    });
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
                  'Editar producto',
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
                        blurRadius: 20.0,
                        spreadRadius: 2.0,
                        offset: Offset(
                          10.0,
                          10.0,
                        ),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        //initialValue: widget.name,
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
                        //initialValue: widget.description,
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
                        //initialValue: widget.price.toString(),
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
                        //initialValue: widget.stock.toString(),
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
