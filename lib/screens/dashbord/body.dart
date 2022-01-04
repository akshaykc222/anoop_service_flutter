import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:seed_sales/constants.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/dashbord/componets/dashboard_items.dart';
import 'package:seed_sales/screens/dashbord/componets/menus.dart';
import 'package:seed_sales/screens/dashbord/provider/dashboard_provider.dart';
import 'package:seed_sales/sizeconfig.dart';

import '../../constants.dart';



class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  final key1 = UniqueKey();
  final key2 = UniqueKey();
  void _onTap() {
    if (_flag) {
      _controller!.forward();
    } else {
      _controller!.reverse();
    }
    Provider.of<DashBoardProvider>(context, listen: false).setPopupOpen();
    _flag = !_flag;
  }

  bool _flag = true;

  Animation<double>? _myAnimation;
  AnimationController? _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _myAnimation = CurvedAnimation(curve: Curves.linear, parent: _controller!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(SizeConfig.screenWidth!, 100),
        child: Container(
          height: 80,
          color: blackColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children:  [
             Padding(
                padding: const EdgeInsets.only(left: 25,bottom: 15),
                child: Text(appName,style: TextStyle(color: textColor,fontSize: SizeConfig.blockSizeHorizontal!*6,fontWeight: FontWeight.bold),),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 50,
                child: const Padding(
                  padding: EdgeInsets.only(bottom:15),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        hintText: "search",
                        labelText: "Search",
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
      body: Stack(children: [
        Column(
          children: const [DashBoardItems()],
        ),
        Consumer<DashBoardProvider>(builder: (context, provider, child) {
          return Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: AnimatedSwitcher(
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
                reverseDuration: const Duration(milliseconds: 300),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                  ),
                  child: provider.isOpen
                      ? const AdminMenu()
                      : Container(
                          key: key2,
                        ),
                ),
              ));
        })
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: blackColor,
        onPressed: () {
          _onTap();
        },
        child: Center(
            child: AnimatedIcon(
                icon: AnimatedIcons.menu_close, progress: _myAnimation!)),
      ),
      bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          color: black90,
          child: SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[




                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: IconButton(
                      icon: const Icon(
                        Icons.person,
                        color: whiteColor,
                      ),
                      onPressed: () {}),
                ),
                const SizedBox(width: 40), // The dummy child
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: whiteColor,
                      ),
                      onPressed: () {}),
                ),
              ],
            ),
          )),
    );
  }
}
