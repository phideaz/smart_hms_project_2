import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress_api/model/login_model.dart';
import 'package:flutter_wordpress_api/model/survey_drainase_model.dart';
import 'package:flutter_wordpress_api/model/survey_jalan_model.dart';
import 'package:flutter_wordpress_api/model/survey_rumah_model.dart';
import 'package:flutter_wordpress_api/model/survey_sanitasi_model.dart';
import 'package:flutter_wordpress_api/pages/form_sanitasi_page.dart';
import 'package:flutter_wordpress_api/pages/form_drainase_page.dart';
import 'package:flutter_wordpress_api/pages/form_jalan_page.dart';
import 'package:flutter_wordpress_api/pages/form_rumah_page.dart';
import 'package:flutter_wordpress_api/services/api_service.dart';
import 'package:flutter_wordpress_api/services/shared_service.dart';
import 'package:flutter_wordpress_api/widget/dialog_loading.dart';
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
                        width: 80,
                        margin:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        padding:
                        EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              color: Colors.deepOrange.withOpacity(0.2),
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
                        width: 80,
                        margin:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        padding:
                        EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              color: Colors.deepOrange.withOpacity(0.2),
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
                        width: 80,
                        margin:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        padding:
                        EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              color: Colors.deepOrange.withOpacity(0.2),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Drainase")
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FormSanitasiPage()));
                      },
                      child: Container(
                        width: 80,
                        margin:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        padding:
                        EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              color: Colors.deepOrange.withOpacity(0.2),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Sanitasi")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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
                        width: 80,
                        margin:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        padding:
                        EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              color: Colors.deepOrange.withOpacity(0.2),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Lampu")
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
                        width: 80,
                        margin:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        padding:
                        EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              color: Colors.deepOrange.withOpacity(0.2),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Air Bersih")
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
                        width: 80,
                        margin:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        padding:
                        EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              color: Colors.deepOrange.withOpacity(0.2),
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
                                builder: (context) => FormSanitasiPage()));
                      },
                      child: Container(
                        width: 80,
                        margin:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        padding:
                        EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                        child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              color: Colors.deepOrange.withOpacity(0.2),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Lainnya")
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
                        return DialogLoading("Check Data");
                      });
                  Future.delayed(const Duration(milliseconds: 500), () {
                    checkDataLocal();

                  });
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
    // prefs.remove('sanitasi_survey');
    // prefs.remove('jalan_survey');

    final String sanitasisString = prefs.getString('sanitasi_survey');
    if (sanitasisString != null) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogLoading("Sync Data Sanitasi");
          });
      debugPrint("DATA LOCAL : $sanitasisString", wrapWidth: 1024);
      final List<Sanitasi> sanitasi = Sanitasi.decode(sanitasisString);
      //TODO aktifkan ketika data db udah ada
      sendDataToDBSanitasi(sanitasi);
    }
    final String drainasesString = prefs.getString('drainase_survey');
    if (drainasesString != null) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogLoading("Sync data drainase");
          });
      debugPrint("DATA LOCAL : $drainasesString", wrapWidth: 1024);
      final List<Drainase> drainase = Drainase.decode(drainasesString);
      //TODO aktifkan ketika data db udah ada
      sendDataToDBDrainase(drainase);
    }
    final String jalansString = prefs.getString('jalan_survey');
    if (jalansString != null) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogLoading("Sync data jalan");
          });
      debugPrint("DATA LOCAL : $jalansString", wrapWidth: 1024);
      final List<Jalan> jalan = Jalan.decode(jalansString);
      //TODO aktifkan ketika data db udah ada
      sendDataToDBJalan(jalan);
    }
    final String rumahsString = prefs.getString('rumah_survey');
    if(rumahsString != null){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogLoading("Sync data rumah");
          });
      debugPrint("DATA LOCAL : $rumahsString", wrapWidth: 1024);
      final List<Rumah> rumah = Rumah.decode(rumahsString);
      //TODO aktifkan ketika data db udah ada
      sendDataToDBRumah(rumah);
    }
    if(drainasesString == null && jalansString == null && rumahsString == null && sanitasisString == null){
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Tidak ada data untuk sinkronasi"),
      ));
    }

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
        imageUploadRequest.fields['user_id'] = userId == null ? '' : userId;
        imageUploadRequest.fields['provinsi'] = rumahs[i].provinsi == null ? '' : rumahs[i].provinsi;
        imageUploadRequest.fields['kabupaten__kota'] = rumahs[i].kabupatenKota == null ? '' : rumahs[i].kabupatenKota;
        imageUploadRequest.fields['kecamatan'] = rumahs[i].kecamatan == null ? '' : rumahs[i].kecamatan;
        imageUploadRequest.fields['kelurahan__desa'] = rumahs[i].kelurahanDesa == null ? '' : rumahs[i].kelurahanDesa;
        imageUploadRequest.fields['rw'] = rumahs[i].rw == null ? '' : rumahs[i].rw;
        imageUploadRequest.fields['rt'] = rumahs[i].rt == null ? '' : rumahs[i].rt;
        imageUploadRequest.fields['nomor_rumah'] = rumahs[i].nomorRumah == null ? '' : rumahs[i].nomorRumah;
        imageUploadRequest.fields['jalan'] = rumahs[i].jalan == null ? '' : rumahs[i].jalan;
        imageUploadRequest.fields['lorong__gang'] = rumahs[i].lorongGang == null ? '' : rumahs[i].lorongGang;
        imageUploadRequest.fields['koordinat_x'] = rumahs[i].koordinatX == null ? '' : rumahs[i].koordinatX;
        imageUploadRequest.fields['koordinat_y'] = rumahs[i].koordinatY == null ? '' : rumahs[i].koordinatY;
        imageUploadRequest.fields['nama_kk_pemilik_rumah'] = rumahs[i].namaKkPemilikRumah == null ? '' : rumahs[i].namaKkPemilikRumah;
        imageUploadRequest.fields['pekerjaan'] = rumahs[i].pekerjaan == null ? '' : rumahs[i].pekerjaan ;
        imageUploadRequest.fields['id_ktpkk_kepala_rumah_tangga'] = rumahs[i].idKtpkkKepalaRumahTangga == null ? '' : rumahs[i].idKtpkkKepalaRumahTangga;
        imageUploadRequest.fields['jumlah_kk'] = rumahs[i].jumlahKk == null ? '' : rumahs[i].jumlahKk;
        imageUploadRequest.fields['jumlah_penghuni_rumah'] = rumahs[i].jumlahPenghuniRumah == null ? '' : rumahs[i].jumlahPenghuniRumah;
        imageUploadRequest.fields['fungsi_bangunan'] = rumahs[i].fungsiBangunan == null ? '' : rumahs[i].fungsiBangunan;
        imageUploadRequest.fields['jumlah_lantai_bangunan'] = rumahs[i].jumlahLantaiBangunan == null ? '' :  rumahs[i].jumlahLantaiBangunan;
        imageUploadRequest.fields['jenis_bangunan'] = rumahs[i].jenisBangunan == null ? '' : rumahs[i].jenisBangunan;
        imageUploadRequest.fields['status_kepemilikan_rumah'] = rumahs[i].statusKepemilikanRumah == null ? '' : rumahs[i].statusKepemilikanRumah;
        imageUploadRequest.fields['status_kepemilikan_tanah'] = rumahs[i].statusKepemilikanTanah == null ? '' : rumahs[i].statusKepemilikanTanah;
        imageUploadRequest.fields['penghasilan_rupiah'] = rumahs[i].penghasilanRupiah == null ? '' : rumahs[i].penghasilanRupiah;
        imageUploadRequest.fields['material_atap'] = rumahs[i].materialAtap == null ? '' : rumahs[i].materialAtap;
        imageUploadRequest.fields['kondisi_atap'] = rumahs[i].kondisiAtap == null ? '' : rumahs[i].kondisiAtap;
        imageUploadRequest.fields['material_lantai'] = rumahs[i].materialLantai == null ? '' : rumahs[i].materialLantai;
        imageUploadRequest.fields['kondisi_lantai'] = rumahs[i].kondisiLantai == null ? '' : rumahs[i].kondisiLantai;
        imageUploadRequest.fields['material_dinding'] = rumahs[i].materialDinding == null ? '' : rumahs[i].materialDinding;
        imageUploadRequest.fields['kondisi_material'] = rumahs[i].kondisiMaterial == null ? '' : rumahs[i].kondisiMaterial;
        imageUploadRequest.fields['kondisi_rumah'] = rumahs[i].kondisiRumah == null ? '' : rumahs[i].kondisiRumah;
        imageUploadRequest.fields['pondasi'] = rumahs[i].pondasi == null ? '' : rumahs[i].pondasi;
        imageUploadRequest.fields['luas_bangunan_meter'] = rumahs[i].luasBangunanMeter == null ? '' : rumahs[i].luasBangunanMeter;
        imageUploadRequest.fields['sumber_listrik'] = rumahs[i].sumberListrik == null ? '' : rumahs[i].sumberListrik;
        imageUploadRequest.fields['sumber_air'] = rumahs[i].sumberAir == null ? '' : rumahs[i].sumberAir;
        imageUploadRequest.fields['jarak_sumber_air_ke_pembuangan_meter'] = rumahs[i].jarakSumberAirKePembuanganMeter == null ? '' : rumahs[i].jarakSumberAirKePembuanganMeter;
        imageUploadRequest.fields['sanitasi'] = rumahs[i].sanitasi == null ? '' : rumahs[i].sanitasi;
        imageUploadRequest.fields['persampahan'] = rumahs[i].persampahan == null ? '' : rumahs[i].persampahan;
        imageUploadRequest.fields['email'] = rumahs[i].email == null ? '' : rumahs[i].email;


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
        //return responseData;
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

  void sendDataToDBDrainase(List<Drainase> drainases) async {

    List<Drainase> tempDrainase = drainases;
    int jumlahDone = 0;

    Map<String, String> headers = {
      'Accept' : 'application/json',
//      'Authorization' : 'Bearer $token'
    };
    int failed = 0;

    for(int i = 0; i<drainases.length; i++){
      print("failed : $failed");
      if(failed == 0){
        Uri apiUrl = Uri.parse("${APIServices.layananApiUrl}drainase/sync");
        final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

        //FILE 1
        final mimeTypeData1 =
        lookupMimeType(drainases[i].fotoDrainase1, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambar1 = await http.MultipartFile.fromPath(
            'foto_drainase_1', drainases[i].fotoDrainase1,
            contentType: MediaType(mimeTypeData1[0], mimeTypeData1[1]));

        //FILE 2
        final mimeTypeData2 =
        lookupMimeType(drainases[i].fotoDrainase2, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambar2 = await http.MultipartFile.fromPath(
            'foto_drainase_2', drainases[i].fotoDrainase2,
            contentType: MediaType(mimeTypeData2[0], mimeTypeData2[1]));

        //FILE 3
        final mimeTypeData3 =
        lookupMimeType(drainases[i].fotoDrainase3, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambar3 = await http.MultipartFile.fromPath(
            'foto_drainase_3', drainases[i].fotoDrainase3,
            contentType: MediaType(mimeTypeData3[0], mimeTypeData3[1]));

        //FILE 4
        final mimeTypeData4 =
        lookupMimeType(drainases[i].fotoDrainase4, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambar4 = await http.MultipartFile.fromPath(
            'foto_drainase_4', drainases[i].fotoDrainase4,
            contentType: MediaType(mimeTypeData4[0], mimeTypeData4[1]));

        imageUploadRequest.headers.addAll(headers);
        imageUploadRequest.files.add(fileGambar1);
        imageUploadRequest.files.add(fileGambar2);
        imageUploadRequest.files.add(fileGambar3);
        imageUploadRequest.files.add(fileGambar4);
        //GET USER ID
        imageUploadRequest.fields['user_id'] = userId == null ? '' : userId;
        imageUploadRequest.fields['provinsi'] = drainases[i].provinsi == null ? '' : drainases[i].provinsi;
        imageUploadRequest.fields['kabupaten__kota'] = drainases[i].kabupatenKota == null ? '' : drainases[i].kabupatenKota;
        imageUploadRequest.fields['kecamatan'] = drainases[i].kecamatan == null ? '' : drainases[i].kecamatan;
        imageUploadRequest.fields['kelurahan__desa'] = drainases[i].kelurahanDesa == null ? '' : drainases[i].kelurahanDesa;
        imageUploadRequest.fields['rw'] = drainases[i].rw == null ? '' : drainases[i].rw;
        imageUploadRequest.fields['rt'] = drainases[i].rt == null ? '' : drainases[i].rt;
        imageUploadRequest.fields['ident'] = drainases[i].ident == null ? '' : drainases[i].ident;
        imageUploadRequest.fields['nama_jalan__lokasi_saluran'] = drainases[i].namaJalanLokasiSaluran == null ? '' : drainases[i].namaJalanLokasiSaluran;
        imageUploadRequest.fields['jenis_saluran'] = drainases[i].jenisSaluran == null ? '' : drainases[i].jenisSaluran;
        imageUploadRequest.fields['jenis_konstruksi'] = drainases[i].jenisKonstruksi == null ? '' : drainases[i].jenisKonstruksi;
        imageUploadRequest.fields['kondisi_konstruksi'] = drainases[i].kondisiKonstruksi == null ? '' : drainases[i].kondisiKonstruksi;
        imageUploadRequest.fields['jenis_saluran_atas'] = drainases[i].jenisSaluranAtas == null ? '' : drainases[i].jenisSaluranAtas;
        imageUploadRequest.fields['kondisi_aliran_drainase'] = drainases[i].kondisiAliranDrainase == null ? '' : drainases[i].kondisiAliranDrainase ;
        imageUploadRequest.fields['panjang'] = drainases[i].panjang == null ? '' : drainases[i].panjang;
        imageUploadRequest.fields['tinggi'] = drainases[i].tinggi == null ? '' : drainases[i].tinggi;
        imageUploadRequest.fields['lebar_bawah'] = drainases[i].lebarBawah == null ? '' : drainases[i].lebarBawah;
        imageUploadRequest.fields['lebar_atas'] = drainases[i].lebarAtas == null ? '' : drainases[i].lebarAtas;
        imageUploadRequest.fields['tebal_bibir_drainase'] = drainases[i].tebalBibirDrainase == null ? '' :  drainases[i].tebalBibirDrainase;
        imageUploadRequest.fields['arah_aliran'] = drainases[i].arahAliran == null ? '' : drainases[i].arahAliran;
        imageUploadRequest.fields['tahun_pembuatan'] = drainases[i].tahunPembuatan == null ? '' : drainases[i].tahunPembuatan;
        imageUploadRequest.fields['yang_membangun'] = drainases[i].yangMembangun == null ? '' : drainases[i].yangMembangun;
        imageUploadRequest.fields['keterangan'] = drainases[i].keterangan == null ? '' : drainases[i].keterangan;


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
            tempDrainase.removeAt(i);
            jumlahDone = jumlahDone + 1;
          }else{
            failed = 1;
          }
          //return responseData;
        } catch (e) {
          print(e);
          return null;
        }
      }else{

      }


    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(jumlahDone == drainases.length){
      Navigator.pop(context);
      prefs.remove('drainase_survey');

    }else if(jumlahDone != drainases.length){
      Navigator.pop(context);
      prefs.remove('drainase_survey');
      String remainingData = Drainase.encode(tempDrainase);
      await prefs.setString('drainase_survey', remainingData);
      print("SIMPAN REMAINING DATA LOCAL BERHASIL");
    }
  }

  void sendDataToDBSanitasi(List<Sanitasi> sanitasis) async {

    List<Sanitasi> tempSanitasi = sanitasis;
    int jumlahDone = 0;

    Map<String, String> headers = {
      'Accept' : 'application/json',
//      'Authorization' : 'Bearer $token'
    };
    int failed = 0;

    for(int i = 0; i<sanitasis.length; i++){
      print("failed : $failed");
      if(failed == 0){
        Uri apiUrl = Uri.parse("${APIServices.layananApiUrl}sanitasi/sync");
        final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

        //FILE 1
        final mimeTypeData1 =
        lookupMimeType(sanitasis[i].fotoSanitasi1, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambar1 = await http.MultipartFile.fromPath(
            'foto_sanitasi_1', sanitasis[i].fotoSanitasi1,
            contentType: MediaType(mimeTypeData1[0], mimeTypeData1[1]));

        //FILE 2
        final mimeTypeData2 =
        lookupMimeType(sanitasis[i].fotoSanitasi2, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambar2 = await http.MultipartFile.fromPath(
            'foto_sanitasi_2', sanitasis[i].fotoSanitasi2,
            contentType: MediaType(mimeTypeData2[0], mimeTypeData2[1]));

        //FILE 3
        final mimeTypeData3 =
        lookupMimeType(sanitasis[i].fotoSanitasi3, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambar3 = await http.MultipartFile.fromPath(
            'foto_sanitasi_3', sanitasis[i].fotoSanitasi3,
            contentType: MediaType(mimeTypeData3[0], mimeTypeData3[1]));

        //FILE 4
        final mimeTypeData4 =
        lookupMimeType(sanitasis[i].fotoSaranaPersampahan1, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambar4 = await http.MultipartFile.fromPath(
            'foto_sarana_persampahan_1', sanitasis[i].fotoSaranaPersampahan1,
            contentType: MediaType(mimeTypeData4[0], mimeTypeData4[1]));

        imageUploadRequest.headers.addAll(headers);
        imageUploadRequest.files.add(fileGambar1);
        imageUploadRequest.files.add(fileGambar2);
        imageUploadRequest.files.add(fileGambar3);
        imageUploadRequest.files.add(fileGambar4);
        //GET USER ID
        imageUploadRequest.fields['user_id'] = userId == null ? '' : userId;
        imageUploadRequest.fields['provinsi'] = sanitasis[i].provinsi == null ? '' : sanitasis[i].provinsi;
        imageUploadRequest.fields['kabupaten__kota'] = sanitasis[i].kabupatenKota == null ? '' : sanitasis[i].kabupatenKota;
        imageUploadRequest.fields['kecamatan'] = sanitasis[i].kecamatan == null ? '' : sanitasis[i].kecamatan;
        imageUploadRequest.fields['kelurahan__desa'] = sanitasis[i].kelurahanDesa == null ? '' : sanitasis[i].kelurahanDesa;
        imageUploadRequest.fields['rw'] = sanitasis[i].rw == null ? '' : sanitasis[i].rw;
        imageUploadRequest.fields['rt'] = sanitasis[i].rt == null ? '' : sanitasis[i].rt;
        imageUploadRequest.fields['jumlah_kamar_mandi__wc'] = sanitasis[i].jumlahKamarMandiWc == null ? '' : sanitasis[i].jumlahKamarMandiWc;
        imageUploadRequest.fields['nama_kk__pemilik_rumah'] = sanitasis[i].namaKkPemilikRumah == null ? '' : sanitasis[i].namaKkPemilikRumah;
        imageUploadRequest.fields['fasilitas_sanitasi'] = sanitasis[i].fasilitasSanitasi == null ? '' : sanitasis[i].fasilitasSanitasi;
        imageUploadRequest.fields['bangunan_atas'] = sanitasis[i].bangunanAtas == null ? '' : sanitasis[i].bangunanAtas;
        imageUploadRequest.fields['bangunan_bawah'] = sanitasis[i].bangunanBawah == null ? '' : sanitasis[i].bangunanBawah;
        imageUploadRequest.fields['pembuangan_air_limbah_rt'] = sanitasis[i].pembuanganAirLimbahRt == null ? '' : sanitasis[i].pembuanganAirLimbahRt;
        imageUploadRequest.fields['pembuangan_sampah_rt'] = sanitasis[i].pembuanganSampahRt == null ? '' : sanitasis[i].pembuanganSampahRt;


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
            tempSanitasi.removeAt(i);
            jumlahDone = jumlahDone + 1;
          }else{
            failed = 1;
          }
          //return responseData;
        } catch (e) {
          print(e);
          return null;
        }
      }else{

      }


    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(jumlahDone == sanitasis.length){
      Navigator.pop(context);
      prefs.remove('sanitasi_survey');

    }else if(jumlahDone != sanitasis.length){
      Navigator.pop(context);
      prefs.remove('sanitasi_survey');
      String remainingData = Sanitasi.encode(tempSanitasi);
      await prefs.setString('sanitasi_survey', remainingData);
      print("SIMPAN REMAINING DATA LOCAL BERHASIL");
    }
  }

  void sendDataToDBJalan(List<Jalan> jalans) async {
    List<Jalan> tempJalan = jalans;
    int jumlahDone = 0;

    Map<String, String> headers = {
      'Accept' : 'application/json',
//      'Authorization' : 'Bearer $token'
    };
    int failed = 0;

    for(int i = 0; i<jalans.length; i++){
      print("failed : $failed");
      if(failed == 0){
        Uri apiUrl = Uri.parse("${APIServices.layananApiUrl}jalan/sync");
        final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

        //FILE 1
        final mimeTypeData1 =
        lookupMimeType(jalans[i].fotoJalan1, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambar1 = await http.MultipartFile.fromPath(
            'foto_jalan_1', jalans[i].fotoJalan1,
            contentType: MediaType(mimeTypeData1[0], mimeTypeData1[1]));

        //FILE 2
        final mimeTypeData2 =
        lookupMimeType(jalans[i].fotoJalan2, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambar2 = await http.MultipartFile.fromPath(
            'foto_jalan_2', jalans[i].fotoJalan2,
            contentType: MediaType(mimeTypeData2[0], mimeTypeData2[1]));

        //FILE 3
        final mimeTypeData3 =
        lookupMimeType(jalans[i].fotoJalan3, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambar3 = await http.MultipartFile.fromPath(
            'foto_jalan_3', jalans[i].fotoJalan3,
            contentType: MediaType(mimeTypeData3[0], mimeTypeData3[1]));

        //FILE 4
        final mimeTypeData4 =
        lookupMimeType(jalans[i].fotoJalan4, headerBytes: [0xFF, 0xD8]).split('/');

        final fileGambar4 = await http.MultipartFile.fromPath(
            'foto_jalan_4', jalans[i].fotoJalan4,
            contentType: MediaType(mimeTypeData4[0], mimeTypeData4[1]));

        imageUploadRequest.headers.addAll(headers);
        imageUploadRequest.files.add(fileGambar1);
        imageUploadRequest.files.add(fileGambar2);
        imageUploadRequest.files.add(fileGambar3);
        imageUploadRequest.files.add(fileGambar4);
        //GET USER ID
        imageUploadRequest.fields['user_id'] = userId == null ? '' : userId;
        imageUploadRequest.fields['provinsi'] = jalans[i].provinsi == null ? '' : jalans[i].provinsi;
        imageUploadRequest.fields['kabupaten__kota'] = jalans[i].kabupatenKota == null ? '' : jalans[i].kabupatenKota;
        imageUploadRequest.fields['kecamatan'] = jalans[i].kecamatan == null ? '' : jalans[i].kecamatan;
        imageUploadRequest.fields['kelurahan__desa'] = jalans[i].kelurahanDesa == null ? '' : jalans[i].kelurahanDesa;
        imageUploadRequest.fields['rw'] = jalans[i].rw == null ? '' : jalans[i].rw;
        imageUploadRequest.fields['rt'] = jalans[i].rt == null ? '' : jalans[i].rt;
        imageUploadRequest.fields['ident'] = jalans[i].ident == null ? '' : jalans[i].ident;
        imageUploadRequest.fields['nama_jalan'] = jalans[i].namaJalan == null ? '' : jalans[i].namaJalan;
        imageUploadRequest.fields['jenis_permukaan'] = jalans[i].jenisPermukaan == null ? '' : jalans[i].jenisPermukaan;
        imageUploadRequest.fields['kondisi'] = jalans[i].kondisi == null ? '' : jalans[i].kondisi;
        imageUploadRequest.fields['memiliki_saluran'] = jalans[i].memilikiSaluran == null ? '' : jalans[i].memilikiSaluran;
        imageUploadRequest.fields['jika_ada_saluran'] = jalans[i].jikaAdaSaluran == null ? '' : jalans[i].jikaAdaSaluran;
        imageUploadRequest.fields['jenis_saluran'] = jalans[i].jenisSaluran == null ? '' : jalans[i].jenisSaluran ;
        imageUploadRequest.fields['kondisi_saluran'] = jalans[i].kondisiSaluran == null ? '' : jalans[i].kondisiSaluran;
        imageUploadRequest.fields['panjang_ruas'] = jalans[i].panjangRuas == null ? '' : jalans[i].panjangRuas;
        imageUploadRequest.fields['lebar_ruas'] = jalans[i].lebarRuas == null ? '' : jalans[i].lebarRuas;
        imageUploadRequest.fields['tebal_jalan'] = jalans[i].tebalJalan == null ? '' : jalans[i].tebalJalan;
        imageUploadRequest.fields['tahun_pembuatan'] = jalans[i].tahunPembuatan == null ? '' : jalans[i].tahunPembuatan;
        imageUploadRequest.fields['yang_membangun'] = jalans[i].yangMembangun == null ? '' : jalans[i].yangMembangun;
        imageUploadRequest.fields['keterangan'] = jalans[i].keterangan == null ? '' : jalans[i].keterangan;


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
            tempJalan.removeAt(i);
            jumlahDone = jumlahDone + 1;
          }else{
            failed = 1;
          }
          //return responseData;
        } catch (e) {
          print(e);
          return null;
        }
      }else{

      }


    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(jumlahDone == jalans.length){
      Navigator.pop(context);
      prefs.remove('jalan_survey');

    }else if(jumlahDone != jalans.length){
      Navigator.pop(context);
      prefs.remove('jalan_survey');
      String remainingData = Jalan.encode(tempJalan);
      await prefs.setString('jalan_survey', remainingData);
      print("SIMPAN REMAINING DATA LOCAL BERHASIL");
    }

  }
}
