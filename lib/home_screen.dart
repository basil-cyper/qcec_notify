import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qcec_notify/Auth/Login_Screen.dart';
import 'package:qcec_notify/Core/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List notify = [];
  String sql = "";

  Future setTokenDB() async {
    SharedPreferences prefx = await SharedPreferences.getInstance();
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    await AppUtils.MakeRequests(
      "query",
      "UPDATE users SET a15 = '$fcmToken' WHERE id = '${prefx.getString("UID")}' ",
    );

    if (['100', '2', '3', '44'].contains(prefx.getString("UID"))) {
      sql = "SELECT pd.id as pIdx, pd.sendx, c.a1, p.a4, pd.actionx, pd.notex, pd.datex, p.a2, pd.stt "
            "FROM projects_det AS pd "
            "JOIN projects AS p ON pd.con = p.id "
            "LEFT JOIN customers AS c ON p.a1 = c.id "
            "ORDER BY pd.id DESC "
            "LIMIT 30";
    } else {
      sql = "SELECT pd.id as pIdx, pd.sendx, c.a1, p.a4, pd.actionx, pd.notex, pd.datex, p.a2, pd.stt "
            "FROM projects_det AS pd "
            "JOIN projects AS p ON pd.con = p.id "
            "LEFT JOIN customers AS c ON p.a1 = c.id "
            "WHERE (p.a2 = '${prefx.getString("UID")}' AND pd.sendx != '${prefx.getString("UID")}') "
            "OR pd.stx = '${prefx.getString("UID")}' "
            "ORDER BY pd.id DESC "
            "LIMIT 30";
    }
    
    var request = await AppUtils.MakeRequests(
      "fetch",
      sql,
    );
    setState(() {
      notify = request;
    });
  }

  @override
  void initState() {
    setTokenDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [
            IconButton(
              onPressed: () async {
                SharedPreferences prefx = await SharedPreferences.getInstance();
                prefx.remove("UID");
                setState(() {});
                AppUtils.sNavigateToReplace(context, LoginScreen());
              },
              icon: Icon(Iconsax.logout),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: () => setTokenDB(),
              child: Column(
                children: List.generate(notify.length, (i) {
                  return Visibility(
                    visible: notify[i]['stt'] == '1' ? false : true,
                    child: Stack(
                      children: [
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(top: 15, left: 20, right: 20),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                width: 12,
                                color: Color(0xFFf9c159),
                              ),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Card(
                            color: Colors.grey.shade100,
                            elevation: 0,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.only(
                                topRight: Radius.zero,
                                bottomRight: Radius.zero,
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 15,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      "https://www.qcec.online/erp2025/assets/employees/${notify[i]['sendx']}/images/1.jpg?k=${DateTime.now().millisecondsSinceEpoch}",
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 15,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Text(
                                    "الإسم :  ${notify[i]['a1']}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 15,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Text(
                                    "المشروع :  ${notify[i]['a4']}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 15,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Text(
                                    "الحدث :  ${notify[i]['actionx']}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 15,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: Text(
                                    "الملاحظات :  ${notify[i]['notex']}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 15,
                                    left: 20,
                                    right: 20,
                                    bottom: 15,
                                  ),
                                  child: Text(
                                    "التاريخ :  ${notify[i]['datex']}",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                                Text(notify[i]['stt']),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 13,
                          left: 13,
                          child: GestureDetector(
                            onTap: () {
                              AppUtils.MakeRequests(
                                "query",
                                "UPDATE projects_det SET stt = '1' WHERE id = '${notify[i]['pIdx']}'",
                              );
                              setState(() {
                                setTokenDB();
                              });
                            },
                            child: Icon(
                              Iconsax.close_circle,
                              size: 30,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
