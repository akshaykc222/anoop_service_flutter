import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/constants.dart';

import 'componets/user_creation_form.dart';

class UserCreation extends StatelessWidget {
  const UserCreation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: appBar("User Creation", [], context),
      body: Container(
        color: lightBlack,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: const [UserCreationForm()],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: black90,
      //   onPressed: () {},
      //   child: const Center(
      //     child: Icon(Icons.done, color: textColor),
      //   ),
      // ),
      // bottomNavigationBar: const BottomAppBar(
      //   color: blackColor,
      //   clipBehavior: Clip.antiAlias,
      //   shape: CircularNotchedRectangle(),
      //   child: SizedBox(
      //     height: 50,
      //     width: double.infinity,
      //   ),
      // ),
    );
  }
}
