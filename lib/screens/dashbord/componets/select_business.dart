import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/bussiness/models/bussinessmode.dart';
import 'package:seed_sales/screens/dashbord/provider/assigned_business_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessSelectPopup extends StatefulWidget {
  const BusinessSelectPopup({Key? key}) : super(key: key);

  @override
  State<BusinessSelectPopup> createState() => _BusinessSelectPopupState();
}

class _BusinessSelectPopupState extends State<BusinessSelectPopup> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<AssignedBussinessProvider>(context,listen: false).getBussienss();
    });
  }
  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Assigned business for you",style: TextStyle(color: blackColor,fontSize: 23,fontWeight: FontWeight.bold),),
        ),
        spacer(10),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Please select a default business"),
        ),
        Consumer<AssignedBussinessProvider>(

          builder: (context, snapshot,child) {
            return snapshot.loading?const Center(child: CircularProgressIndicator(),) :snapshot.businessList.isEmpty?const Center(child: Text("You are not assigned to any business please contact admin"),): ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.businessList.length,
                itemBuilder: (context,index){
                  return SelectBusinessTile(model: snapshot.businessList[index],);
                }
            );
          }
        )
      ],
    );
  }
}

class SelectBusinessTile extends StatelessWidget {
  final BusinessModel model;
  const SelectBusinessTile({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async{
          SharedPreferences pref=await SharedPreferences.getInstance();
          pref.setInt('selected_business', model.id!);
          Provider.of<AssignedBussinessProvider>(context,listen: false).setDefaultBusiness(model.id!);
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius:BorderRadius.circular(10) ,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), //color of shadow
                spreadRadius: 5, //spread radius
                blurRadius: 7, // blur radius
                offset: const Offset(0, 2), // changes position of shadow

              )
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(model.name,style:const TextStyle(color: blackColor,fontWeight: FontWeight.bold,fontSize: 18),),),
          ),
        ),
      ),

    );
  }
}
