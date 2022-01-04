import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seed_sales/screens/categories/models/categories_model.dart';
import 'package:seed_sales/screens/customers/models/country_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';

class CustomerProvider with ChangeNotifier {
  bool loading = false;
  bool update = false;
  List<CustomerModel> customerList = [];
  List<CustomerModel> tempList = [];

  String token = "";
  CustomerProvider() {
    if (token == "") {
      getToken();
    }
  }

  void initTemp() {
    if (tempList.isEmpty) {
      tempList = customerList;
      debugPrint(customerList.length.toString());
      notifyListeners();
    }
  }

  void retainList() {
    customerList.clear();
    customerList = tempList;
    debugPrint(customerList.length.toString());
    notifyListeners();
  }

  void searchBusiness(String s) {
    initTemp();
    List<CustomerModel> searchList = [];
    for (int i = 0; i < tempList.length; i++) {
      CustomerModel m = tempList[i];
      if (m.name!.contains(s)) {
        searchList.add(m);
      }
    }
    customerList.clear();
    customerList = searchList;
    notifyListeners();
  }
  Future<CustomerModel?> getCategoryListWithId(BuildContext context,int id) async {
    loading = true;
    notifyListeners();
    if (token == "") {
      await getToken();
    }
    customerList.clear();
    debugPrint("======================================================");
    var header = {
      "Authorization": "Token $token",
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final uri = Uri.parse('https://$baseUrl/api/v1/customers/$id/');
    debugPrint(token);
    final response = await http.get(uri, headers: header);
    debugPrint(response.body);
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> data = json.decode(response.body);
      CustomerModel cus=CustomerModel.fromJson(data);
      loading = false;

      notifyListeners();
      return cus;
    }
      return null;
    }

    //notifyListeners();

  void getCategoryList(BuildContext context) async {
    loading = true;
    notifyListeners();
    if (token == "") {
      await getToken();
    }
    customerList.clear();
    debugPrint("======================================================");
    var header = {
      "Authorization": "Token $token",
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final uri = Uri.parse('https://$baseUrl/api/v1/customers/');
    debugPrint(token);
    final response = await http.get(uri, headers: header);
    debugPrint(response.body);
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> data = json.decode(response.body);
      customerList = List<CustomerModel>.from(
          data["customers"].map((x) => CustomerModel.fromJson(x)));
      loading = false;

      notifyListeners();
    } else if (response.statusCode == HttpStatus.badRequest) {
      loading = false;
      notifyListeners();
      Map<String, dynamic> data = json.decode(response.body);
      try {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text('Failed'),
                content: Text(data.toString()),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            });
      } catch (e) {
        loading = false;
        notifyListeners();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text('Failed'),
                content: const Text(something),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            });
      }
    }
    loading = false;
    notifyListeners();
    //notifyListeners();
  }

  Future<void> getToken() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    token = _prefs.getString("token")!;
  }

  void addCategory(CustomerModel model, BuildContext context) async {
    loading = true;
    notifyListeners();
    if (token == "") {
      await getToken();
    }
    var header = {
      "Authorization": "Token $token",
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    var body = model.toJson();
    print(body);
    final uri = Uri.parse('https://$baseUrl/api/v1/customers/');
    print(uri);
    final response =
        await http.post(uri, headers: header, body: jsonEncode(body));
    print(response.body);
    if (response.statusCode == HttpStatus.created) {
      loading = false;
      notifyListeners();
      Navigator.pop(context);
      getCategoryList(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('Added'),
              content: const Text('customer added successfully'),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          });
    } else if (response.statusCode == HttpStatus.badRequest) {
      loading = false;
      notifyListeners();
      Map<String, dynamic> data = json.decode(response.body);
      try {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text('Failed'),
                content: Text(data.toString()),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            });
      } catch (e) {
        loading = false;
        notifyListeners();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text('Failed'),
                content: const Text(something),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            });
      }
    }
  }

  void deleteCategory(CustomerModel model, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Delete'),
            content: const Text('This will delete this customer'),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () async {
                  //action for delete
                  var header = {
                    "Authorization": "Token $token",
                    HttpHeaders.contentTypeHeader: 'application/json'
                  };
                  var body = model.toJson();
                  final uri = Uri.parse(
                      'https://$baseUrl/api/v1/customers/${model.id}/');
                  print(uri);
                  final response = await http.delete(uri,
                      headers: header, body: jsonEncode(body));
                  customerList.remove(model);
                  notifyListeners();
                  Navigator.pop(context);
                },
                child: const Text('delete'),
              ),
            ],
          );
        });
  }

  CustomerModel? selectedCategory;
  emptyDropdown() {
    selectedCategory = null;
  }

  bool setDropDownValue(CustomerModel value) {
    selectedCategory = value;
    notifyListeners();

    return true;
  }

  // List<BusinessModel> selectedBussinessList = [];

  // void setSelectedBussiness() {
  //   if (selectedBussinessList.contains(selectedBusiness)) {
  //     selectedBussinessList.remove(selectedBusiness);
  //   }
  //   selectedBussinessList.add(selectedBusiness!);
  //   notifyListeners();
  // }

  CustomerModel? updateModel;
  void updateNavigate(BuildContext context, CustomerModel model) {
    update = true;
    updateModel = model;
    debugPrint(updateModel!.toJson().toString());
    notifyListeners();
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (_) => const Bussiness()));
  }

  void updateCategory(BuildContext context, CustomerModel model) async {
    loading = true;
    notifyListeners();
    if (token == "") {
      await getToken();
    }
    var header = {
      "Authorization": "Token $token",
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    var body = model.toJson();
    print(body);
    final uri = Uri.parse('https://$baseUrl/api/v1/customers/${model.id}/');
    print(uri);
    final response =
        await http.put(uri, headers: header, body: jsonEncode(body));

    if (response.statusCode == HttpStatus.ok) {
      loading = false;
      notifyListeners();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('Updated'),
              content: const Text('Category updated successfully'),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                    loading = false;
                    notifyListeners();
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          });
    } else if (response.statusCode == HttpStatus.badRequest) {
      loading = false;
      notifyListeners();
      Map<String, dynamic> data = json.decode(response.body);
      try {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text('Failed'),
                content: Text(data['error']),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigator.pushReplacementNamed(context, business);
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            });
      } catch (e) {
        loading = false;
        notifyListeners();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text('Failed'),
                content: const Text(something),
                actions: <Widget>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            });
      }
    }
  }
}
