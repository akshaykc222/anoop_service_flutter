import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/screens/bussiness/models/bussinessmode.dart';
import 'package:seed_sales/screens/bussiness/provider/business_provider.dart';
import 'package:seed_sales/screens/roles/models/role_model.dart';
import 'package:seed_sales/screens/user/models/role_models.dart';
import 'package:seed_sales/screens/user/models/user_model.dart';
import 'package:seed_sales/screens/user/provider/users_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../componets.dart';
import '../../../constants.dart';
import '../../roles/provider/role_provider.dart';
import 'add_company.dart';

class UserCreationForm extends StatefulWidget {
  const UserCreationForm({Key? key}) : super(key: key);

  @override
  _UserCreationFormState createState() => _UserCreationFormState();
}

class _UserCreationFormState extends State<UserCreationForm> {
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<BusinessProvider>(context, listen: false)
          .getBusinessList(context);
      Provider.of<BusinessProvider>(context, listen: false)
          .setDropDownValue(null);
      Provider.of<RoleProviderNew>(context, listen: false)
          .getBusinessList(context);
      Provider.of<RoleProviderNew>(context, listen: false)
          .setSelctedDropDown(null);
      Provider.of<UserProviderNew>(context, listen: false).clearList();
    });
  }

  Widget passwordField(String label, String hint, TextInputType keyboard,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Please Enter value for $hint";
          } else if (value.length < 5) {
            return "password must have at least 5 characters";
          } else if (passwordController.text != value) {
            return "password not same";
          }
          return null;
        },
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            columUserTextFileds("Enter name of the user", "Name",
                TextInputType.name, nameController),
            spacer(10),
            emailField("Enter E-mail of the user", "E-mail",
                TextInputType.emailAddress, mailController),
            spacer(10),
            columUserTextFileds("Enter phone number of the user", "Phone",
                TextInputType.phone, phoneController),
            spacer(10),
            // columUserTextFileds("Enter Designation of the user", "Designation",
            //     TextInputType.emailAddress),
            passwordField("Enter Password", "Password",
                TextInputType.visiblePassword, passwordController),
            spacer(10),
            passwordField("Confirm Password", "Confirm Password",
                TextInputType.visiblePassword, confirmPassController),
            spacer(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Text(
                    'Access company',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                ),
                InkWell(
                    onTap: () {
                      print("Dgdfg");
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          builder: (BuildContext context) {
                            return Padding(
                              padding: MediaQuery.of(context).viewInsets,
                              child: const SelectBussines(),
                            );
                          });
                    },
                    child: const Icon(
                      Icons.add,
                      size: 25,
                      color: textColor,
                    ))
              ],
            ),
            spacer(10),
            const AddCompany(),
            InkWell(onTap: () {
              if (formKey.currentState!.validate()) {
                UserModel model = UserModel(
                  name: nameController.text,
                  email: mailController.text,
                  phone: phoneController.text,
                  password: passwordController.text,
                );

                Provider.of<UserProviderNew>(context, listen: false)
                        .roleList
                        .isNotEmpty
                    ? Provider.of<UserProviderNew>(context, listen: false)
                        .addUser(model, context)
                    : ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Add company access')));
              }
            }, child:
                Consumer<UserProviderNew>(builder: (context, snapshot, child) {
              return snapshot.loading
                  ? const Center(
                      child: CircularProgressIndicator(color: whiteColor),
                    )
                  : defaultButton(MediaQuery.of(context).size.width * 0.6, add);
            })),
            spacer(60)
          ],
        ),
      ),
    );
  }
}

Widget emailField(String label, String hint, TextInputType keyboard,
    TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter value for $hint";
        } else if (!emailRegex.hasMatch(value)) {
          return "invalid email";
        }
        return null;
      },
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

Widget passwordField(String label, String hint, TextInputType keyboard,
    TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter value for $hint";
        } else if (value.length < 8) {
          return "password must have atleast 8 characters";
        }
        return null;
      },
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

// Widget designationDropDown() {}

class SelectBussines extends StatefulWidget {
  const SelectBussines({Key? key}) : super(key: key);

  @override
  State<SelectBussines> createState() => _SelectBussinesState();
}

class _SelectBussinesState extends State<SelectBussines> {
  String selectedBussines = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Add Company access",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Consumer<BusinessProvider>(builder: (context, provider, child) {
            return DropdownButtonFormField(
              value: provider.selectedBusiness,
              icon: const Icon(Icons.keyboard_arrow_down),
              decoration: InputDecoration(
                  labelText: "Bussiness",
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              items: provider.businessList
                  .map((e) => DropdownMenuItem<BusinessModel>(
                      value: e, child: Text(e.name)))
                  .toList(),
              onChanged: (BusinessModel? value) {
                provider.setDropDownValue(value!);
              },
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<RoleProviderNew>(builder: (context, provider, child) {
            return DropdownButtonFormField(
              value: provider.selectedDropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              decoration: InputDecoration(
                  labelText: "Role",
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
              items: provider.roleList
                  .map((e) => DropdownMenuItem<Roles>(
                      value: e, child: Text(e.roleName)))
                  .toList(),
              onChanged: (Roles? value) {
                provider.setSelctedDropDown(value!);
              },
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
              onTap: () {
                BusinessModel businessModel =
                    Provider.of<BusinessProvider>(context, listen: false)
                        .selectedBusiness!;
                Roles roleModel =
                    Provider.of<RoleProviderNew>(context, listen: false)
                        .selectedDropdownvalue!;
                RoleModel model = RoleModel(
                    role: roleModel.id!,
                    business: businessModel.id!,
                    name: businessModel.name);
                Provider.of<UserProviderNew>(context, listen: false)
                    .addToRoleList(model, context);

                Navigator.pop(context);
              },
              child:
                  defaultButton(MediaQuery.of(context).size.width * 0.4, add)),
        )
      ],
    );
  }
}
