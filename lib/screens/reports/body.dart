import 'package:flutter/material.dart';
import 'package:seed_sales/componets.dart';

class Reports extends StatelessWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Reports", [], context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          defaultButton(
              MediaQuery.of(context).size.width * 0.6, "Customer wise report"),
          spacer(10),
          defaultButton(
              MediaQuery.of(context).size.width * 0.6, "Treatment wise report"),
          spacer(10),
          defaultButton(
              MediaQuery.of(context).size.width * 0.6, "Doctor wise report"),
          spacer(10),
          defaultButton(
              MediaQuery.of(context).size.width * 0.6, "Staff wise report"),
          spacer(10),
        ],
      ),
    );
  }
}
