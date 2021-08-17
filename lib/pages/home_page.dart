import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_wordpress_api/model/login_model.dart';
import 'package:flutter_wordpress_api/model/survey_drainase_model.dart';
import 'package:flutter_wordpress_api/model/survey_jalan_model.dart';
import 'package:flutter_wordpress_api/model/survey_rumah_model.dart';
import 'package:flutter_wordpress_api/pages/form_drainase_page.dart';
import 'package:flutter_wordpress_api/pages/form_jalan_page.dart';
import 'package:flutter_wordpress_api/pages/form_rumah_page.dart';
import 'package:flutter_wordpress_api/services/api_service.dart';
import 'package:flutter_wordpress_api/services/shared_service.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userId;
  void checkUserId() async{
    final prefs = await SharedPreferences.getInstance();
    LoginResponseModel loginResponseModel = prefs.getString("login_details") != null ? LoginResponseModel.fromJson(jsonDecode(prefs.getString("login_details"),),
    ) : null ;
    print("ID USER : ${loginResponseModel.data.id}");
    setState(() {
      userId = loginResponseModel.data.id.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserId();
  }

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
                  checkDataLocal();
                }, child: Text("Sync"))
              ],
            )
          ],
        ));
  }

  void checkDataLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Fetch and decode data
    // prefs.remove('rumah_survey');
    // prefs.remove('drainase_survey');
    // prefs.remove('jalan_survey');

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

  void syncRumah(BuildContext context) async{
    var res = await APIServices().syncAPI('rumah/sync');
    var body = json.decode(res.body);
    print("BODY SYNC : $body");
    if (body['success']) {
      Navigator.pop(context);
      if (body['message'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(body['message']),
        ));
      }
    }else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(body['message']),
      ));
    }
  }

  void sendDataToDBRumah(List<Rumah> rumahs) async{
    List<Rumah> tempRumah = rumahs;
    int jumlahDone = 0;

    Map<String, String> headers = {
      'Accept' : 'application/json',
//      'Authorization' : 'Bearer $token'
    };
    int failed = 0;

    for(int i = 0; i<rumahs.length; i++){
      print("failed : $failed");
      if(failed == 0){
        Uri apiUrl = Uri.parse("${APIServices.layananApiUrl}rumah/sync");
        final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

        //FILE TAMPAK DEPAN
        final mimeTypeDataGambarRumahTampakDepan =
        lookupMimeType(rumahs[i].gambarRumahTampakDepan, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambarRumahTampakDepan = await http.MultipartFile.fromPath(
            'gambar_rumah_tampak_depan', rumahs[i].gambarRumahTampakDepan,
            contentType: MediaType(mimeTypeDataGambarRumahTampakDepan[0], mimeTypeDataGambarRumahTampakDepan[1]));

        //FILE TAMPAK KANAN
        final mimeTypeDataGambarRumahTampakKanan =
        lookupMimeType(rumahs[i].gambarRumahTampakKanan, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambarRumahTampakKanan = await http.MultipartFile.fromPath(
            'gambar_rumah_tampak_kanan', rumahs[i].gambarRumahTampakKanan,
            contentType: MediaType(mimeTypeDataGambarRumahTampakKanan[0], mimeTypeDataGambarRumahTampakKanan[1]));

        //FILE TAMPAK KIRI
        final mimeTypeDataGambarRumahTampakKiri =
        lookupMimeType(rumahs[i].gambarRumahTampakKiri, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambarRumahTampakKiri = await http.MultipartFile.fromPath(
            'gambar_rumah_tampak_kiri', rumahs[i].gambarRumahTampakKiri,
            contentType: MediaType(mimeTypeDataGambarRumahTampakKiri[0], mimeTypeDataGambarRumahTampakKiri[1]));

        //FILE TAMPAK BELAKANG
        final mimeTypeDataGambarRumahTampakBelakang =
        lookupMimeType(rumahs[i].gambarRumahTampakBelakang, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambarRumahTampakBelakang = await http.MultipartFile.fromPath(
            'gambar_rumah_tampak_belakang', rumahs[i].gambarRumahTampakKiri,
            contentType: MediaType(mimeTypeDataGambarRumahTampakBelakang[0], mimeTypeDataGambarRumahTampakBelakang[1]));

        imageUploadRequest.headers.addAll(headers);
        imageUploadRequest.files.add(fileGambarRumahTampakDepan);
        imageUploadRequest.files.add(fileGambarRumahTampakKanan);
        imageUploadRequest.files.add(fileGambarRumahTampakKiri);
        imageUploadRequest.files.add(fileGambarRumahTampakBelakang);
        //GET USER ID
        imageUploadRequest.fields['user_id'] = userId;
        imageUploadRequest.fields['provinsi'] = rumahs[i].provinsi;
        imageUploadRequest.fields['kabupaten__kota'] = rumahs[i].kabupatenKota;
        imageUploadRequest.fields['kecamatan'] = rumahs[i].kecamatan;
        imageUploadRequest.fields['kelurahan__desa'] = rumahs[i].kelurahanDesa;
        imageUploadRequest.fields['rw'] = rumahs[i].rw;
        imageUploadRequest.fields['rt'] = rumahs[i].rt;
        imageUploadRequest.fields['nomor_rumah'] = rumahs[i].nomorRumah;
        imageUploadRequest.fields['jalan'] = rumahs[i].jalan;
        imageUploadRequest.fields['lorong__gang'] = rumahs[i].lorongGang;
        imageUploadRequest.fields['koordinat_x'] = rumahs[i].koordinatX;
        imageUploadRequest.fields['koordinat_y'] = rumahs[i].koordinatY;
        imageUploadRequest.fields['nama_kk_pemilik_rumah'] = rumahs[i].namaKkPemilikRumah;
        imageUploadRequest.fields['pekerjaan'] = rumahs[i].pekerjaan;
        imageUploadRequest.fields['id_ktpkk_kepala_rumah_tangga'] = rumahs[i].idKtpkkKepalaRumahTangga;
        imageUploadRequest.fields['jumlah_kk'] = rumahs[i].jumlahKk;
        imageUploadRequest.fields['jumlah_penghuni_rumah'] = rumahs[i].jumlahPenghuniRumah;
        imageUploadRequest.fields['fungsi_bangunan'] = rumahs[i].fungsiBangunan;
        imageUploadRequest.fields['jumlah_lantai_bangunan'] = rumahs[i].jumlahLantaiBangunan;
        imageUploadRequest.fields['jenis_bangunan'] = rumahs[i].jenisBangunan;
        imageUploadRequest.fields['status_kepemilikan_rumah'] = rumahs[i].statusKepemilikanRumah;
        imageUploadRequest.fields['status_kepemilikan_tanah'] = rumahs[i].statusKepemilikanTanah;
        imageUploadRequest.fields['penghasilan_rupiah'] = rumahs[i].penghasilanRupiah;
        imageUploadRequest.fields['material_atap'] = rumahs[i].materialAtap;
        imageUploadRequest.fields['kondisi_atap'] = rumahs[i].kondisiAtap;
        imageUploadRequest.fields['material_lantai'] = rumahs[i].materialLantai;
        imageUploadRequest.fields['kondisi_lantai'] = rumahs[i].kondisiLantai;
        imageUploadRequest.fields['material_dinding'] = rumahs[i].materialDinding;
        imageUploadRequest.fields['kondisi_material'] = rumahs[i].kondisiMaterial;
        imageUploadRequest.fields['kondisi_rumah'] = rumahs[i].kondisiRumah;
        imageUploadRequest.fields['pondasi'] = rumahs[i].pondasi;
        imageUploadRequest.fields['luas_bangunan_meter'] = rumahs[i].luasBangunanMeter;
        imageUploadRequest.fields['sumber_listrik'] = rumahs[i].sumberListrik;
        imageUploadRequest.fields['sumber_air'] = rumahs[i].sumberAir;
        imageUploadRequest.fields['jarak_sumber_air_ke_pembuangan_meter'] = rumahs[i].jarakSumberAirKePembuanganMeter;
        imageUploadRequest.fields['sanitasi'] = rumahs[i].sanitasi;
        imageUploadRequest.fields['persampahan'] = rumahs[i].persampahan;
        imageUploadRequest.fields['email'] = rumahs[i].email;

        print("DATA LAPORAN : ${imageUploadRequest.fields.toString()}");
        print("URL API: ${apiUrl.toString()}");

        try {
          final streamedResponse = await imageUploadRequest.send();
          final response = await http.Response.fromStream(streamedResponse);
          if (response.statusCode != 200) {
            print(response.statusCode);
            print(response.body);
            return null;
          }
          final Map<String, dynamic> responseData = json.decode(response.body);
          print("response data : $responseData");
          if(responseData['success']){
            tempRumah.removeAt(i);
            jumlahDone = jumlahDone + 1;
          }else{
            failed = 1;
          }
//         return responseData;
        } catch (e) {
          print(e);
          return null;
        }
      }else{

      }


    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(jumlahDone == rumahs.length){
      Navigator.pop(context);
      prefs.remove('rumah_survey');

    }else if(jumlahDone != rumahs.length){
      Navigator.pop(context);
      prefs.remove('rumah_survey');
      String remainingData = Rumah.encode(tempRumah);
      await prefs.setString('rumah_survey', remainingData);
      print("SIMPAN REMAINING DATA LOCAL BERHASIL");
    }



  }
}
