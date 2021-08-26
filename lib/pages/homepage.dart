import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool ready = false;
  bool isDark = true;

  int totalCasseslocal = 0000;
  int totalActivelocal = 0000;
  int totalDeathsLocal = 0000;
  int totalRecoverLocal = 0000;
  String ltsupdate = "";
  void getData() {
    Dio()
        .get('https://hpb.health.gov.lk/api/get-current-statistical')
        .then((value) {
      setState(() {
        totalCasseslocal = value.data['data']['local_total_cases'];
        totalActivelocal = value.data['data']['local_active_cases'];
        totalDeathsLocal = value.data['data']['local_deaths'];
        totalRecoverLocal = value.data['data']['local_recovered'];
        ltsupdate = value.data['data']['update_date_time'];
        ready = true;
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: Drawer(),
        appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            elevation: 0,
            actions: [
              IconButton(
                  icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () {
                    Get.changeTheme(
                        isDark ? ThemeData.light() : ThemeData.dark());
                    setState(() {
                      isDark = !isDark;
                    });
                  })
            ],
            title: Text(
              'COVID -19 Situation Report',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )),
        body: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                child: Text('$totalCasseslocal'),
              ),
              // Container(
              //   padding: const EdgeInsets.all(8),
              //   child: Text('$totalCasseslocal'),
              // ),
              // Container(
              //   padding: const EdgeInsets.all(8),
              //   child: Text('$totalCasseslocal'),
              // ),
              // Container(
              //   padding: const EdgeInsets.all(8),
              //   child: Text('$totalCasseslocal'),
              // ),
            ]));
  }
}
