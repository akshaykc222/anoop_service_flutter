
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/screens/dashbord/model/menu_model.dart';

import '../../../constants.dart';

class ServicesAdd extends StatefulWidget {
  const ServicesAdd({Key? key}) : super(key: key);

  @override
  _ServicesAddServiceState createState() => _ServicesAddServiceState();
}

class _ServicesAddServiceState extends State<ServicesAdd> {
  final List<MenuModel> menuData = [
    MenuModel(title: "Service 1", icon: Icons.maps_home_work),
    MenuModel(title: "Service 2", icon: Icons.maps_home_work),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithSearch(context,"products"),
      body: Stack(children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Services/products',
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
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
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, order);
                },
                child: defaultButton(300,"Place order")))
      ]),
    );
  }
}

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String subcat = "Sub cat 1";
  var items = [
    'Sub cat 1',
    'Sub cat 2',
  ];
  String service = "service";
  var serItems = ["service", "products"];
  String taxType = "gst";
  var taxItems = ["gst", "tax#1"];
  final title=TextEditingController();
  final discount=TextEditingController();
  final actual=TextEditingController();
  final duration=TextEditingController();
  final exp_date=TextEditingController();

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          headingText("Add prodcut/ service"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: DropdownButtonFormField(
              // Initial Value
              value: subcat,
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
                  subcat = newValue!;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: DropdownButtonFormField(
              // Initial Value
              value: service,
              decoration: InputDecoration(
                  labelText: "type",
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
          columUserTextFileds("title","title",TextInputType.name,title),
          columUserTextFileds("discount price","1800",TextInputType.number,discount),
          columUserTextFileds("actual price","1820",TextInputType.number,actual),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: DropdownButtonFormField(
              // Initial Value
              value: taxType,
              decoration: InputDecoration(
                  labelText: "tax",
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: taxItems.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  taxType = newValue!;
                });
              },
            ),
          ),
          columUserTextFileds("duration(optional)","15 hr",TextInputType.number,duration),
          columUserTextFileds("expiry date(optional)","expiry date",TextInputType.datetime,exp_date),
          defaultButton(300, add)
        ],
      ),
    );
  }
}

class CatItems extends StatefulWidget {
  final IconData icon;
  final String title;

  const CatItems({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  State<CatItems> createState() => _CatItemsState();
}

class _CatItemsState extends State<CatItems> {
  bool IsSelected = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, order);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50,
          decoration: BoxDecoration(
              color: IsSelected ? Colors.blue.shade300 : secondrayColor,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(widget.icon),
              Text(
                widget.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      IsSelected = !IsSelected;
                    });
                  },
                  child: const Icon(
                    Icons.add,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
