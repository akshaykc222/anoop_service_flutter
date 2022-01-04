import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/roles/models/role_model.dart';
import 'package:seed_sales/screens/roles/provider/role_provider.dart';
import 'package:seed_sales/sizeconfig.dart';
import 'package:uuid/uuid.dart';

import '../../../componets.dart';

class RoleForm extends StatefulWidget {
  const RoleForm({Key? key}) : super(key: key);

  @override
  _RoleFormState createState() => _RoleFormState();
}

class _RoleFormState extends State<RoleForm> {
  final taxController=TextEditingController();
  final roleEdit=TextEditingController();
  final taxPercentageController=TextEditingController();
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Form(
      key: formKey,
      child: Column(
        children: [
          headingText("Add Role"),
          spacer(10),
          columUserTextFiledsBlack("Enter Role name", "Role name", TextInputType.name, roleEdit),
          spacer(10),
          // columUserTextFiledsBlack("Enter tax short name", "Tax short name", TextInputType.none, taxPercentageController),
          // spacer(10),
          // columUserTextFiledsBlack("Enter tax percentage", "Tax percentage", TextInputType.number, taxPercentageController),
          Consumer<RoleProviderNew>(

            builder: (context, snapshot,child) {
              return snapshot.loading?const Center(child: CircularProgressIndicator(),): Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
      onTap: ()
        {
        print("gbgb");
        if(formKey.currentState!.validate()){
        print("gbgb");
        var uuid=const Uuid();
        Roles role=Roles( roleName: roleEdit.text);
        Provider.of<RoleProviderNew>(context,listen: false).addBusiness(role, context,false);
        }else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter role name")));
        }
        },
                      child: defaultButton(SizeConfig.screenWidth!*0.5, add)),

                  InkWell(
                      onTap: (){
                        Navigator.pop(context);

                      },
                      child:const Text(cancel,style: TextStyle(color: blackColor),))
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
