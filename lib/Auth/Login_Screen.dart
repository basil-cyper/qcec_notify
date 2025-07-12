import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:qcec_notify/Core/Utils.dart';
import 'package:qcec_notify/Core/Widgets.dart';
import 'package:qcec_notify/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
        backgroundColor: Color(0xFFF8F9FD),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 30),
                Container(
                  child: Text(
                    "أهلا بك من جديد",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text(
                    "سعداء بعودتك",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "رقم الهاتف",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    InputWidget(
                      ikeyboardType: TextInputType.phone,
                      icontroller: emailController,
                      iAlign: TextAlign.right,
                      iHint: "رقم الهاتف",
                      border: BorderSide(color: Colors.black),
                      iprefix: Icon(Iconsax.sms, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "كلمة المرور",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    InputWidget(
                      ikeyboardType: TextInputType.number,
                      icontroller: passController,
                      iAlign: TextAlign.right,
                      iHint: "إكتب كلمة المرور الخاصة بك",
                      border: BorderSide(color: Colors.black),
                      iprefix: Icon(Iconsax.lock, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    SharedPreferences prefx =
                        await SharedPreferences.getInstance();
                    var request = await AppUtils.MakeRequests(
                      "fetch",
                      "SELECT id FROM users WHERE a5 = '${emailController.text.trim()}' AND a6 = '${passController.text.trim()}' ",
                    );
                    if (request[0] != null) {
                      prefx.setString("UID", request[0]['id'].toString());
                      AppUtils.sNavigateToReplace(context, HomeScreen());
                    } else {
                      AppUtils.snackBarShowing(
                        context,
                        "Please Enter The Valid Data",
                      );
                    }
                  },
                  child: ButtonWidget(btnText: "تسجيل الدخول"),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      )
    );
  }
}
