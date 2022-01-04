import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/Desingation/componets/list_designation.dart';

import 'models/designation_model.dart';
import 'provider/desingation_provider.dart';

class Designations extends StatefulWidget {
  const Designations({Key? key}) : super(key: key);

  @override
  State<Designations> createState() => _DesignationsState();
}

class _DesignationsState extends State<Designations> {
  final designationText = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void showAddAlert() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (_) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      columUserTextFileds("Designation title", "Designation",
                          TextInputType.name, designationText),
                      spacer(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {}
                                var random = Random();
                                Provider.of<DesignationProvider>(context,
                                        listen: false)
                                    .addBusiness(DesingationModel(
                                        designation: designationText.text),context);
                              },
                              child: defaultButton(
                                  MediaQuery.of(context).size.width * 0.4,
                                  add)),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              cancel,
                              style: TextStyle(color: blackColor),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Designations", [], context),
      body: Container(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          width: double.infinity,
          color: whiteColor,
        ),
      ),
    );
  }
}
