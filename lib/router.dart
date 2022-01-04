import 'package:flutter/material.dart';
import 'package:seed_sales/screens/categories/body.dart';
import 'package:seed_sales/screens/customers/body.dart';

import 'package:seed_sales/screens/dashbord/body.dart';
import 'package:seed_sales/screens/enquiry/body.dart';
import 'package:seed_sales/screens/login/body.dart';
import 'package:seed_sales/screens/products/componets/product_list.dart';
import 'package:seed_sales/screens/region/body.dart';
import 'package:seed_sales/screens/roles/body.dart';
import 'package:seed_sales/screens/roles/componets/roles_list.dart';
import 'package:seed_sales/screens/services/componets/order.dart';
import 'package:seed_sales/screens/services/componets/services.dart';
import 'package:seed_sales/screens/tax/body.dart';
import 'package:seed_sales/screens/unint/body.dart';
import 'package:seed_sales/screens/user/componets/user_list.dart';

import 'constants.dart';
import 'screens/Desingation/body.dart';

import 'screens/bussiness/componets/list_bussiness.dart';
import 'screens/products/body.dart';

import 'screens/user/body.dart';

class RouterPage {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case adminPanel:
        return MaterialPageRoute(builder: (_) => const DashBoard());
      case roles:
        return MaterialPageRoute(builder: (_) => const UserRoles());
      case roleList:
        return MaterialPageRoute(builder: (_) => const RoleList());
      case userCreation:
        return MaterialPageRoute(builder: (_) => const UserList());
      case "Createuser":
        return MaterialPageRoute(builder: (_) => const UserCreation());
      case business:
        return MaterialPageRoute(builder: (_) => const BussinessList());
      case taxNav:
        return MaterialPageRoute(builder: (_) => const Tax());
      case products:
        return MaterialPageRoute(builder: (_) => const ProductList());
      case unitNav:
        return MaterialPageRoute(builder: (_) => const Unit());
      case regionNav:
        return MaterialPageRoute(builder: (_) => const RegionList());
      // case servicesAdd:
      //   return MaterialPageRoute(builder: (_) => const ServicesAdd());
      case order:
        return MaterialPageRoute(builder: (_) => const OrderProducts());
      case enquiry:
        return MaterialPageRoute(builder: (_) => const Enquiry());
      case customers:
        return MaterialPageRoute(builder: (_) => const CustomerList());
      case designation:
        return MaterialPageRoute(builder: (_) => const Designations());
      case loginNav:
        return MaterialPageRoute(builder: (_) => const Login());
      case category:
        return MaterialPageRoute(builder: (_) => const Categories());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
