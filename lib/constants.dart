import 'package:flutter/material.dart';

//base url

const baseUrl = "perfect-new.herokuapp.com";

//routes
const String adminPanel = "/";
const String roles = "/roles";
const String userCreation = "/user_creation";
const String business = "/bussiness";
const String services = "/services";
const String category = "/Category";
const String subCategory = "/SubCategory";
const String servicesAdd = "/ServicesAdd";
const String order = "/order";
const String products = "/products";
const String enquiry = "/enquiry";
const String customers = "/customers";
const String designation = "/Designation";
const String reports = "/reports";
const String roleList = "/roleList";
const String taxNav = "/tax";
const String unitNav = "/unit";
const String regionNav = "/region";
const String loginNav = "/login";

//strings
const String something = "something went wrong";
const String search = "Search";
const String currentuser = "Current User";
const String rolename = "Role Name";
const String save = "Save";
const String addcompany = "Add company";
const String create = "Create";
const String add = "Add";
const String cancel = "Cancel";
const String addUserRole = "Add User Role";
const String appName = "Body Perfect";
const String error = "invalid username or password";
//images

//colors
const primaryColor = Color(0xFF46d246);
const secondrayColor = Color(0xFFf2f2f2);
const boxColor = Color(0xFF7A9D96);
const whiteColor = Colors.white;
const blackColor = Color(0xFF000000);
const lightBlack = Color(0xFF404040);
const black90 = Color(0xFF0d0d0d);
const textColor = whiteColor;
double fontResize(BuildContext context, double size) {
  double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
  return size * unitHeightValue;
}

RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
