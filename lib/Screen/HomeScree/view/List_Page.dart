import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/Screen/HomeScree/Controller/Home_controller.dart';
import 'package:todoapp/Screen/utils/dbhelper/dbhelper.dart';
class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  HomeController homeController = Get.put(HomeController());
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading:IconButton(onPressed: () {
            Get.back();
          },icon: Icon(Icons.arrow_back,color: Colors.black,),) ,
          actions: [
            Obx(() => homeController.txtstd.value.text.isNotEmpty || homeController.txtname.value.text.isNotEmpty ? InkWell(onTap:(){
               DBHelper.dbHelper.insertData(name: homeController.txtname.value.text, std: homeController.txtstd.value.text, address: homeController.txtstd.value.text);
               homeController.getData();
               Get.back();
            },child: Icon(Icons.check,color: Colors.black,)) : Text(""),),
            SizedBox(width: 15,),
          ],
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding:  EdgeInsets.only(top: 20,left: 25),
          child: Column(
            children: [
              Container(
                height: 50,
                width: 300,
                child: TextField(
                  textInputAction: TextInputAction.next,
                  controller: homeController.txtname.value,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15
                  ),
                  cursorColor: Colors.amber,
                  cursorHeight:25,
                  onChanged: (value) {
                    homeController.txtname.value = TextEditingController(text: value);
                  },
                  decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 30
                      ),
                      border: InputBorder.none
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 300,
                child: TextField(
                  maxLines: 15,
                  controller: homeController.txtstd.value,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15
                  ),
                  cursorColor: Colors.amber,
                  cursorHeight: 25,
                  onChanged: (value) {
                    homeController.txtstd.value = TextEditingController(text: value);
                  },
                  decoration: InputDecoration(
                      hintText: "Note",
                      hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 20
                      ),
                      border: InputBorder.none
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
