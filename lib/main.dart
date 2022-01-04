import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/router.dart';
import 'package:seed_sales/screens/Desingation/provider/desingation_provider.dart';
import 'package:seed_sales/screens/categories/provider/category_provider.dart';
import 'package:seed_sales/screens/customers/provider/customer_provider.dart';
import 'package:seed_sales/screens/dashbord/body.dart';
import 'package:seed_sales/screens/dashbord/provider/assigned_business_provider.dart';
import 'package:seed_sales/screens/dashbord/provider/dashboard_provider.dart';
import 'package:seed_sales/screens/enquiry/provider/appointment_provider.dart';
import 'package:seed_sales/screens/login/body.dart';
import 'package:seed_sales/screens/login/provider/login_provider.dart';
import 'package:seed_sales/screens/products/provider/products_provider.dart';
import 'package:seed_sales/screens/roles/provider/role_provider.dart';
import 'package:seed_sales/screens/subcategory/provider/sub_category_provider.dart';
import 'package:seed_sales/screens/user/provider/users_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/bussiness/provider/business_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final String token;
  Future<bool> initShared() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('token')!;
    return true;
  }

  @override
  void initState() {
    // Future.delayed(const Duration(milliseconds: 500), () async {
    //   await initShared();
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashBoardProvider()),
        ChangeNotifierProvider(create: (_) => DesignationProvider()),
        ChangeNotifierProvider(create: (_) => RoleProviderNew()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => BusinessProvider()),
        ChangeNotifierProvider(create: (_) => UserProviderNew()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => SubCategoryProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CustomerProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => AssignedBussinessProvider())
      ],
      child: MaterialApp(
        color: blackColor,
        title: 'Body Perfect',
        theme: ThemeData(
            primaryColor: blackColor, scaffoldBackgroundColor: lightBlack),
        onGenerateRoute: RouterPage.generateRoute,
        home: SplashFuturePage(),
      ),
    );
  }
}
class SplashFuturePage extends StatefulWidget {
  const SplashFuturePage({Key? key}) : super(key: key);

  @override
  _SplashFuturePageState createState() => _SplashFuturePageState();
}

class _SplashFuturePageState extends State<SplashFuturePage> {
  String? token;
  Future<bool> initShared() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('token');
    return true;
  }
  Future<Widget> futureCall() async {
    await initShared();
    await Future.delayed(const Duration(milliseconds: 3000));
    return token!=null? Future.value(const DashBoard()):Future.value(const Login());
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/icons/logo.png'),
      title: const Text(
        "Body Perfect",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: const Text("Loading..."),
      futureNavigator: futureCall(),
    );
  }
}
