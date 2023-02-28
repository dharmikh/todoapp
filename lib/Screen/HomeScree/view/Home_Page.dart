import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:todoapp/Screen/HomeScree/Controller/Home_controller.dart';
import 'package:todoapp/utils/DBhelper/dbHelper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    homeController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                width: 500,
                height: 50,
                margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black)),
                child: Row(
                  children: [
                    Builder(
                      builder: (context) {
                        return IconButton(
                          onPressed: () {
                            scaffoldKey.currentState!.openDrawer();
                          },
                          tooltip: MaterialLocalizations.of(context)
                              .openAppDrawerTooltip,
                          icon: Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                        );
                      },
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (value) async {
                          homeController.txtsearch.value =
                              TextEditingController(text: "$value");
                          homeController.SearchDataList.value =
                              await DBHelper.dbHelper.readDataname(value);
                        },
                        controller: homeController.txtsearch.value,
                        decoration: InputDecoration(
                            hintText: "Search your notes",
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => homeController.txtsearch.value.text.isEmpty
                  ? SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: homeController.DataList.length,
                        (context, index) {
                          return FocusedMenuHolder(child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.all(6),
                            child: Column(
                              children: [
                                Text(
                                  "${homeController.DataList[index]['name']}",
                                  style: TextStyle(fontSize: 25),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                      EdgeInsets.only(left: 10, top: 15),
                                      child: Text(
                                        "${homeController.DataList[index]['std']}",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ), onPressed: (){}, menuItems: [
                            // FocusedMenuItem(
                            // )
                          ]);
                        },
                      ),
                    )
                  : SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: homeController.SearchDataList.length,
                        (context, index) {
                          return Container(
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.all(6),
                            child: Column(
                              children: [
                                Text(
                                  "${homeController.SearchDataList[index]['name']}",
                                  style: TextStyle(fontSize: 25),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 15),
                                      child: Text(
                                        "${homeController.SearchDataList[index]['std']}",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: InkWell(
          onTap: () {
            homeController.txtname.value.clear();
            homeController.txtstd.value.clear();
            Get.toNamed('list');
          },
          child: Container(
            height: 50,
            width: 50,
            child: Icon(
              Icons.add,
              size: 40,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                  Colors.white,
                  Colors.white,
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
