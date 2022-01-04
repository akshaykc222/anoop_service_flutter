import 'package:flutter/material.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/screens/bussiness/models/bussinessmode.dart';

import 'componets/create_business.dart';

class Bussiness extends StatelessWidget {
  final BusinessModel? model;
  const Bussiness({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Bussiness", [], context),
      body: const SingleChildScrollView(
          scrollDirection: Axis.vertical, child: CreateBussiness()),
    );
  }
}
