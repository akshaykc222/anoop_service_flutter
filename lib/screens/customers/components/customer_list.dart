import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/screens/customers/models/country_model.dart';
import 'package:seed_sales/screens/customers/provider/customer_provider.dart';
import 'package:intl/intl.dart';
import 'package:seed_sales/screens/user/componets/user_creation_form.dart';
import '../../../componets.dart';
import '../../../constants.dart';
import '../../../sizeconfig.dart';

class CustomerForm extends StatefulWidget {
  final CustomerModel? model;
  const CustomerForm({Key? key, this.model}) : super(key: key);

  @override
  _CustomerFormState createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final mailController = TextEditingController();
  final bloodController = TextEditingController();
  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final pincodeController = TextEditingController();
  final insurance_company = TextEditingController();
  final insurance_exp = TextEditingController();
  final insurance_num = TextEditingController();
  final formKey = GlobalKey<FormState>();
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

        insurance_exp.text =
            "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
      });
    }
  }

  _upload() {
    if (formKey.currentState!.validate()) {
      CustomerModel model = CustomerModel(
          name: nameController.text,
          age: int.parse(ageController.text),
          phone: phoneController.text,
          country: countryController.text,
          state: stateController.text,
          city: cityController.text,
          pincode: int.parse(pincodeController.text),
          address: addressController.text,
          insurance_comapny: insurance_company.text,
          insurance_expiry: insurance_exp.text,
          insurance_num: insurance_num.text);
      Provider.of<CustomerProvider>(context, listen: false)
          .addCategory(model, context);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      nameController.text = widget.model!.name!;
      ageController.text = widget.model!.age.toString();
      phoneController.text = widget.model!.phone;
      stateController.text = widget.model!.state;
      bloodController.text = widget.model!.blood;
      countryController.text = widget.model!.country;
      stateController.text = widget.model!.state;
      cityController.text = widget.model!.city;
      addressController.text = widget.model!.address;
      pincodeController.text = widget.model!.pincode.toString();
      insurance_company.text = widget.model!.insurance_comapny;
      insurance_exp.text = widget.model!.insurance_expiry.toString();
      insurance_num.text = widget.model!.insurance_num;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            widget.model != null
                ? headingText("Update Customer")
                : headingText("Add Customer"),
            columUserTextFiledsBlack(
                "Enter name", "Title", TextInputType.name, nameController),
            columUserTextFiledsBlack("Enter phone", "7907017542",
                TextInputType.number, phoneController),
            emailWhiteField("Enter mail", "a@gmail.com",
                TextInputType.emailAddress, mailController),
            columUserTextFiledsBlack(
                "Enter age", "18", TextInputType.number, ageController),
            columUserTextFiledsBlack(
                "Enter blood", "o+", TextInputType.name, bloodController),
            columUserTextFiledsBlack("Enter Country", "india",
                TextInputType.name, countryController),
            columUserTextFiledsBlack(
                "Enter State", "kerala", TextInputType.name, stateController),
            columUserTextFiledsBlack(
                "Enter City", "Thrissur", TextInputType.name, cityController),
            columUserTextFiledsBlack("Enter address", "address",
                TextInputType.streetAddress, addressController),
            columUserTextFiledsBlack(
                "Pin code", "680684", TextInputType.number, pincodeController),
            columUserTextFiledsBlack("insurance company", "lic",
                TextInputType.name, insurance_company),
            InkWell(
              onTap: () {
                _selectDate();
              },
              child: expiryDate("insurance expiry", "2025-02-02",
                  TextInputType.datetime, insurance_exp),
            ),
            columUserTextFiledsBlack(
                "insurance number", "12234", TextInputType.name, insurance_num),
            spacer(10),
            // Visibility(
            //     visible: !isService, child: columUserTextFileds("Duration")),
            Consumer<CustomerProvider>(builder: (context, snapshot, child) {
              return snapshot.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {
                              _upload();
                            },
                            child: defaultButton(SizeConfig.screenWidth! * 0.5,
                                widget.model != null ? "update" : add)),
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              cancel,
                              style: TextStyle(color: blackColor),
                            ))
                      ],
                    );
            }),
            spacer(10)
          ],
        ),
      ),
    );
  }
}

Widget expiryDate(String label, String hint, TextInputType keyboard,
    TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter value for $hint";
        }
        return null;
      },
      enabled: false,
      controller: controller,
      keyboardType: keyboard,
      style: const TextStyle(color: blackColor),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: blackColor),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: hint,
          hintStyle: const TextStyle(color: blackColor),
          filled: true,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: blackColor,
              width: 2.0,
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: blackColor)),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: blackColor))),
    ),
  );
}

Widget emailWhiteField(String label, String hint, TextInputType keyboard,
    TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter value for $hint";
        } else if (!emailRegex.hasMatch(value)) {
          return "invaild email address";
        }
        return null;
      },
      controller: controller,
      keyboardType: keyboard,
      style: const TextStyle(color: blackColor),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: blackColor),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: hint,
          hintStyle: const TextStyle(color: blackColor),
          filled: true,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: blackColor,
              width: 2.0,
            ),
          ),
          disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: blackColor)),
          border: const UnderlineInputBorder(
              borderSide: BorderSide(color: blackColor))),
    ),
  );
}
