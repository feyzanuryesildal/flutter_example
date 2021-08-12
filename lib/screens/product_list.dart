import 'package:flutter/material.dart';
import 'package:ilk_app/data/dbHelper.dart';
import 'package:ilk_app/models/product.dart';
import 'package:ilk_app/screens/product_add.dart';
import 'package:ilk_app/screens/product_detail.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DbHelper dbHelper = new DbHelper();
  List<Product>? products;
  int productCount = 0;

  @override
  // ignore: must_call_super
  void initState() {
    getProducts();
    super.initState();
    print("initsatte-------------------");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Yeni ürün ekle",
      ),
    );
  }

  ListView buildProductList() {
    print("cbuild product list---------------------");
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black12,
                child: Text("p"),
              ),
              title: Text("${this.products![position].name}"),
              subtitle: Text("${this.products![position].description}"),
              onTap: () {
                goToDetail(this.products![position]);
              },
            ),
          );
        });
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((value) {
      setState(() {
        this.products = value;
        productCount = value.length;
      });
    });
  }

  void goToDetail(Product product) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (contex) => ProductDetail(product)));
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }
}
