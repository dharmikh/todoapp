import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/Screen/utils/dbhelper/dbhelper.dart';
class HomeController extends GetxController
{
  Rx<TextEditingController> txtsearch = TextEditingController().obs;

  Rx<TextEditingController> txtname = TextEditingController().obs;
  Rx<TextEditingController> txtstd = TextEditingController().obs;
  TextEditingController txtadd = TextEditingController();

  RxList<Map> DataList = <Map>[].obs;
  RxList<Map> SearchDataList = <Map>[].obs;

  void  getData()
  async {
    DataList.value = await DBHelper.dbHelper.readData();
  }
}