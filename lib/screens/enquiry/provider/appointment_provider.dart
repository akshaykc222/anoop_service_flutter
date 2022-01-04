import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/bussiness/body.dart';
import 'package:seed_sales/screens/categories/models/categories_model.dart';
import 'package:seed_sales/screens/enquiry/model/appointmentsmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class AppointmentProvider with ChangeNotifier {
  bool loading = false;
  bool update = false;
  List<AppointMentModel> categoryList = [];
  List<AppointMentModel> tempList = [];

  String token = "";
  AppointmentProvider() {
    if (token == "") {
      getToken();
    }
  }

  void initTemp() {
    if (tempList.isEmpty) {
      tempList = categoryList;
      debugPrint(categoryList.length.toString());
      notifyListeners();
    }
  }

  void retainList() {
    categoryList.clear();
    categoryList = tempList;
    debugPrint(categoryList.length.toString());
    notifyListeners();
  }

  // void searchBusiness(String s) {
  //   initTemp();
  //   List<AppointMentModel> searchList = [];
  //   for (int i = 0; i < tempList.length; i++) {
  //     AppointMentModel m = tempList[i];
  //     if (m.customer.contains(s)) {
  //       searchList.add(m);
  //     }
  //   }
  //   categoryList.clear();
  //   categoryList = searchList;
  //   notifyListeners();
  // }

  void getCategoryList(BuildContext context) async {
    loading = true;
    notifyListeners();
    if (token == "") {
      await getToken();
    }
    categoryList.clear();
    debugPrint("======================================================");
    var header = {
      "Authorization": "Token $token",
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final uri = Uri.parse('https://$baseUrl/api/v1/appointments/');
    debugPrint(token);
    final response = await http.get(uri, headers: header);
    debugPrint(response.body);
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> data = json.decode(response.body);
      categoryList = List<AppointMentModel>.from(
          data["appointments"].map((x) => AppointMentModel.fromJson(x)));
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
                title: const Text('Faild'),
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
                title: const Text('Faild'),
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
    //notifyListeners();
  }

  Future<void> getToken() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    token = _prefs.getString("token")!;
  }

  void addCategory(AppointMentModel model, BuildContext context) async {
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
    final uri = Uri.parse('https://$baseUrl/api/v1/appointments/');
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
              content: const Text('appointments added successfully'),
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
                title: const Text('Faild'),
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
                title: const Text('Faild'),
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

  void deleteCategory(CategoriesModel model, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Delete'),
            content: const Text('This will delete this appointments'),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  //action for delete
                  void getBusinessList(BuildContext context) async {
                    loading = true;
                    notifyListeners();
                    if (token == "") {
                      await getToken();
                    }
                    categoryList.clear();
                    debugPrint(
                        "======================================================");
                    var header = {
                      "Authorization": "Token $token",
                      HttpHeaders.contentTypeHeader: 'application/json'
                    };

                    final uri = Uri.parse(
                        'https://$baseUrl/api/v1/categories/${model.id}/');
                    debugPrint(token);
                    final response = await http.delete(uri, headers: header);
                    debugPrint(response.body);
                    if (response.statusCode == HttpStatus.ok) {
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
                                content: Text(data['error']),
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
                                title: const Text('Faild'),
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
                    //notifyListeners();
                  }

                  categoryList.remove(model);
                  notifyListeners();
                  Navigator.pop(context);
                },
                child: const Text('delete'),
              ),
            ],
          );
        });
  }

  CategoriesModel? selectedCategory;
  emptyDropdown() {
    selectedCategory = null;
  }

  bool setDropDownValue(CategoriesModel value) {
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

  CategoriesModel? updateModel;
  void updateNavigate(BuildContext context, CategoriesModel model) {
    update = true;
    updateModel = model;
    debugPrint(updateModel!.toJson().toString());
    notifyListeners();
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (_) => const Bussiness()));
  }

  void updateCategory(BuildContext context, AppointMentModel model) async {
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
    final uri = Uri.parse('https://$baseUrl/api/v1/appointments/${model.id}/');
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
              content: const Text('status updated successfully'),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                    loading = false;
                    notifyListeners();
                    getCategoryList(context);
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
                title: const Text('Faild'),
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
                title: const Text('Faild'),
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
