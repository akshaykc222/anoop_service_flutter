import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/roles/body.dart';
import 'package:seed_sales/screens/roles/componets/add_role.dart';
import 'package:seed_sales/screens/roles/models/role_model.dart';
import 'package:seed_sales/screens/roles/provider/role_provider.dart';
import 'package:seed_sales/sizeconfig.dart';

class RoleList extends StatefulWidget {
  const RoleList({Key? key}) : super(key: key);

  @override
  _RoleListState createState() => _RoleListState();
}

class _RoleListState extends State<RoleList> {
  void showAddRole(BuildContext _context) {
    showModalBottomSheet(
        context: _context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (_) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: const [RoleForm()],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<RoleProviderNew>(context, listen: false)
          .getBusinessList(context);
      Provider.of<RoleProviderNew>(context, listen: false)
          .setSelctedDropDown(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: appBar("Roles", [], context),
      body: Container(
          color: lightBlack,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child:
                Consumer<RoleProviderNew>(builder: (context, snapshot, child) {
              return snapshot.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.roleList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio:
                              MediaQuery.of(context).size.width * 0.3 / 80),
                      itemBuilder: (_, index) {
                        return RoleListTile(title: snapshot.roleList[index]);
                      },
                    );
            }),
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightBlack,
        onPressed: () {
          Provider.of<RoleProviderNew>(context, listen: false)
              .setSelctedDropDown(null);
          Navigator.pushNamed(context, roles);
        },
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        color: blackColor,
        child: SizedBox(
          width: double.infinity,
          height: 50,
        ),
      ),
    );
  }
}

class AddUserRole extends StatefulWidget {
  const AddUserRole({Key? key}) : super(key: key);

  @override
  State<AddUserRole> createState() => _AddUserRoleState();
}

class _AddUserRoleState extends State<AddUserRole> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const Text(
            addUserRole,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          spacer(10),
          roleName()
        ],
      ),
    );
  }
}

Widget roleName() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Role Name',
        labelText: 'Role Name',
        labelStyle: TextStyle(fontSize: 18, color: Colors.black),
        fillColor: Colors.white,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    ),
  );
}

class RoleListTile extends StatelessWidget {
  final Roles title;
  const RoleListTile({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Provider.of<RoleProviderNew>(context, listen: false)
              .setSelctedDropDown(title);
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const UserRoles()));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: blackColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title.roleName,
                style: const TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              spacer(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Provider.of<RoleProviderNew>(context, listen: false)
                          .deletBusines(title, context);
                    },
                    child: Container(
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
                  ),
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
      ),
    );
  }
}
