import 'package:flutter/material.dart';
import 'package:seed_sales/componets.dart';
import 'package:seed_sales/screens/dashbord/model/menu_model.dart';

import '../../../constants.dart';

class AdminMenu extends StatefulWidget {
  const AdminMenu({Key? key}) : super(key: key);

  @override
  _AdminMenuState createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  final List<MenuModel> menuData = [
    MenuModel(title: "Business", icon: Icons.business_center_outlined),
    MenuModel(title: "Roles", icon: Icons.vpn_key_outlined),
    MenuModel(
      title: "User",
      icon: Icons.person,
    ),
    // MenuModel(title: "Unit", icon: Icons.room_service_outlined),
    // MenuModel(title: "Tax", icon: Icons.room_service_outlined),
    MenuModel(title: "Categories", icon: Icons.room_service_outlined),
    MenuModel(title: "Products", icon: Icons.production_quantity_limits),
    MenuModel(title: "Customers", icon: Icons.person),
    MenuModel(title: "Sales", icon: Icons.vpn_key_outlined),
    MenuModel(title: "Region", icon: Icons.vpn_key_outlined),
    MenuModel(title: "Invoice", icon: Icons.inventory),
    MenuModel(title: "Reports", icon: Icons.vpn_key_outlined),
    MenuModel(title: "Designations", icon: Icons.person),
    MenuModel(title: "Appointments", icon: Icons.contact_page),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: MediaQuery.of(context).size.width * 0.3 / 100),
          itemCount: menuData.length,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return MenuCard(
              icon: menuData[index].icon,
              title: menuData[index].title,
            );
          }),
    );
  }
}

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const MenuCard({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (title) {
          case "Roles":
            Navigator.pushNamed(context, roles);

            break;
          case "User":
            Navigator.pushNamed(context, userCreation);

            break;
          case "Business":
            Navigator.pushNamed(context, business);

            break;

          case "Categories":
            Navigator.pushNamed(context, category);

            break;
          case "Products":
            Navigator.pushNamed(context, products);

            break;
          case "Appointments":
            Navigator.pushNamed(context, enquiry);
            break;
          case "Customers":
            Navigator.pushNamed(context, customers);
            break;

          case "Tax":
            Navigator.pushNamed(context, taxNav);
            break;
          case "Unit":
            Navigator.pushNamed(context, unitNav);
            break;
          case "Designations":
            Navigator.pushNamed(context, designation);
            break;
          case "Region":
            Navigator.pushNamed(context, regionNav);
            break;
          case "Reports":
            Navigator.pushNamed(context, reports);
            break;
          case "Invoice":
            Navigator.pushNamed(context, "invoices");
            break;
          default:
            Navigator.pushNamed(context, "defualt");
            break;
        }
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            color: black90, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: whiteColor,
            ),
            spacer(8),
            Text(
              title,
              style: const TextStyle(
                  color: whiteColor, fontWeight: FontWeight.w600, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
