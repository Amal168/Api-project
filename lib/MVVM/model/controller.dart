import 'package:api_project/MVVM/model/model.dart';
import 'package:api_project/MVVM/view%20model/apimodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  var curdModelData = <Model>[].obs;
  var loadData = false.obs;

  getData() async {
    loadData.value = true; 
    try {
      var curdData = await Apimodel().getservices(); 
      if (curdData != null && curdData.isNotEmpty) {
        curdModelData.value = curdData; 
      } else {
        Get.snackbar("No Data", "No data available at the moment.");
        
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch data: $e");
      print(e);
    } finally {
      loadData.value = false;
    }
  }

  postData(String title, String desc, BuildContext context) async {
    try {
      var curdData = await Apimodel().postservices(title, desc, context);
      if (curdData != null) {
        curdModelData.add(Model(title: title, description: desc));
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
      print(e);
    }
  }

  

updatedata(String id, String title, String des, BuildContext context) async {
    loadData.value = true; 

  try {
    var curddata = await Apimodel().updateservices(title, des, id, context);
    print('API response: $curddata');
    
    if (curddata != null) {
      var modelIndex = curdModelData.indexWhere((model) => model.id == id);
      if (modelIndex != -1) {
      
        curdModelData[modelIndex] = Model(title: title, description: des);
      } else {
        print('Model with id: $id not found');
      }
    }
  } catch (e) {
    print('Error: $e');
  }
}

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  deleteData(String id, BuildContext context) async {
    try {
      var curdData = await Apimodel().deleteData(id);
      if (curdData != null) {
        curdModelData.removeWhere((model) => model.id == id);
      }
    } catch (e) {
      Get.snackbar("Error", "$e");
      print(e);
    }
  }
}
