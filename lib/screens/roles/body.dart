import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/screens/roles/provider/role_provider.dart';

import '../../constants.dart';
import 'componets/current_user.dart';
import 'componets/role_filelds.dart';

class UserRoles extends StatelessWidget {
  const UserRoles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, roleList);
        return false;
      },
      child: Scaffold(
        appBar: appBar("User Roles", [], context),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: lightBlack,
            child: Column(
              children: const [RoleFields()],
            ),
          ),
        ),
        // floatingActionButton: Container(
        //   width: 100,
        //   height: 50,
        //   decoration: BoxDecoration(
        //       color: primaryColor, borderRadius: BorderRadius.circular(20.0)),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //     children: const [
        //       Icon(
        //         Icons.save,
        //         color: Colors.white,
        //       ),
        //       Text(
        //         save,
        //         style:
        //             TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //       )
        //     ],
        //   ),
        // ),
        bottomNavigationBar: const BottomAppBar(
          color: black90,
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle(),
          child: SizedBox(
            width: double.infinity,
            height: 50,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: lightBlack,
          onPressed: () {
            Provider.of<RoleProviderNew>(context, listen: false)
                .updatePermissions(context);
          },
          child: const Center(
            child: Icon(
              Icons.done,
              color: textColor,
              size: 30,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
