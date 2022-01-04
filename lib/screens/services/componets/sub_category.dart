
import 'package:flutter/material.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/dashbord/model/menu_model.dart';

class SubCategory extends StatefulWidget {
  const SubCategory({Key? key}) : super(key: key);

  @override
  _SubCategoryServiceState createState() => _SubCategoryServiceState();
}

class _SubCategoryServiceState extends State<SubCategory> {
  final List<MenuModel> menuData = [
    MenuModel(title: "SubCate1", icon: Icons.maps_home_work),
    MenuModel(title: "SubCate2", icon: Icons.maps_home_work),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Sub Category",[],context),
      body: Column(
        children: [
          spacer(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Sub Category',
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
                            child: const AddSubCategory(),
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
      ),
    );
  }
}

class AddSubCategory extends StatefulWidget {
  const AddSubCategory({Key? key}) : super(key: key);

  @override
  State<AddSubCategory> createState() => _AddSubCategoryState();
}

class _AddSubCategoryState extends State<AddSubCategory> {
  String dropdownvalue = 'cate 1';

  // List of items in our dropdown menu
  var items = [
    'cate 1',
    'cate 2',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        headingText("Add subcategory"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: DropdownButtonFormField(
            // Initial Value
            value: dropdownvalue,
            decoration: InputDecoration(
                labelText: "Sub Category",
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15))),
            // Down Arrow Icon
            icon: const Icon(Icons.keyboard_arrow_down),

            // Array list of items
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
              });
            },
          ),
        ),
        // columUserTextFileds("Sub category name"),
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
       // Navigator.pushNamed(context, products);
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
