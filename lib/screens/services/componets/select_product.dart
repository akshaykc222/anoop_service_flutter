import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/screens/categories/provider/category_provider.dart';
import 'package:seed_sales/screens/products/model/product_model.dart';
import 'package:seed_sales/screens/products/provider/products_provider.dart';
import 'package:seed_sales/screens/subcategory/provider/sub_category_provider.dart';

class ProductListAppointment extends StatefulWidget {
  const ProductListAppointment({Key? key}) : super(key: key);

  @override
  _ProductListAppointmentState createState() => _ProductListAppointmentState();
}

class _ProductListAppointmentState extends State<ProductListAppointment> {


  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<ProductProvider>(context, listen: false).get(context: context);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child:Consumer<ProductProvider>(

            builder: (context, snapshot,child) {
              return  snapshot.loading? snapshot.productList.isEmpty?const Center(child:  Text("not products"),): const Center(child: CircularProgressIndicator(),):
                      ListView.builder(
                        itemCount: snapshot.productList.length,
                          itemBuilder: (context,index){
                            return ProductListItem(model: snapshot.productList[index]);
                          }
                      );
            }
          ),),
        Positioned(
          bottom: 0,
            left: 0,
            right: 0,
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
                child: defaultButton(300, "ok")))
      ],
    );
  }
}

class ProductListItem extends StatelessWidget {
  final ProductModel model;
  const ProductListItem({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(

      builder: (context, snapshot,child) {
        return ListTile(
          onTap: (){
            snapshot.selectAppointmentProduct(model);
          },
          title:Text(model.name) ,
          trailing: Text(model.mrp.toString()),
          selectedTileColor: Colors.blue.shade300,
          selected: snapshot.isSelectedProduct(model),
        );
      }
    );
  }
}
