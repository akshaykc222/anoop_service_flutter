
import 'package:flutter/material.dart';
import 'package:seed_sales/componets.dart';

class Invoice extends StatelessWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Invoices",[],context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          defaultButton(MediaQuery.of(context).size.width*0.6, "create"),
          defaultButton(MediaQuery.of(context).size.width*0.6,"Edit invoice")
        ],
      ),
    );
  }
}
