import 'dart:convert';

import 'package:api_project/MVVM/model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Apimodel {
  var url = "https://crud-backend-6t6r.onrender.com/api";
  var posturl = "https://crud-backend-6t6r.onrender.com/api/post";

  Future<List<Model>?> getservices() async {
    var resp = await http.get(Uri.parse('$url/get'));
    if (resp.statusCode == 200) {
      var apidatas = await json.decode(resp.body);

      print(apidatas);
      return List<Model>.from(apidatas.map((a) => Model.fromJson(a)));
    } else {
      return null;
    }
  }

  Future<Model?> postservices(
      String title, String description, BuildContext context) async {
    var url = Uri.parse("https://crud-backend-6t6r.onrender.com/api/post");

    var resp = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'title': title,
        'description': description,
      }),
    );

    print('Response status: ${resp.statusCode}');
    print('Response body: ${resp.body}');

    try {
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        var apidatas = json.decode(resp.body);

        return Model.fromJson(apidatas);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to create')));
        return null;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to create: $e')));
      print('Failed to create: $e');
      return null;
    }
  }

  Future<Model?> updateservices(String titile, String description, String id,
      BuildContext context) async {
    var resp = await http.put(Uri.parse('$url/update/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'title': titile,
          'description': description,
        }));
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      var apidatas = await json.decode(resp.body);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Updated Successfully')));
      print(apidatas);
      return Model.fromJson(apidatas);
    } else {
      return null;
    }
  }

  Future<Model?> deleteData(String id) async {
    var resp = await http.delete(Uri.parse('$url/delete/$id'));
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      var apidatas = json.decode(resp.body);

      return Model.fromJson(apidatas);
    }
    return null;
  }
}
