import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/screens/bussiness/provider/business_provider.dart';
import 'package:seed_sales/screens/roles/provider/role_provider.dart';
import 'package:seed_sales/screens/user/models/role_models.dart';
import 'package:seed_sales/screens/user/provider/users_provider.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({Key? key}) : super(key: key);

  @override
  _AddCompanyState createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Consumer<UserProviderNew>(builder: (context, snapshot, child) {
        return snapshot.roleList.isEmpty
            ? Container()
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.roleList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemBuilder: (_, index) {
                  return snapshot.roleList.isEmpty
                      ? Container()
                      : AddBussinesChip(bussiness: snapshot.roleList[index]!);
                });
      }),
    );
  }
}

class AddBussinesChip extends StatelessWidget {
  final RoleModel bussiness;
  const AddBussinesChip({Key? key, required this.bussiness}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("taping");
        Provider.of<UserProviderNew>(context, listen: false)
            .removeFromList(bussiness.business);
      },
      child: Chip(
        elevation: 10,
        padding: const EdgeInsets.all(8),
        backgroundColor: Colors.greenAccent[100],
        shadowColor: Colors.black,
        avatar: const Icon(
          Icons.arrow_right_outlined,
          color: Colors.green,
        ), //CircleAvatar
        label: Text(
          bussiness.name!,
          overflow: TextOverflow.clip,
          style: const TextStyle(fontSize: 14),
        ), //Text
      ),
    );
  }
}
