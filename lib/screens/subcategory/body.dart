import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/screens/categories/provider/category_provider.dart';
import 'package:seed_sales/screens/subcategory/components/subcategory_form.dart';
import 'package:seed_sales/screens/subcategory/models/sub_category.dart';
import 'package:seed_sales/screens/subcategory/provider/sub_category_provider.dart';

import '../../componets.dart';
import '../../constants.dart';

class SubCategory extends StatefulWidget {
  final int category;
  const SubCategory({Key? key,required this.category}) : super(key: key);

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<SubCategoryProvider>(context, listen: false)
          .get(context,widget.category);
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
                children:  [SubCategoryForm(category: widget.category,)],
              ),
            );
          });
    }

    return Scaffold(
      extendBody: true,
      appBar: appBar("Sub Categories", [], context),
      resizeToAvoidBottomInset: false,
      body: Container(
        color: lightBlack,
        child:
        Consumer<SubCategoryProvider>(builder: (context, snapshot, child) {
          return snapshot.loading?const Center(child: CircularProgressIndicator(color: whiteColor,),): GridView.builder(
              shrinkWrap: true,
              itemCount: snapshot.subcategoryList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio:
                  MediaQuery.of(context).size.width * 0.3 / 90),
              itemBuilder: (_, index) {
                return SubCategoryListTile(title: snapshot.subcategoryList[index],category: widget.category,);
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

class SubCategoryListTile extends StatelessWidget {
  final SubCategoryModel title;
  final int category;
  const SubCategoryListTile({Key? key, required this.title,required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    Provider.of<SubCategoryProvider>(context,listen: false).delete(title, context);
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
                              children:  [SubCategoryForm(model: title,category: category,)],
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
    );
  }
}
