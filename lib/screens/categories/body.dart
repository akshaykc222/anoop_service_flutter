import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/screens/categories/componts/categoryform.dart';
import 'package:seed_sales/screens/categories/models/categories_model.dart';
import 'package:seed_sales/screens/categories/provider/category_provider.dart';
import 'package:seed_sales/screens/subcategory/body.dart';

import 'package:seed_sales/screens/tax/components/add_tax.dart';

import '../../componets.dart';
import '../../constants.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<CategoriesProvider>(context, listen: false)
          .getCategoryList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    void showAlertDelete1(BuildContext _context) {
      showModalBottomSheet(
          context: _context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          builder: (_) {
            return Padding(
              padding:  EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Wrap(
                children: const [CategoryForm()],
              ),
            );
          });
    }

    return Scaffold(
      extendBody: true,
      appBar: appBar("Categories", [], context),
      resizeToAvoidBottomInset: false,
      body: Container(
        color: lightBlack,
        child:
            Consumer<CategoriesProvider>(builder: (context, snapshot, child) {
          return snapshot.loading?const Center(child: CircularProgressIndicator(color: whiteColor,),): GridView.builder(
              shrinkWrap: true,
              itemCount: snapshot.categoryList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio:
                      MediaQuery.of(context).size.width * 0.3 / 90),
              itemBuilder: (_, index) {
                return CategoryListTile(title: snapshot.categoryList[index]);
              });
        }),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: blackColor,
        child: SizedBox(
          width: double.infinity,
          height: 50,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightBlack,
        onPressed: () {
          showAlertDelete1(context);
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class CategoryListTile extends StatelessWidget {
  final CategoriesModel title;
  const CategoryListTile({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>SubCategory(category: title.id!,)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: blackColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title.name,
                  style: const TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              spacer(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: (){
                      Provider.of<CategoriesProvider>(context,listen: false).deleteCategory(title, context);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: lightBlack),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            'assets/icons/trash.svg',
                            width: 20,
                            height: 20,
                            color: whiteColor,
                          ),
                        )),
                  ),
                  InkWell(
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          builder: (_) {
                            return Padding(
                              padding:  EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: Wrap(
                                children:  [CategoryForm(model: title,)],
                              ),
                            );
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: lightBlack),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/icons/edit.svg',
                          width: 20,
                          height: 20,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
