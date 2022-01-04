import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/screens/customers/models/country_model.dart';

import 'package:seed_sales/screens/customers/provider/customer_provider.dart';

import '../../../constants.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithSearch(context, "Customers"),
      body: Consumer<CustomerProvider>(builder: (context, provider, child) {
        return provider.loading?const Center(child: CircularProgressIndicator(),) :GridView.builder(
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
            ),
          itemCount: provider.customerList.length,
          itemBuilder: (_, index) {
          return TaxListTile(model: provider.customerList[index]);
        });
      }),
      floatingActionButton: FloatingActionButton(onPressed: (){

      },
      backgroundColor: black90,
      child:const Center(child:  Icon(Icons.add,size: 25,color: whiteColor,)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: blackColor,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,

        ),
      ),
    );
  }
}

class TaxListTile extends StatelessWidget {
  final CustomerModel model;
  const TaxListTile({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: blackColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              model.name!,
              style: const TextStyle(
                  color: textColor, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            spacer(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: lightBlack),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/icons/trash.svg',
                        width: 20,
                        height: 20,
                        color: whiteColor,
                      ),
                    )),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: lightBlack),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/icons/edit.svg',
                      width: 20,
                      height: 20,
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
