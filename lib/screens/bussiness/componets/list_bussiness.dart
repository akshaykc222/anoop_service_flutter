import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/screens/bussiness/body.dart';
import 'package:seed_sales/screens/bussiness/models/bussinessmode.dart';
import 'package:seed_sales/screens/bussiness/provider/business_provider.dart';
import 'package:seed_sales/screens/user/body.dart';

import '../../../componets.dart';
import '../../../constants.dart';

class BussinessList extends StatefulWidget {
  const BussinessList({Key? key}) : super(key: key);

  @override
  State<BussinessList> createState() => _BussinessListState();
}

class _BussinessListState extends State<BussinessList> {
  final List<String> _bussinessList = [];
  @override
  void initState() {
    print("==============================================reloading===========================");
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<BusinessProvider>(context, listen: false)
          .getBusinessList(context);
      Provider.of<BusinessProvider>(context, listen: false)
          .setUnUpdate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 80),
        child: Container(
          height: 80,
          color: blackColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: lightBlack, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      if (value.isEmpty) {
                        Provider.of<BusinessProvider>(context, listen: false)
                            .retainList();
                        print("fdvfdvfdvv");
                      }
                      Provider.of<BusinessProvider>(context, listen: false)
                          .searchBusiness(value);
                    },
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                        hintText: "search",
                        // labelText: "Search",
                        labelStyle: TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        fillColor: lightBlack,
                        filled: true),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        color: lightBlack,
        child: Consumer<BusinessProvider>(builder: (context, snapshot, child) {
          return snapshot.loading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: whiteColor,
                  ),
                )
              : snapshot.businessList.isEmpty
                  ? const Center(
                      child: Text(
                        'No Business found',
                        style: TextStyle(color: whiteColor),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.businessList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          childAspectRatio:
                              MediaQuery.of(context).size.width * 0.3 / 90),
                      itemBuilder: (_, index) {
                        return UserListTile(
                            model: snapshot.businessList[index]);
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
          Provider.of<BusinessProvider>(context, listen: false)
              .setUnUpdate();
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Bussiness()));
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class UserListTile extends StatelessWidget {
  final BusinessModel model;
  const UserListTile({Key? key, required this.model}) : super(key: key);

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
                model.name,
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
                    Provider.of<BusinessProvider>(context, listen: false)
                        .deletBusines(model, context);
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
                InkWell(
                  onTap: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (_)=>Create))
                    Provider.of<BusinessProvider>(context, listen: false)
                        .updateNavigate(context, model);
                  },
                  child: Container(
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
