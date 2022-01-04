import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:seed_sales/constants.dart';
import 'package:seed_sales/screens/user/models/role_models.dart';
import 'package:seed_sales/screens/user/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

class UserProviderNew with ChangeNotifier {
  bool loading = false;
  List<UserModel> userList = [];
  String token = "";
  List<RoleModel?> roleList = [];

  void clearList() {
    roleList.clear();
    notifyListeners();
  }

  void removeFromList(int businessId) {
    roleList.removeWhere((element) => element!.business == businessId);
    notifyListeners();
  }

  void addToRoleList(RoleModel role, BuildContext context) {
    RoleModel? existingItem = roleList.firstWhereOrNull(
      (element) => element!.business == role.business,
    );
    if (existingItem == null) {
      roleList.add(role);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Already exists')));
    }

    print(roleList.length.toString());
    notifyListeners();
  }

  void getBusinessList(BuildContext context) async {
    loading = true;
    notifyListeners();
    if (token == "") {
      await getToken();
    }
    userList.clear();
    debugPrint("======================================================");
    var header = {
      "Authorization": "Token $token",
      HttpHeaders.contentTypeHeader: 'application/json'
    };

    final uri = Uri.parse('https://$baseUrl/api/v1/users/');
    debugPrint(token);
    final response = await http.get(uri, headers: header);
    debugPrint(response.body);
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> data = json.decode(response.body);
      userList =
          List<UserModel>.from(data["users"].map((x) => UserModel.fromJson(x)));
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
  }

  Future<void> getToken() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    token = _prefs.getString("token")!;
  }

  void addUser(UserModel model, BuildContext context) async {
    var header = {
      "Authorization": "Token $token",
      "Access-Control-Allow-Origin": "*",
      HttpHeaders.contentTypeHeader: 'application/json'
    };
    var body = model.toJson();
    print(body);
    final uri = Uri.parse('https://$baseUrl/api/v1/rest-auth/registration/');
    print(uri);
    final response =
        await http.post(uri, headers: header, body: jsonEncode(body));
    log(response.body);
    if (response.statusCode == HttpStatus.created) {
      Map<String, dynamic> re = json.decode(response.body);
      log(re['key']);

      String ket = re['key'];
      var header = {
        "Authorization": "Token $ket",
        "Access-Control-Allow-Origin": "*",
        HttpHeaders.contentTypeHeader: 'application/json'
      };
      var body = {"role": 1, "business": 1, "user": 1};
      print(body);
      final uri = Uri.parse('https://$baseUrl/api/v1/user_roles/');
      print(uri);
      final res = await http.post(uri, headers: header, body: jsonEncode(body));
      log(res.body);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: const Text('added'),
              content: const Text('user added'),
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
      Map<String, dynamic> data = json.decode(response.body);
      try {
        log(data['error']);
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
        log(e.toString());
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

  void deletBusines(UserModel model, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Delete'),
            content: const Text('This will delete this business'),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('delete'),
              ),
            ],
          );
        });
  }
}
