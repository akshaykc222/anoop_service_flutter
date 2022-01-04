import 'package:flutter/material.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/sizeconfig.dart';

import '../../../componets.dart';

class RegionForm extends StatefulWidget {
  const RegionForm({Key? key}) : super(key: key);

  @override
  _RegionFormState createState() => _RegionFormState();
}

class _RegionFormState extends State<RegionForm> {
  final taxController=TextEditingController();
  final taxShortController=TextEditingController();
  final taxPercentageController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        headingText("Add Region"),
        spacer(10),
        columUserTextFiledsBlack("Enter Region name", "Region name", TextInputType.none, taxController),
        spacer(10),
        // columUserTextFiledsBlack("Enter tax short name", "Tax short name", TextInputType.none, taxPercentageController),
        // spacer(10),
        // columUserTextFiledsBlack("Enter tax percentage", "Tax percentage", TextInputType.number, taxPercentageController),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            defaultButton(SizeConfig.screenWidth!*0.5, add),

            InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child:const Text(cancel,style: TextStyle(color: blackColor),))
          ],
        ),
        spacer(10)
      ],
    );
  }
}
