import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_wordpress_api/model/survey_drainase_model.dart';
import 'package:flutter_wordpress_api/model/survey_jalan_model.dart';
import 'package:flutter_wordpress_api/model/survey_rumah_model.dart';
import 'package:flutter_wordpress_api/pages/form_drainase_page.dart';
import 'package:flutter_wordpress_api/pages/form_jalan_page.dart';
import 'package:flutter_wordpress_api/pages/form_rumah_page.dart';
import 'package:flutter_wordpress_api/services/api_service.dart';
import 'package:flutter_wordpress_api/services/shared_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Smart HMS"), elevation: 0, actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () {
              SharedService.logout(context);
            },
          ),
          SizedBox(
            width: 10,
          )
        ]),
        backgroundColor: Colors.grey[200],
        body: ListView(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormRumahPage()));
                      },
                      child: Container(
                        width: 100,
                        margin:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Rumah")
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormJalanPage()));
                      },
                      child: Container(
                        width: 100,
                        margin:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Jalan")
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormDrainasePage()));
                      },
                      child: Container(
                        width: 100,
                        margin:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Drainase")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(onPressed: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          elevation: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 22),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      "Mohon Tunggu ...",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      });
                  sync(context);
                }, child: Text("Sync"))
              ],
            )
          ],
        ));
  }

  void sync(BuildContext context) async{
    checkDataLocal();
    // var res = await APIServices().syncAPI('rumah/sync');
    // var body = json.decode(res.body);
    // print("BODY SYNC : $body");
    // if (body['success']) {
    //   Navigator.pop(context);
    //   if (body['message'] != null) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text(body['message']),
    //     ));
    //   }
    // }else {
    //   Navigator.pop(context);
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text(body['message']),
    //   ));
    // }
  }

  void checkDataLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Fetch and decode data
    // prefs.remove('rumah_survey');

    final String drainasesString = prefs.getString('drainase_survey');
    if (drainasesString != null) {
      debugPrint("DATA LOCAL : $drainasesString", wrapWidth: 1024);
      final List<Drainase> drainase = Drainase.decode(drainasesString);
      //TODO aktifkan ketika data db udah ada
      sendDataToDBDrainase(drainase);
    }
    final String jalansString = prefs.getString('jalan_survey');
    if (jalansString != null) {
      debugPrint("DATA LOCAL : $jalansString", wrapWidth: 1024);
      final List<Jalan> jalan = Jalan.decode(jalansString);
      //TODO aktifkan ketika data db udah ada
      sendDataToDBJalan(jalan);
    }
    final String rumahsString = prefs.getString('rumah_survey');
    if(rumahsString != null){
      debugPrint("DATA LOCAL : $rumahsString", wrapWidth: 1024);
      final List<Rumah> rumah = Rumah.decode(rumahsString);
      //TODO aktifkan ketika data db udah ada
      sendDataToDBRumah(rumah);
    }
    if(drainasesString == null && jalansString == null && rumahsString == null){
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Tidak ada data untuk sinkronasi"),
      ));
    }

  }

  void sendDataToDBDrainase(List<Drainase> drainases) async {

    for (int i = 0; i < drainases.length; i++) {
      //TODO kirim data lewat API
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('drainase_survey');
  }

  void sendDataToDBJalan(List<Jalan> jalans) async {
    for (int i = 0; i < jalans.length; i++) {
      //TODO kirim data lewat API
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jalan_survey');

  }

  void sendDataToDBRumah(List<Rumah> rumahs) async{
    for(int i = 0; i<rumahs.length; i++){
      //TODO kirim data lewat API
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('rumah_survey');

  }
}
