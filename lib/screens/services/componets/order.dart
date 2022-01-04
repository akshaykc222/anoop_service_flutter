import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/screens/customers/models/country_model.dart';
import 'package:seed_sales/screens/customers/provider/customer_provider.dart';
import 'package:seed_sales/screens/enquiry/model/appointmentsmodel.dart';
import 'package:seed_sales/screens/enquiry/provider/appointment_provider.dart';
import 'package:seed_sales/screens/products/body.dart';
import 'package:seed_sales/screens/products/provider/products_provider.dart';
import 'package:seed_sales/screens/services/componets/select_product.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants.dart';

class OrderProducts extends StatefulWidget {
  const OrderProducts({Key? key}) : super(key: key);

  @override
  _OrderProductsState createState() => _OrderProductsState();
}

class _OrderProductsState extends State<OrderProducts> {
  final name = TextEditingController();
  final age = TextEditingController();
  final phone = TextEditingController();
  final mail = TextEditingController();
  final address = TextEditingController();
  final date = TextEditingController();
  final time = TextEditingController();
  final proposed_fee = TextEditingController();
  final actual_fee = TextEditingController();
  final amount_paid = TextEditingController();
  final pending = TextEditingController();
  final main_consultant = TextEditingController();
  final in_consultant = TextEditingController();
  final rem_date = TextEditingController();
  final description = TextEditingController();
  final refferd = TextEditingController();
  final formKey=GlobalKey<FormState>();
  DateTime? bookDate;
  DateTime? bookTime;
  DateTime? reminderdate;
  Future<void> _showBookingRemPicker()async{
    final DateTime? picked=await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 360)));
    if(picked != null)
    {
      setState(() {
        rem_date.text=DateFormat("yyyy-MM-dd").format(picked);
        reminderdate=picked;
      });

    }
  }
  Future<void> _showTimePicker()async{
    final TimeOfDay? picked=await showTimePicker(context: context,initialTime: TimeOfDay(hour: 5,minute: 10));
    if(picked != null)
    {
      setState(() {
        time.text=picked.format(context);

      });
    }
  }

  Future<void> _showBookingPicker()async{
    final DateTime? picked=await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 360)));
    if(picked != null)
    {
      setState(() {
        date.text=DateFormat("yyyy-MM-dd").format(picked);
        bookDate=picked;
      });

    }
  }
  DateTime selectedDate = DateTime.now();
  _selectDate() async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 320)),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<CustomerProvider>(context, listen: false).emptyDropdown();
      Provider.of<ProductProvider>(context, listen: false).emptyAppointmentList();
      Provider.of<CustomerProvider>(context, listen: false).getCategoryList(context);


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Appointments", [], context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                child: Consumer<CustomerProvider>(
                    builder: (context, provider, child) {
                  return DropdownButtonFormField(
                    value: provider.selectedCategory,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    decoration: defaultDecoration(
                        "select Customer", "Select Customer"),
                    items: provider.customerList
                        .map((e) => DropdownMenuItem<CustomerModel>(
                            value: e, child: Text(e.name!)))
                        .toList(),
                    onChanged: (CustomerModel? value) {
                      provider.setDropDownValue(value!);
                    },
                  );
                }),
              ),
               InkWell(
                 onTap: (){
                   Navigator.pushNamed(context, products);
                 },
                   child:const Text("Not listed?. add here",style: TextStyle(color: Colors.blue),)),
              InkWell(
                onTap: (){
                  _showBookingPicker();
                },
                child: dateFiled(
                    "Booking date", "11/11/2021", TextInputType.datetime, date),
              ),
              InkWell(
                onTap: (){
                  _showTimePicker();
                },
                child: dateFiled(
                    "Booking time", "10.00 am", TextInputType.datetime, time),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: ClipRRect(
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
                          showModalBottomSheet(
                            context: context,
                            useRootNavigator: true,
                            builder: (context) {
                              return const ProductListAppointment();
                            },
                          );
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.add),
                            Text('Select Treatments')
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              //   child: DropdownButtonFormField(
              //     // Initial Value
              //     value: refferd,
              //     decoration: InputDecoration(
              //         labelText: "Referred By",
              //         floatingLabelBehavior: FloatingLabelBehavior.auto,
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(15))),
              //     // Down Arrow Icon
              //     icon: const Icon(Icons.keyboard_arrow_down),

              //     // Array list of items
              //     items: staffs.map((String items) {
              //       return DropdownMenuItem(
              //         value: items,
              //         child: Text(items),
              //       );
              //     }).toList(),
              //     // After selecting the desired option,it will
              //     // change button value to selected value
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         refferd = newValue!;
              //       });
              //     },
              //   ),
              // ),
              columUserTextFileds(
                  "referred By", "rajan", TextInputType.name, refferd),
              columUserTextFileds(
                  "Proposed fee", "1500", TextInputType.number, proposed_fee),
              columUserTextFileds(
                  "Customer fee", "1600", TextInputType.number, actual_fee),
              columUserTextFileds(
                  "Amount Paid", "330", TextInputType.number, amount_paid),
              columUserTextFileds(
                  "Due amount", "1270", TextInputType.number, pending),
              InkWell(
                  onTap: (){
                    _showBookingRemPicker();
                  },
                  child: dateFiled("reminder date", "reminder",TextInputType.none, rem_date))
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              //   child: DropdownButtonFormField(
              //     // Initial Value
              //     value: doctorSel,
              //     decoration: InputDecoration(
              //         labelText: "Initial consultant",
              //         floatingLabelBehavior: FloatingLabelBehavior.auto,
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(15))),
              //     // Down Arrow Icon
              //     icon: const Icon(Icons.keyboard_arrow_down),

              //     // Array list of items
              //     items: doctors.map((String items) {
              //       return DropdownMenuItem(
              //         value: items,
              //         child: Text(items),
              //       );
              //     }).toList(),
              //     // After selecting the desired option,it will
              //     // change button value to selected value
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         doctorSel = newValue!;
              //       });
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              //   child: DropdownButtonFormField(
              //     // Initial Value
              //     value: doctorSel,
              //     decoration: InputDecoration(
              //         labelText: "Main consultant",
              //         floatingLabelBehavior: FloatingLabelBehavior.auto,
              //         border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(15))),
              //     // Down Arrow Icon
              //     icon: const Icon(Icons.keyboard_arrow_down),

              //     // Array list of items
              //     items: doctors.map((String items) {
              //       return DropdownMenuItem(
              //         value: items,
              //         child: Text(items),
              //       );
              //     }).toList(),
              //     // After selecting the desired option,it will
              //     // change button value to selected value
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         doctorSel = newValue!;
              //       });
              //     },
              //   ),
              // ),
              ,columUserTextFileds("initial consultant", "Dr ravi",
                  TextInputType.name,in_consultant ),
              columUserTextFileds("Main consultant", "Dr ravi",
                  TextInputType.name, main_consultant),

              columUserTextFileds(
                  "Notes", " decription", TextInputType.multiline, description),
              InkWell(
                  onTap: () async {
                   if (formKey.currentState!.validate()) {
                     var selec_customer=Provider.of<CustomerProvider>(context,listen: false).selectedCategory;
                     AppointMentModel model=AppointMentModel(bookingDate: bookDate!, proposedFee: double.parse(proposed_fee.text), customerFee: double.parse(actual_fee.text), amountPaid: double.parse(amount_paid.text), dueAmount: double.parse(pending.text),  reminderDate: reminderdate!, notes:description.text ,  customer: selec_customer!.id!, initialConsultant: 1, mainConsultant: 1,refferdBy: 1);

                     Provider.of<AppointmentProvider>(context,listen: false).addCategory(model, context);







                   }
                  },
                  child: Consumer<AppointmentProvider>(

                    builder: (context, snapshot,child) {
                      return snapshot.loading?Center(child: const CircularProgressIndicator(),) :defaultButton(300, "Book Customer");
                    }
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
Widget dateFiled(String label, String hint, TextInputType keyboard,
    TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please select value for $hint";
        }
        return null;
      },
      enabled: false,
      controller: controller,
      keyboardType: keyboard,
      style: const TextStyle(color: textColor),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: whiteColor,
            fontSize: 13,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: hint,
          hintStyle: const TextStyle(color: textColor),
          filled: true,
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red.shade500, width: 1)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade500, width: 1)),
          disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white30)),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white30))),
    ),
  );
}