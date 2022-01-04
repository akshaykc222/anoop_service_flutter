import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/categories/models/categories_model.dart';
import 'package:seed_sales/screens/categories/provider/category_provider.dart';
import 'package:seed_sales/screens/subcategory/models/sub_category.dart';
import 'package:seed_sales/screens/subcategory/provider/sub_category_provider.dart';
import 'package:seed_sales/sizeconfig.dart';

import '../../../componets.dart';

class SubCategoryForm extends StatefulWidget {
  final SubCategoryModel? model;
  final int category;
  const SubCategoryForm({Key? key,this.model,required this.category}) : super(key: key);

  @override
  _SubCategoryFormState createState() => _SubCategoryFormState();
}

class _SubCategoryFormState extends State<SubCategoryForm> {
  final taxController = TextEditingController();
  final taxShortController = TextEditingController();
  final taxPercentageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (widget.model!=null) {

        taxController.text=widget.model!.name;
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
      key: formKey,
      child: Column(
        children: [
          widget.model!=null?headingText("Update Sub Categories"): headingText("Add Sub Categories"),
          spacer(10),
          columUserTextFiledsBlack("Enter Sub category name", "Tax name",
              TextInputType.name, taxController),
          // spacer(10),
          // columUserTextFiledsBlack("Enter tax short name", "Tax short name", TextInputType.none, taxPercentageController),
          // spacer(10),
          // columUserTextFiledsBlack("Enter tax percentage", "Tax percentage", TextInputType.number, taxPercentageController),
          Consumer<SubCategoryProvider>(
              builder: (context, snapshot,child) {
                return snapshot.loading ?const Center(child: CircularProgressIndicator(color: blackColor,),) :Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (formKey.currentState!.validate()) {

                            if (widget.model!=null) {
                              print(widget.model!.toJson());
                              SubCategoryModel model =
                              SubCategoryModel(id: widget.model!.id,name: taxController.text, category: widget.model!.category);
                              print(model.toJson());
                              Provider.of<SubCategoryProvider>(context, listen: false)
                                  .updateFun(context,model);
                            } else{
                              SubCategoryModel model =
                              SubCategoryModel(name: taxController.text, category: widget.category,);
                              Provider.of<SubCategoryProvider>(context, listen: false)
                                  .add(model, context);
                            }

                          }
                        },
                        child: defaultButton(SizeConfig.screenWidth! * 0.5,widget.model!=null?"Update": add)),
                    InkWell(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          cancel,
                          style: TextStyle(color: blackColor),
                        ))
                  ],
                );
              }
          ),
          spacer(10)
        ],
      ),
    );
  }
}
