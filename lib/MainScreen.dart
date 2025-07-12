import 'package:flutter/material.dart';
import 'package:qcec_notify/Core/Utils.dart';
import 'package:qcec_notify/home_screen.dart';

class MainScreen extends StatefulWidget {
  final String? data;
  const MainScreen({super.key, this.data});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List response = [];

  Future recieveData() async {
    var request = await AppUtils.MakeRequests(
      "fetch",
      "SELECT u.a1 as u1 , c.a1, pd.actionx, pd.notex, pd.datex, pd.sendx, p.a8 FROM projects_det pd JOIN projects p ON pd.con = p.id LEFT JOIN customers c ON p.a1 = c.id LEFT JOIN users u ON p.a2 = u.id WHERE pd.id = '${widget.data}'",
    );
    setState(() {
      response = request;
    });
  }

  final labels = {
    'u1': 'اسم المستخدم',
    'a1': 'العميل',
    'actionx': 'الحالة',
    'notex': 'ملاحظات',
    'datex': 'التاريخ',
    'sendx': 'رقم الإرسال',
    'a8': 'حقل إضافي',
  };

  @override
  void initState() {
    recieveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(response);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: labels.entries.map((entry) {
                  String key = entry.key;
                  String label = entry.value;
                  String value = response.isNotEmpty
                      ? response[0][key]?.toString() ?? ''
                      : '';

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            label,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            value.isNotEmpty ? value : '—',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AppUtils.sNavigateToReplace(context, HomeScreen());
          },
          child: Icon(Icons.chevron_right_rounded),
        ),
      ),
    );
  }
}
