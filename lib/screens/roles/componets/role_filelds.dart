import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/screens/roles/componets/current_user.dart';
import 'package:seed_sales/screens/roles/models/page_model.dart';
import 'package:seed_sales/screens/roles/models/page_permission.dart';
import 'package:seed_sales/screens/roles/models/role_model.dart';
import 'package:seed_sales/screens/roles/provider/role_provider.dart';

import '../../../constants.dart';

class RoleFields extends StatefulWidget {
  @override
  const RoleFields({Key? key}) : super(key: key);
  _RoleFieldsState createState() => _RoleFieldsState();
}

class _RoleFieldsState extends State<RoleFields> {


  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<RoleProviderNew>(context,listen: false).getPages();
      Provider.of<RoleProviderNew>(context,listen: false).getBusinessList(context);
    });
  }

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
          const CurrentUser(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Text(
              "Add Permissions",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
          Consumer<RoleProviderNew>(

            builder: (context, snapshot,child) {
              return snapshot.loading? Center(child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:const [
                  Text('Saving data ..',style: TextStyle(color: whiteColor),),
                  CircularProgressIndicator(color: whiteColor,)
                ],),): ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.pageList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return UserRolesPermission(
                        titlePermission: snapshot.pageList[index]);
                  });
            }
          )
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

  final PageModel titlePermission;

  @override
  State<UserRolesPermission> createState() => _UserRolesPermissionState();
}

class _UserRolesPermissionState extends State<UserRolesPermission> {
  bool create = false;
  bool delete = false;
  bool edit = false;
  bool view = false;
  bool l=true;
  _update(PagePermission model){
    Provider.of<RoleProviderNew>(context,listen: false).addPermissionList(model);
  }

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      PagePermission? p =await Provider.of<RoleProviderNew>(context,listen: false).getPermissions(widget.titlePermission.id);
      if (this.mounted) {
        setState(() {
          l=false;
        });
        if(p!=null){
          setState(() {

            create=p.create;
            delete=p.delete;
            edit=p.update;
            view=p.edit;
          });
        }
      }


    });

  }

  @override
  Widget build(BuildContext context) {
    return l?const Center(child: CircularProgressIndicator(),): Padding(
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
                    widget.titlePermission.pageName,
                    style: const TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  spacer(10),

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

                                    Roles? r=  Provider.of<RoleProviderNew>(context,listen: false).selectedDropdownvalue;
                                    if(r==null){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select role'),));}else{
                                      view = value;
                                    PagePermission p=PagePermission(role:r.id!, pageName: widget.titlePermission.id, edit: view, create: create, update: edit, delete: delete);
                                    _update(p);}
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

                                    Roles? r=  Provider.of<RoleProviderNew>(context,listen: false).selectedDropdownvalue;
                                    if(r==null){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select role'),));}else{
                                      create = value;
                                      PagePermission p=PagePermission(role:r.id!, pageName: widget.titlePermission.id, edit: view, create: create, update: edit, delete: delete);
                                      _update(p);}
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

                                    Roles? r=  Provider.of<RoleProviderNew>(context,listen: false).selectedDropdownvalue;
                                    if(r==null){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select role'),));}else{
                                      edit = value;
                                      PagePermission p=PagePermission(role:r.id!, pageName: widget.titlePermission.id, edit: view, create: create, update: edit, delete: delete);
                                      _update(p);}
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

                                    Roles? r=  Provider.of<RoleProviderNew>(context,listen: false).selectedDropdownvalue;
                                    if(r==null){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select role'),));}else{
                                      delete = value;
                                      PagePermission p=PagePermission(role:r.id!, pageName: widget.titlePermission.id, edit: view, create: create, update: edit, delete: delete);
                                      _update(p);}
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
