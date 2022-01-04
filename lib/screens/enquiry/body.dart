
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/screens/customers/models/country_model.dart';
import 'package:seed_sales/screens/customers/provider/customer_provider.dart';
import 'package:seed_sales/screens/enquiry/model/appointmentsmodel.dart';
import 'package:seed_sales/screens/enquiry/provider/appointment_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:uuid/uuid.dart';

import '../../componets.dart';
import '../../constants.dart';

class Enquiry extends StatefulWidget {
  const Enquiry({Key? key}) : super(key: key);

  @override
  State<Enquiry> createState() => _EnquiryState();
}

class _EnquiryState extends State<Enquiry> {

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<AppointmentProvider>(context,listen: false).getCategoryList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: appBar("Appointments",[],context),
      body: Column(
        children: [
          // columUserTextFileds("search","",TextInputType.name,TextEditingController()),
          spacer(10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Row(
          //         children: const [Text("sort by"), Icon(Icons.arrow_downward)],
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Row(
          //         children: const [Text("Filter"), Icon(Icons.arrow_downward)],
          //       ),
          //     )
          //   ],
          // ),
          const Divider(),
          spacer(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF0D47A1),
                              Color(0xFF1976D2),
                              Color(0xFF42A5F5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(8.0),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, order);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.add),
                          Text('Book appointment')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
           Consumer<AppointmentProvider>(

             builder: (context, snapshot,child) {

               return ListView.builder(
                 itemCount:snapshot.categoryList.length ,
                   shrinkWrap: true,
                   itemBuilder: (_,index){
                   return EnquiryCustomer(model: snapshot.categoryList[index],);
                   }
               );
             }
           )
        ],
      ),
    );
  }
}

class EnquiryCustomer extends StatefulWidget {
  final AppointMentModel model;
  const EnquiryCustomer({Key? key,required this.model}) : super(key: key);

  @override
  State<EnquiryCustomer> createState() => _EnquiryCustomerState();
}

class _EnquiryCustomerState extends State<EnquiryCustomer> {
  String dropdownvalue = 'enquired';

  // List of items in our dropdown menu
  var items = ['enquired', 'advance paid', 'completed', 'canceled'];
  CustomerModel? customerModel;
  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async{

      switch(widget.model.status){
        case "P":setState(() {
          print("==================e");
          dropdownvalue="enquired";
        });

        break;
        case "E":setState(() {
          print("==================e");
          dropdownvalue="enquired";
        });

        break;
        case "A":setState(() {
          print("==================ap");
          dropdownvalue="advance paid";
        });
        break;
        case "C":setState(() {
          print("==================c");
          dropdownvalue="completed";
        });
        break;
        case "F":setState(() {
          print("==================f");
          dropdownvalue="canceled";
        });
        break;
      }

      customerModel=await  Provider.of<CustomerProvider>(context, listen: false).getCategoryListWithId(context, widget.model.customer);
       setState(() {
         customerModel;

       });
    });
  }
  writePdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(

            children: [
              pw.Text("customer name : ${customerModel!.name}"),
              pw.SizedBox(height: 10),
              pw.Text("customer phone : ${customerModel!.phone}"),
              pw.SizedBox(height: 10),
              pw.Text("customer address : ${customerModel!.address}"),
              pw.SizedBox(height: 10),
              pw.Text("status : $dropdownvalue"),
              pw.SizedBox(height: 10),
              pw.Text("booking date : ${widget.model.bookingDate}"),
            ]
          ); // Center
        }));
        Uuid uuid=Uuid();
      final output = await getTemporaryDirectory();
     final file = File("${output.path}/Recipt${uuid.v1()}.pdf");
      print(file.absolute);
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
  }


  @override
  Widget build(BuildContext context) {
    return customerModel==null?const Center(child: CircularProgressIndicator(),): Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.99,

        decoration: BoxDecoration(
            color: widget.model.status=="F"?Colors.red.shade300: secondrayColor, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  [

                  Text(customerModel!.name!),
                  Text(widget.model.createdDate.toString())
                ],
              ),
            ),
            spacer(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  [
                  Text("Booked date: ${widget.model.bookingDate}"),

                ],
              ),
            ),
            spacer(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Status :"),
                const SizedBox(
                  width: 10,
                ),
                DropdownButton(
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    log("${widget.model.status}===========================$dropdownvalue");
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {

                    switch(newValue){
                      case "enquired":widget.model.status="E";
                      break;
                      case "advance paid":widget.model.status="A";
                      break;
                      case "completed":widget.model.status="C";
                      break;
                      case "canceled":widget.model.status="F";
                      break;
                    }

                    Provider.of<AppointmentProvider>(context,listen: false).updateCategory(context, widget.model);
                  },
                ),

                const Text(
                  "view  details",
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF0D47A1),
                                Color(0xFF1976D2),
                                Color(0xFF42A5F5),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(8.0),
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          writePdf();
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.download),
                            Text('Booking report')
                          ],
                        ),
                      ),
                    ],
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
