import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/sizeconfig.dart';

PreferredSizeWidget appBar(
    String title, List<Widget> widgetList, BuildContext context) {
  return PreferredSize(
    preferredSize: const Size(double.infinity, 100),
    child: Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 2)
      ]),
      width: double.infinity,
      height: 80,
      child: Container(
        decoration: const BoxDecoration(
          color: blackColor,
        ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ]),
      ),
    ),
  );
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 20,
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        style: const TextStyle(height: 1.0, fontSize: 16),
        decoration: InputDecoration(
            fillColor: secondrayColor,
            filled: true,
            hintText: search,
            hintStyle: const TextStyle(),
            suffixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}

Widget spacer(double size) => SizedBox(
      height: size,
    );
Widget defaultButton(double width, String title) {
  return Container(
    width: width,
    height: 50,
    decoration: BoxDecoration(
        color: blackColor, borderRadius: BorderRadius.circular(15)),
    child: Center(
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

Widget columUserTextFileds(String label, String hint, TextInputType keyboard,
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

Widget columUserTextFiledsBlack(String label, String hint,
    TextInputType keyboard, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter value for $hint";
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

Widget headingText(String txt) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      txt,
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
    ),
  );
}

TextStyle textStyle(double fontSize, FontWeight fontWeight) {
  return TextStyle(
      color: textColor, fontSize: fontSize, fontWeight: fontWeight);
}

PreferredSize appBarWithSearch(
  BuildContext context,
  String screenName,
) {
  SizeConfig().init(context);
  return PreferredSize(
    preferredSize: Size(SizeConfig.screenWidth!, 100),
    child: Container(
      height: 80,
      color: blackColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 15),
            child: Text(
              appName,
              style: TextStyle(
                  color: textColor,
                  fontSize: SizeConfig.blockSizeHorizontal! * 6,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 15),
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
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 15),
            child: SvgPicture.asset(
              'assets/icons/sliders.svg',
              color: textColor,
            ),
          )
        ],
      ),
    ),
  );
}

InputDecoration defaultDecoration(String title, String hint) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade500, width: 1)),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade500, width: 1)),
    fillColor: Colors.grey[200],
    labelText: title,
    hintText: hint,
    labelStyle: const TextStyle(
      color: whiteColor,
      fontSize: 13,
    ),
  );
}
