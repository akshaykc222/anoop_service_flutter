import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/screens/roles/componets/roles_list.dart';

import '../../../constants.dart';

class RoleFields extends StatefulWidget {
  @override
  const RoleFields({Key? key}) : super(key: key);
  _RoleFieldsState createState() => _RoleFieldsState();
}

class _RoleFieldsState extends State<RoleFields> {
  final List<String> permissionList = [
    "Role",
    "Create user",
    "Bussiness",
    "Services",
    "Products",
    "Reports"
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // GestureDetector(
          //     onTap: () {
          //       Navigator.pushNamed(context, roleList);
          //     },
          //     child: columTextFileds(context)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Text(
              "Add Permissions",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: permissionList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                return UserRolesPermission(
                    titlePermission: permissionList[index]);
              })
        ],
      ),
    );
  }
}

Widget columTextFileds(BuildContext context,TextEditingController edit) {
  return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: TextFormField(
        controller: edit,
        decoration: const InputDecoration(
            labelText: rolename,
            enabled: false,
            fillColor: Colors.white70,
            filled: true,
            labelStyle: TextStyle(color: whiteColor),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            hintText: rolename,
            hintStyle: TextStyle(color: textColor),
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: whiteColor,
              width: 1,
            ))),
      ));
}

class UserRolesPermission extends StatefulWidget {
  const UserRolesPermission({Key? key, required this.titlePermission})
      : super(key: key);

  final String titlePermission;

  @override
  State<UserRolesPermission> createState() => _UserRolesPermissionState();
}

class _UserRolesPermissionState extends State<UserRolesPermission> {
  bool create = false;
  bool delete = false;
  bool edit = false;
  bool view = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: black90,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), //color of shadow
                spreadRadius: 5, //spread radius
                blurRadius: 7, // blur radius
                offset: const Offset(0, 2),
              )
            ]),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Icon(Icons.phone_android_outlined),
                  Text(
                    widget.titlePermission,
                    style: const TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  spacer(10),
                  const Text(
                    "user",
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  )
                ],
              ),
            ),
            spacer(10),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: lightBlack,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "View",
                                style: TextStyle(color: textColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Switch(
                                value: view,
                                onChanged: (value) {
                                  setState(() {
                                    view = value;
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                                inactiveTrackColor: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: lightBlack,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Create",
                                style: TextStyle(color: textColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Switch(
                                value: create,
                                onChanged: (value) {
                                  setState(() {
                                    create = value;
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                                inactiveTrackColor: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: lightBlack,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Edit",
                                style: TextStyle(color: textColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Switch(
                                value: edit,
                                onChanged: (value) {
                                  setState(() {
                                    edit = value;
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                                inactiveTrackColor: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: lightBlack,
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Delete",
                                style: TextStyle(color: textColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Switch(
                                value: delete,
                                onChanged: (value) {
                                  setState(() {
                                    delete = value;
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                                inactiveTrackColor: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
