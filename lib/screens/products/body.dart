import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/componets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:seed_sales/screens/products/model/product_model.dart';
import 'package:seed_sales/screens/products/provider/products_provider.dart';
import 'package:seed_sales/screens/subcategory/provider/sub_category_provider.dart';

import '../../constants.dart';
import '../../sizeconfig.dart';
import 'componets/categrory.dart';
import 'componets/products.dart';

class Products extends StatelessWidget {
  const Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Treatment", [], context),
      body: Stack(children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: const [
              CategorySelection(),
              ProductDetails(),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: defaultButton(
                    MediaQuery.of(context).size.width * 0.6, add)))
      ]),
    );
  }
}

class AddTreatments extends StatefulWidget {
  final ProductModel? model;
  const AddTreatments({Key? key, this.model}) : super(key: key);

  @override
  _AddTreatmentsState createState() => _AddTreatmentsState();
}

class _AddTreatmentsState extends State<AddTreatments> {
  final titleController = TextEditingController();
  final purchaseController = TextEditingController();
  final mrpController = TextEditingController();
  final salespController = TextEditingController();
  final salesRController = TextEditingController();
  final expiryController = TextEditingController();
  final durationController = TextEditingController();
  final taxRateController = TextEditingController();

  String service = "service";
  List<String> serItems = ["service", "product"];

  _upload() {
    int subID = Provider.of<SubCategoryProvider>(context, listen: false)
        .selectedCategory!
        .id!;
    if (subID == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('select sub category')));
    } else if (widget.model != null) {
      if (titleController.text.isEmpty ||
          purchaseController.text.isEmpty ||
          mrpController.text.isEmpty ||
          salesRController.text.isEmpty ||
          salespController.text.isEmpty ||
          taxRateController.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('fields required')));
      } else {
        ProductModel model = ProductModel(
            id: widget.model!.id,
            name: titleController.text,
            purchaseRate: double.parse(purchaseController.text),
            mrp: double.parse(mrpController.text),
            is_product: service == "service" ? false : true,
            salesPercentage: double.parse(salespController.text),
            salesRate: double.parse(salesRController.text),
            duration: durationController.text == null ||
                    durationController.text.isEmpty
                ? 0.00
                : double.parse(durationController.text),
            subCategory: subID,
            taxRate: double.parse(taxRateController.text));
        Provider.of<ProductProvider>(context, listen: false)
            .updateFun(context, model);
      }
    } else {
      if (titleController.text.isEmpty ||
          purchaseController.text.isEmpty ||
          mrpController.text.isEmpty ||
          salesRController.text.isEmpty ||
          salespController.text.isEmpty ||
          taxRateController.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('fields required')));
      } else {
        ProductModel model = ProductModel(
            name: titleController.text,
            purchaseRate: double.parse(purchaseController.text),
            mrp: double.parse(mrpController.text),
            salesPercentage: double.parse(salespController.text),
            salesRate: double.parse(salesRController.text),
            duration: durationController.text == null ||
                    durationController.text.isEmpty
                ? 0.00
                : double.parse(durationController.text),
            subCategory: subID,
            taxRate: double.parse(taxRateController.text));
        Provider.of<ProductProvider>(context, listen: false)
            .add(model, context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      titleController.text = widget.model!.name;
      purchaseController.text = widget.model!.purchaseRate.toString();
      mrpController.text = widget.model!.mrp.toString();
      salesRController.text = widget.model!.salesRate.toString();
    }
  }

  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 360)));
    if (picked != null) {
      setState(() {
        expiryController.text = DateFormat("yyyy-MM-dd").format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          widget.model != null
              ? headingText("Update Product")
              : headingText("Add Product"),
          columUserTextFiledsBlack(
              "Enter Title", "Title", TextInputType.name, titleController),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: DropdownButtonFormField(
              // Initial Value
              value: service,
              decoration: InputDecoration(
                  labelText: "Category",
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: serItems.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  service = newValue!;
                });
              },
            ),
          ),
          const CategorySelection(),

          columUserTextFiledsBlack("Enter Purchase rate", "Purchase rate",
              TextInputType.number, purchaseController),
          columUserTextFiledsBlack(
              "Enter MRP", "MRP", TextInputType.number, mrpController),
          columUserTextFiledsBlack("Enter Sales Percentage", "Sales Percentage",
              TextInputType.number, salespController),
          columUserTextFiledsBlack("Enter Sales Rate", "Sales Rate",
              TextInputType.number, salesRController),
          columUserTextFiledsBlack("Enter Tax Rate", "Tax Rate",
              TextInputType.number, taxRateController),
          InkWell(
            onTap: () {
              _showDatePicker();
            },
            child: dateField("Enter Expiry date", "Expiry date",
                TextInputType.datetime, expiryController),
          ),
          columUserTextFiledsBlack("duration", "Expiry date",
              TextInputType.datetime, durationController),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Product Images',
              style: TextStyle(
                  color: blackColor, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                File file = File(result.files.single.path!);
              } else {
                // User canceled the picker
              }
            },
            child: SizedBox(
              width: 50,
              height: 50,
              child: Container(
                color: Colors.grey,
                child: const Center(
                  child: Icon(Icons.add_a_photo_outlined),
                ),
              ),
            ),
          ),
          spacer(10),
          // Visibility(
          //     visible: !isService, child: columUserTextFileds("Duration")),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {
                    _upload();
                  },
                  child: defaultButton(SizeConfig.screenWidth! * 0.5,
                      widget.model != null ? "update" : add)),
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    cancel,
                    style: TextStyle(color: blackColor),
                  ))
            ],
          ),
          spacer(10)
        ],
      ),
    );
  }
}

Widget dateField(String label, String hint, TextInputType keyboard,
    TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please select value for $hint";
        }
        return null;
      },
      controller: controller,
      keyboardType: keyboard,
      style: const TextStyle(color: blackColor),
      decoration: InputDecoration(
          labelText: label,
          enabled: false,
          labelStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: blackColor),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: hint,
          hintStyle: const TextStyle(color: blackColor),
          filled: true,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: blackColor,
              width: 2.0,
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: blackColor)),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: blackColor))),
    ),
  );
}
