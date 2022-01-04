import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/screens/categories/componts/categoryform.dart';
import 'package:seed_sales/screens/roles/provider/role_provider.dart';

import '../../../constants.dart';

class CurrentUser extends StatelessWidget {
  const CurrentUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<RoleProviderNew>(context,listen: false).getBusinessList(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:  [
        Consumer<RoleProviderNew>(

          builder: (context, snapshot,child) {
            return  Padding(
              padding:const EdgeInsets.all(8.0),
              child: Text(
                snapshot.selectedDropdownvalue==null?'please select a role':'selected role  : ${snapshot.selectedDropdownvalue!.roleName}',
                style: const TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
              ),
            );
          }
        ),
        InkWell(
            onTap: (){

                   Navigator.pushNamed(context, roleList);

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset('assets/icons/edit.svg',color: textColor,),
            ))
      ],
    );
  }
}
