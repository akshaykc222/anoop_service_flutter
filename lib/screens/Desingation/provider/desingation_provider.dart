import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/Desingation/models/designation_model.dart';
import 'package:seed_sales/screens/bussiness/body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class DesignationProvider with ChangeNotifier {
  bool loading = false;
  bool update = false;
  List<DesingationModel> businessList = [];
  List<DesingationModel> tempList = [];

  String token = "";
  DesignationProvider() {
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
    List<DesingationModel> searchList = [];
    for (int i = 0; i < tempList.length; i++) {
      DesingationModel m = tempList[i];
      if (m.designation.contains(s)) {
        searchList.add(m);
      }
    }
    businessList.clear();
    businessList = searchList;
    notifyListeners();
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

    final uri = Uri.parse('https://$baseUrl/api/v1/designation/');
    debugPrint(token);
    final response = await http.get(uri, headers: header);
    debugPrint(response.body);
    if (response.statusCode == HttpStatus.ok) {
      loading = false;
      notifyListeners();
      Map<String, dynamic> data = json.decode(response.body);
      businessList = List<DesingationModel>.from(
          data["designations"].map((x) => DesingationModel.fromJson(x)));
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

  void addBusiness(
    DesingationModel model,
    BuildContext context,
  ) async {
    loading = true;
    notifyListeners();
    var header = {
      "Authorization": "Token $token",
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    var body = model.toJson();
    print(body);
    final uri = Uri.parse('https://$baseUrl/api/v1/designation/');
    print(uri);
    final response =
        await http.post(uri, headers: header, body: jsonEncode(body));
    loading = false;
    notifyListeners();
    if (response.statusCode == HttpStatus.created) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('Added'),
              content: const Text('designation added successfully'),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () {
                    getBusinessList(context);
                    Navigator.pop(context);
                    // Navigator.pop(context);
                  },
                  child: const Text('Ok'),
                ),
              ],
            );
          });
    } else if (response.statusCode == HttpStatus.badRequest) {
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

  void deletBusines(DesingationModel model, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Delete'),
            content: const Text('This will delete this designation'),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () async {
                  loading = true;
                  notifyListeners();
                  if (token == "") {
                    await getToken();
                  }
                  businessList.clear();
                  debugPrint(
                      "======================================================");
                  var header = {
                    "Authorization": "Token $token",
                    HttpHeaders.contentTypeHeader: 'application/json'
                  };

                  final uri = Uri.parse('https://$baseUrl/api/v1/designation/');
                  debugPrint(token);
                  final response = await http.delete(uri, headers: header);
                  debugPrint(response.body);
                  getBusinessList(context);
                  //notifyListeners();

                  Navigator.pop(context);
                },
                child: const Text('delete'),
              ),
            ],
          );
        });
  }

  DesingationModel? selectedBusiness;

  void setDropDownValue(DesingationModel? value) {
    selectedBusiness = value;
    notifyListeners();
  }

  List<DesingationModel> selectedBussinessList = [];

  void setSelectedBussiness() {
    if (selectedBussinessList.contains(selectedBusiness)) {
      selectedBussinessList.remove(selectedBusiness);
    }
    selectedBussinessList.add(selectedBusiness!);
    notifyListeners();
  }

  DesingationModel? updateModel;
  void updateNavigate(BuildContext context, DesingationModel model) {
    update = true;
    updateModel = model;
    debugPrint(updateModel!.toJson().toString());
    notifyListeners();
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const Bussiness()));
  }

  void updateBusiness(BuildContext context, DesingationModel model) async {
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
        Uri.parse('https://$baseUrl/api/v1/designation/${updateModel!.id}/');
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
              content: const Text('designation updated successfully'),
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

  void setUnUpdate() {
    update = false;
    updateModel = null;
    notifyListeners();
  }
}
