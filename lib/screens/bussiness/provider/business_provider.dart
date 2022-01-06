import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/bussiness/body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import '../models/bussinessmode.dart';

class BusinessProvider with ChangeNotifier {
  bool loading = false;
  bool update = false;
  List<BusinessModel> businessList = [];
  List<BusinessModel> tempList = [];

  String token = "";
  BusinessProvider() {
    if (token == "") {
      getToken();
    }
  }
  void initTemp() {
    if (tempList.isEmpty) {
      tempList = businessList;
      debugPrint(businessList.length.toString());
      notifyListeners();
    }
  }

  void retainList() {
    businessList.clear();
    businessList = tempList;
    debugPrint(businessList.length.toString());
    notifyListeners();
  }

  void searchBusiness(String s) {
    initTemp();
    List<BusinessModel> searchList = [];
    for (int i = 0; i < tempList.length; i++) {
      BusinessModel m = tempList[i];
      if (m.name.contains(s)) {
        searchList.add(m);
      }
    }
    businessList.clear();
    businessList = searchList;
    notifyListeners();
  }

  Future<int?> getBuisness() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("selected_business");
  }

  void getBusinessList(BuildContext context) async {
    loading = true;
    notifyListeners();
    if (token == "") {
      await getToken();
    }
    businessList.clear();
    debugPrint("======================================================");
    var header = {
      "Authorization": "Token $token",
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final uri = Uri.parse('https://$baseUrl/api/v1/business/');
    debugPrint(token);

    // final newURI = uri.replace(queryParameters: params);
    final response = await http.get(uri, headers: header);
    debugPrint(response.body);
    if (response.statusCode == HttpStatus.ok) {
      loading = false;
      notifyListeners();
      Map<String, dynamic> data = json.decode(response.body);
      businessList = List<BusinessModel>.from(
          data["business"].map((x) => BusinessModel.fromJson(x)));
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

  Future<void> getToken() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    token = _prefs.getString("token")!;
  }

  void addBusiness(
      BusinessModel model, BuildContext context, bool update) async {
    loading = true;
    notifyListeners();
    var header = {
      "Authorization": "Token $token",
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    var body = model.toJson();
    print(body);
    final uri = Uri.parse('https://$baseUrl/api/v1/business/');
    print(uri);
    final response =
        await http.post(uri, headers: header, body: jsonEncode(body));

    if (response.statusCode == HttpStatus.created) {
      loading = false;
      notifyListeners();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('Added'),
              content: const Text('Business added successfully'),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    getBusinessList(context);
                    Navigator.pop(context);
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

  void deletBusines(BusinessModel model, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Delete'),
            content: const Text('This will delete this business'),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () async {
                  //action for delete

                  loading = true;
                  notifyListeners();
                  if (token == "") {
                    await getToken();
                  }

                  debugPrint(
                      "======================================================");
                  var header = {
                    "Authorization": "Token $token",
                    HttpHeaders.contentTypeHeader: 'application/json'
                  };

                  final uri =
                      Uri.parse('https://$baseUrl/api/v1/business/${model.id}/');
                  debugPrint(token);
                  final response = await http.delete(uri, headers: header);
                  print(response.body);
                  if(response.statusCode==HttpStatus.internalServerError){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This can not be deleted.contain relation with other data')));
                    Navigator.pop(context);
                  }else{
                    notifyListeners();
                    getBusinessList(context);
                    Navigator.pop(context);
                  }


                  //notifyListeners();


                },
                child: const Text('delete'),
              ),
            ],
          );
        });
  }

  BusinessModel? selectedBusiness;

  void setDropDownValue(BusinessModel? value) {
    selectedBusiness = value;
    notifyListeners();
  }

  List<BusinessModel> selectedBussinessList = [];

  void setSelectedBussiness() {
    if (selectedBussinessList.contains(selectedBusiness)) {
      selectedBussinessList.remove(selectedBusiness);
    }
    selectedBussinessList.add(selectedBusiness!);
    notifyListeners();
  }

  BusinessModel? updateModel;
  void updateNavigate(BuildContext context, BusinessModel model) {
    update = true;
    updateModel = model;
    debugPrint(updateModel!.toJson().toString());
    notifyListeners();
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const Bussiness()));
  }

  void updateBusiness(BuildContext context, BusinessModel model) async {
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
    final uri =
        Uri.parse('https://$baseUrl/api/v1/business/${updateModel!.id}/');
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
              content: const Text('Business updated successfully'),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, business);
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
      String d= jsonEncode(data);
      try {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text('Faild'),
                content: Text(d),
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

  void setUnUpdate() {
    update = false;
    updateModel = null;
    notifyListeners();
  }
}
