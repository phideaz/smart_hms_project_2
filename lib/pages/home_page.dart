import 'package:flutter/material.dart';
import 'package:flutter_wordpress_api/pages/form_drainase_page.dart';
import 'package:flutter_wordpress_api/pages/form_jalan_page.dart';
import 'package:flutter_wordpress_api/pages/form_rumah_page.dart';
import 'package:flutter_wordpress_api/services/shared_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart HMS"),
        elevation: 0,
        actions: [
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
        ]
      ),
      backgroundColor: Colors.grey[200],
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> FormRumahPage()));
                    },
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          SizedBox(height: 8,),
                          Text(
                            "Rumah"
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> FormJalanPage()));
                    },
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          SizedBox(height: 8,),
                          Text(
                              "Jalan"
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> FormDrainasePage()));
                    },
                    child: Container(
                      width: 100,
                      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          SizedBox(height: 8,),
                          Text(
                              "Drainase"
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      )
    );
  }
}