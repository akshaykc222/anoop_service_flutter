import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/categories/models/categories_model.dart';
import 'package:seed_sales/screens/categories/provider/category_provider.dart';
import 'package:seed_sales/sizeconfig.dart';

import '../../../componets.dart';

class CategoryForm extends StatefulWidget {
  final CategoriesModel? model;
  const CategoryForm({Key? key,this.model}) : super(key: key);

  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final taxController = TextEditingController();
  final taxShortController = TextEditingController();
  final taxPercentageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (widget.model!=null) {
        Provider.of<CategoriesProvider>(context, listen: false)
            .updateNavigate(context,widget.model!);
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
         widget.model!=null?headingText("Update Categories"): headingText("Add Categories"),
          spacer(10),
          columUserTextFiledsBlack("Enter category name", "Tax name",
              TextInputType.name, taxController),
          // spacer(10),
          // columUserTextFiledsBlack("Enter tax short name", "Tax short name", TextInputType.none, taxPercentageController),
          // spacer(10),
          // columUserTextFiledsBlack("Enter tax percentage", "Tax percentage", TextInputType.number, taxPercentageController),
          Consumer<CategoriesProvider>(
            builder: (context, snapshot,child) {
              return snapshot.loading ?const Center(child: CircularProgressIndicator(color: blackColor,),) :Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (formKey.currentState!.validate()) {

                          if (widget.model!=null) {
                            CategoriesModel model =
                            CategoriesModel(id: widget.model!.id,name: taxController.text);
                            int? id=widget.model!.id;
                            Provider.of<CategoriesProvider>(context, listen: false)
                                .updateCategory(context,model);
                          } else{
                            CategoriesModel model =
                            CategoriesModel(name: taxController.text);
                            Provider.of<CategoriesProvider>(context, listen: false)
                                .addCategory(model, context);
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
