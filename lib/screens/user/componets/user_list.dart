import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/dashbord/body.dart';
import 'package:seed_sales/screens/user/body.dart';
import 'package:seed_sales/screens/user/models/user_model.dart';
import 'package:seed_sales/screens/user/provider/users_provider.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<UserProviderNew>(context, listen: false)
          .getBusinessList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: appBar("Users", [], context),
        resizeToAvoidBottomInset: false,
        body: Container(
          color: lightBlack,
          child: Consumer<UserProviderNew>(builder: (context, snapshot, child) {
            return snapshot.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.userList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio:
                            MediaQuery.of(context).size.width * 0.3 / 90),
                    itemBuilder: (_, index) {
                      return UserListTile(title: snapshot.userList[index]);
                    });
          }),
        ),
        bottomNavigationBar: const BottomAppBar(
          color: blackColor,
          child: SizedBox(
            width: double.infinity,
            height: 50,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: lightBlack,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const UserCreation()));
          },
          child: const Center(
            child: Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class UserListTile extends StatelessWidget {
  final UserModel title;
  const UserListTile({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: blackColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title.email!,
                style: const TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            spacer(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: const Text('Delete'),
                            content: const Text(
                                'Are you sure.This will delete the user'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                onPressed: () {
                                  Provider.of<UserProviderNew>(context,
                                          listen: false)
                                      .deletBusines(title, context);
                                },
                                child: const Text('Ok'),
                              ),
                            ],
                          );
                        });
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
    );
  }
}
