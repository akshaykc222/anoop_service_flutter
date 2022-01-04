
import 'package:flutter/material.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/dashbord/model/menu_model.dart';

import '../../../componets.dart';

class CategoryService extends StatefulWidget {
  const CategoryService({Key? key}) : super(key: key);

  @override
  _CategoryServiceState createState() => _CategoryServiceState();
}

class _CategoryServiceState extends State<CategoryService> {
  final List<MenuModel> menuData = [
    MenuModel(title: "Cate1", icon: Icons.maps_home_work),
    MenuModel(title: "Cate2", icon: Icons.maps_home_work),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spacer(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Category',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
                onTap: () {
                  print("Dgdfg");
                  showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      builder: (BuildContext context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: const AddCategory(),
                        );
                      });
                },
                child: const Icon(
                  Icons.add,
                  size: 25,
                ))
          ],
        ),
        spacer(10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 5,
                ),
                itemCount: menuData.length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return CatItems(
                    icon: menuData[index].icon,
                    title: menuData[index].title,
                  );
                }),
          ),
        )
      ],
    );
  }
}

class AddCategory extends StatelessWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        headingText("Add Category"),
        // columUserTextFileds("cat     egory name"),
        // defaultButton(add, context)
      ],
    );
  }
}

class CatItems extends StatelessWidget {
  final IconData icon;
  final String title;

  const CatItems({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, subCategory);
      },
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
                decoration: const BoxDecoration(
                    color: blackColor, shape: BoxShape.circle),
                child: Center(
                  child: Icon(icon),
                )),
          ),
          spacer(10),
          Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          )
        ],
      ),
    );
  }
}
