import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/screens/categories/models/categories_model.dart';
import 'package:seed_sales/screens/categories/provider/category_provider.dart';
import 'package:seed_sales/screens/subcategory/models/sub_category.dart';
import 'package:seed_sales/screens/subcategory/provider/sub_category_provider.dart';

class CategorySelection extends StatefulWidget {
  const CategorySelection({Key? key}) : super(key: key);

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  bool visible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<CategoriesProvider>(context, listen: false).emptyDropdown();
      Provider.of<SubCategoryProvider>(context, listen: false).emptyDropDown();
      Provider.of<CategoriesProvider>(context, listen: false)
          .getCategoryList(context);
      // Provider.of<SubCategoryProvider>(context, listen: false)
      //     .get();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: visible,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Category',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        print("Dgdfg");
                        // showModalBottomSheet(
                        //     context: context,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10.0),
                        //     ),
                        //     builder: (BuildContext context) {
                        //       return Padding(
                        //         padding: MediaQuery.of(context).viewInsets,
                        //         child: const AddCategory(),
                        //       );
                        //     });
                      },
                      child: const Icon(
                        Icons.add,
                        size: 25,
                      ))
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Consumer<CategoriesProvider>(
                    builder: (context, snapshot, child) {
                  return snapshot.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : snapshot.categoryList.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : DropdownButtonFormField<CategoriesModel>(
                              // Initial Value
                              value: snapshot.selectedCategory,
                              decoration: InputDecoration(
                                  labelText: " Category",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.auto,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),

                              // Array list of items
                              items: snapshot.categoryList.map((e) {
                                return DropdownMenuItem<CategoriesModel>(
                                  value: e,
                                  child: Text(e.name),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (CategoriesModel? newValue) {
                                Provider.of<SubCategoryProvider>(context,
                                        listen: false)
                                    .get(context, newValue!.id!);
                                Provider.of<SubCategoryProvider>(context,
                                        listen: false)
                                    .emptyDropDown();
                                snapshot.setDropDownValue(newValue);
                              },
                            );
                }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Consumer<SubCategoryProvider>(
                    builder: (context, snapshot, child) {
                  return snapshot.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : DropdownButtonFormField<SubCategoryModel>(
                          // Initial Value
                          value: snapshot.selectedCategory,
                          decoration: InputDecoration(
                              labelText: "Sub Category",
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: snapshot.subcategoryList.map((e) {
                            return DropdownMenuItem<SubCategoryModel>(
                              value: e,
                              child: Text(e.name),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (SubCategoryModel? newValue) {
                            snapshot.setDropDownValue(newValue!);
                          },
                        );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
