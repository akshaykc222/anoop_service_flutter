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
      try {
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
      } catch (e) {
        print('g');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                widget.model != null
                    ? const Text(
                        'Update Customer',
                        style: TextStyle(color: whiteColor, fontSize: 20),
                      )
                    : const Text(
                        'Create Customer',
                        style: TextStyle(color: whiteColor, fontSize: 20),
                      ),
                columUserTextFileds(
                    "Enter name", "Title", TextInputType.name, nameController),
                columUserTextFileds("Enter phone", "7907017542",
                    TextInputType.number, phoneController),
                emailWhiteField("Enter mail", "a@gmail.com",
                    TextInputType.emailAddress, mailController),
                columUserTextFileds(
                    "Enter age", "18", TextInputType.number, ageController),
                columUserTextFileds(
                    "Enter blood", "o+", TextInputType.name, bloodController),
                columUserTextFileds("Enter Country", "india",
                    TextInputType.name, countryController),
                columUserTextFileds("Enter State", "kerala", TextInputType.name,
                    stateController),
                columUserTextFileds("Enter City", "Thrissur",
                    TextInputType.name, cityController),
                columUserTextFileds("Enter address", "address",
                    TextInputType.streetAddress, addressController),
                columUserTextFileds("Pin code", "680684", TextInputType.number,
                    pincodeController),
                columUserTextFileds("insurance company", "lic",
                    TextInputType.name, insurance_company),
                InkWell(
                  onTap: () {
                    _selectDate();
                  },
                  child: expiryDate("insurance expiry", "2025-02-02",
                      TextInputType.datetime, insurance_exp),
                ),
                columUserTextFileds("insurance number", "12234",
                    TextInputType.name, insurance_num),
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
                                child: defaultButton(
                                    SizeConfig.screenWidth! * 0.5,
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
      style: const TextStyle(color: whiteColor),
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
      style: const TextStyle(color: whiteColor),
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
