import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress_api/model/survey_rumah_model.dart';
import 'package:flutter_wordpress_api/utils/form_helper.dart';
import 'package:flutter_wordpress_api/utils/list_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormRumahPage extends StatefulWidget {
  @override
  _FormRumahPageState createState() => _FormRumahPageState();
}

class _FormRumahPageState extends State<FormRumahPage> {
  final _formKey = GlobalKey<FormState>();

  String selectedProvinsi;
  String selectedKabupaten;
  String selectedKecamatan;
  String selectedKelurahan;
  String selectedPekerjaan;
  String selectedFungsiBangunan;
  String selectedJumlahLntaiBangunan;
  String selectedJenisBangunan;
  String selectedStatusKepemilikanRumah;
  String selectedStatusKepemilikanTanah;
  String selectedMaterialAtap;
  String selectedKondisiAtap;
  String selectedMaterialLantai;
  String selectedKondisiLantai;
  String selectedMaterialDinding;
  String selectedKondisiMaterial;
  String selectedKondisiRumah;
  String selectedPondasi;
  String selectedSubmerListrik;
  String selectedSubmerAir;
  String selectedSanitasi;
  String selectedPersampahan;
  TextEditingController rwController = TextEditingController();
  TextEditingController rtController = TextEditingController();
  TextEditingController nomorRumahController = TextEditingController();
  TextEditingController jalanController = TextEditingController();
  TextEditingController lorongController = TextEditingController();
  TextEditingController koordinatXController = TextEditingController();
  TextEditingController koordinatYController = TextEditingController();
  TextEditingController namaKKController = TextEditingController();
  TextEditingController idKTPController = TextEditingController();
  TextEditingController jumlahKKController = TextEditingController();
  TextEditingController jumlahPenghuniController = TextEditingController();
  TextEditingController penghasilanController = TextEditingController();
  TextEditingController luasBangunanController = TextEditingController();
  TextEditingController jarakSumberAirController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  File _imageTampakDepan,
      _imageTampakKanan,
      _imageTampakKiri,
      _imageTampakBelakang;
  final picker = ImagePicker();
  bool isKonek;

  void checkConnection() async {
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    // returns a bool

    // We can also get an enum value instead of a bool
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    // prints either DataConnectionStatus.connected
    // or DataConnectionStatus.disconnected

    // This returns the last results from the last call
    // to either hasConnection or connectionStatus
    print("Last results: ${DataConnectionChecker().lastTryResults}");

    // actively listen for status updates
    // this will cause DataConnectionChecker to check periodically
    // with the interval specified in DataConnectionChecker().checkInterval
    // until listener.cancel() is called
    var listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          isKonek = true;
          checkDataLocal();

          break;
        case DataConnectionStatus.disconnected:
          isKonek = false;
          print('You are disconnected from the internet.');
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
    await Future.delayed(Duration(seconds: 30));
    await listener.cancel();
  }

  Future getImageDepan() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;
    //

    // print("FILE : ${pickedFile.path}");

    setState(() {
      if (pickedFile != null) {
        _imageTampakDepan = File(pickedFile.path);

      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageKanan() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageTampakKanan = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageKiri() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageTampakKiri = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageBelakang() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageTampakBelakang = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnection();
  }

  void checkDataLocal() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Fetch and decode data
    // prefs.remove('rumah_survey');

    final String rumahsString = prefs.getString('rumah_survey');
    if(rumahsString != null){
      debugPrint("DATA LOCAL : $rumahsString", wrapWidth: 1024);
      final List<Rumah> rumah = Rumah.decode(rumahsString);
      //TODO aktifkan ketika data db udah ada
      // sendDataToDB(rumah);
    }
  }

  void sendDataToDB(List<Rumah> rumahs) async{
    for(int i = 0; i<rumahs.length; i++){
      //TODO kirim data lewat API
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('rumah_survey');


  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Survey Rumah"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Pendataan Lapangan Meliputi Bangunan / Rumah yang ada di Provinsi Sumatera Selatan"),
                  //PROVINSI
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Provinsi",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedProvinsi,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedProvinsi = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .provinsi
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //KABUPATEN /KOTA
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Kabupaten / Kota",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedKabupaten,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedKabupaten = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .kabupaten
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Kecamatan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Kecamatan",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedKecamatan,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedKecamatan = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .kecamatan
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Kelurahan / Desa
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Kelurahan",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: SearchableDropdown.single(
                          items: ListHelper()
                              .keluarahan
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                          value: selectedKelurahan,
                          displayClearIcon: false,
                          hint: "Pilih kelurahan",
                          searchHint: "Pilih kelurahan",
                          validator: (value) =>
                          value == null ? 'Diwajibkan memilih' : null,
                          onChanged: (value) {
                            setState(() {
                              selectedKelurahan = value;
                            });
                          },
                          isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                  //RW
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*RW",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        validator: (value) =>
                            value == '' ? 'Diwajibkan diisi' : null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: rwController,
                      ),
                    ],
                  ),
                  //RT
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*RT",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value == '' ? 'Diwajibkan diisi' : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: rtController,
                      ),
                    ],
                  ),
                  //Nomor Rumah
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Nomor Rumah",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value == '' ? 'Diwajibkan diisi' : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: nomorRumahController,
                      ),
                    ],
                  ),
                  //Jalan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Jalan",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value == '' ? 'Diwajibkan diisi' : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: jalanController,
                      ),
                    ],
                  ),
                  //Lorong / Gang
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Lorong / Gang",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value == '' ? 'Diwajibkan diisi' : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: lorongController,
                      ),
                    ],
                  ),
                  //Koordinat X
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Koordinat X",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value == '' ? 'Diwajibkan diisi' : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: koordinatXController,
                      ),
                    ],
                  ),
                  //Koordinat Y
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Koordinat Y",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value == '' ? 'Diwajibkan diisi' : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: koordinatYController,
                      ),
                    ],
                  ),
                  //Nama KK Pemilik Rumah
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Nama KK Pemilik Rumah",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value == '' ? 'Diwajibkan diisi' : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: namaKKController,
                      ),
                    ],
                  ),
                  //Pekerjaan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Pekerjaan",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedPekerjaan,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedPekerjaan = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .pekerjaan
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //ID KTP
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*ID KTP/KK Kepala Rumah Tangga",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.art_track_sharp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: idKTPController,
                      ),
                    ],
                  ),
                  //JUMLAH KK
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Jumlah KK",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value == '' ? 'Diwajibkan diisi' : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.art_track_sharp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: jumlahKKController,
                      ),
                    ],
                  ),
                  //Jumlah Penghuni Rumah
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Jumlah Penghuni Rumah",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value == '' ? 'Diwajibkan diisi' : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.art_track_sharp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: jumlahPenghuniController,
                      ),
                    ],
                  ),
                  //Fungsi Bangunan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Fungsi Bangunan",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedFungsiBangunan,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedFungsiBangunan = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .fungsiBangunan
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Jumlah Lantai Bangunan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Jumlah Lantai Bangunan",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedJumlahLntaiBangunan,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) => setState(
                              () => selectedJumlahLntaiBangunan = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .jumlahLantaiBangunan
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Jenis Bangunan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Jenis Bangunan",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedJenisBangunan,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedJenisBangunan = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .jenisBangunan
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Status Kepemilikan Rumah
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Status Kepemilikan Rumah",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedStatusKepemilikanRumah,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) => setState(
                              () => selectedStatusKepemilikanRumah = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .statusKepemilikanRumah
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Status Kepemilikan Tanah
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Status Kepemilikan Tanah",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedStatusKepemilikanTanah,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) => setState(
                              () => selectedStatusKepemilikanTanah = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .statusKepemilikanRumah
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Penghasilan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Penghasilan",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value == '' ? 'Diwajibkan diisi' : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_box_sharp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: penghasilanController,
                      ),
                    ],
                  ),
                  //Material Atap
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Material Atap",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedMaterialAtap,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedMaterialAtap = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .materialAtap
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Kondisi Atap
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Kondisi Atap",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedKondisiAtap,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedKondisiAtap = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .kondisiAtap
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Material Lantai
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Material Lantai",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedMaterialLantai,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedMaterialLantai = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .materialLantai
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Kondisi Lantai
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Kondisi Lantai",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedKondisiLantai,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedKondisiLantai = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .kondisiLantai
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Material Dinding
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Material Dinding",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedMaterialDinding,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedMaterialDinding = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .materialDinding
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Kondisi Material
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Kondisi Material",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedKondisiMaterial,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedKondisiMaterial = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .kondisiMaterial
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Kondisi Rumah
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Kondisi Rumah",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedKondisiRumah,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedKondisiRumah = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .kondisiRumah
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Pondasi
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Pondasi",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedPondasi,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedPondasi = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .pondasi
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Luas Banungan (meter)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Luas Bangunan (Meter)",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value == '' ? 'Diwajibkan diisi' : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_box_sharp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: luasBangunanController,
                      ),
                    ],
                  ),
                  //Sumber Listrik
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Sumber Listrik",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedSubmerListrik,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedSubmerListrik = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .sumberListrik
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Sumber Air
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Sumber Air",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedSubmerAir,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedSubmerAir = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .sumberAir
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Jarak Sumber Air Ke Pembuangan (meter)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Jarak Sumber Air Ke Pembuangan (meter)",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) =>
                            value == '' ? 'Diwajibkan diisi' : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_box),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: jarakSumberAirController,
                      ),
                    ],
                  ),
                  //Sanitasi
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Sanitasi",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedSanitasi,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedSanitasi = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .sanitasi
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Persampahan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Persampahan",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedPersampahan,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedPersampahan = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .persampahan
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    80 /
                                    100,
                                child: Text(
                                  value,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  //Email
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "Email",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: emailController,
                      ),
                    ],
                  ),
                  //Gambar Depan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Gambar Rumah Tampak Depan",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2), width: 1)),
                        child: Stack(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  getImageDepan();
                                },
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 70,
                                ),
                              ),
                            ),
                            (_imageTampakDepan != null)
                                ? Image.file(
                                    _imageTampakDepan,
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Gambar Kanan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Gambar Rumah Tampak Kanan",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2), width: 1)),
                        child: Stack(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  getImageKanan();
                                },
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 70,
                                ),
                              ),
                            ),
                            (_imageTampakKanan != null)
                                ? Image.file(
                                    _imageTampakKanan,
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Gambar Kiri
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Gambar Rumah Tampak Kiri",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2), width: 1)),
                        child: Stack(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  getImageKiri();
                                },
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 70,
                                ),
                              ),
                            ),
                            (_imageTampakKiri != null)
                                ? Image.file(
                                    _imageTampakKiri,
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //Gambar Belakang
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "Gambar Rumah Tampak Belakang",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.2), width: 1)),
                        child: Stack(
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  getImageBelakang();
                                },
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 70,
                                ),
                              ),
                            ),
                            (_imageTampakBelakang != null)
                                ? Image.file(
                                    _imageTampakBelakang,
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),

                  GestureDetector(
                    onTap: () async {
                      // if (_formKey.currentState.validate()) {


                        
                        //form is valid, proceed further
                        _formKey.currentState
                            .save(); //save once fields are valid, onSaved method invoked for every form fields
                        if(_imageTampakDepan != null || _imageTampakKiri != null || _imageTampakKanan != null){
                          final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          // Fetch and decode data
                          final String rumahsString = prefs.getString('rumah_survey');
                          if(rumahsString != null){
                            final List<Rumah> rumah = Rumah.decode(rumahsString);
                            //TODO aktifkan ketika data db udah ada
                            //sendDataToDB(rumah);
                            Rumah newData = Rumah(
                                provinsi: selectedProvinsi,
                                kabupatenKota: selectedKabupaten,
                                kecamatan: selectedKecamatan,
                                kelurahanDesa: selectedKelurahan,
                                rw: rwController.text,
                                rt: rtController.text,
                                nomorRumah: nomorRumahController.text,
                                jalan: jalanController.text,
                                lorongGang: lorongController.text,
                                koordinatX: koordinatXController.text,
                                koordinatY: koordinatYController.text,
                                namaKkPemilikRumah: namaKKController.text,
                                pekerjaan: selectedPekerjaan,
                                idKtpkkKepalaRumahTangga: idKTPController.text,
                                jumlahKk: jumlahKKController.text,
                                jumlahPenghuniRumah: jumlahPenghuniController.text,
                                fungsiBangunan: selectedFungsiBangunan,
                                jumlahLantaiBangunan: selectedJumlahLntaiBangunan,
                                jenisBangunan: selectedJenisBangunan,
                                statusKepemilikanRumah:
                                selectedStatusKepemilikanRumah,
                                statusKepemilikanTanah:
                                selectedStatusKepemilikanTanah,
                                penghasilanRupiah: penghasilanController.text,
                                materialAtap: selectedMaterialAtap,
                                kondisiAtap: selectedKondisiAtap,
                                materialLantai: selectedMaterialLantai,
                                kondisiLantai: selectedKondisiLantai,
                                materialDinding: selectedMaterialDinding,
                                kondisiMaterial: selectedKondisiMaterial,
                                kondisiRumah: selectedKondisiRumah,
                                pondasi: selectedPondasi,
                                luasBangunanMeter: luasBangunanController.text,
                                sumberListrik: selectedSubmerListrik,
                                sumberAir: selectedSubmerAir,
                                jarakSumberAirKePembuanganMeter: jarakSumberAirController.text,
                                sanitasi: selectedSanitasi,
                                persampahan: selectedPersampahan,
                                email: emailController.text,
                                gambarRumahTampakDepan: _imageTampakDepan.path.toString(),
                                gambarRumahTampakKanan: _imageTampakKanan.path.toString(),
                                gambarRumahTampakKiri: _imageTampakKiri.path.toString(),
                                gambarRumahTampakBelakang: _imageTampakBelakang.path.toString());
                            rumah.add(newData);
                            String oldData = Rumah.encode(rumah);

                            await prefs.setString('rumah_survey', oldData);
                            print("SIMPAN DATA LOCAL BERHASIL");
                            FormHelper.showMessage(context, "Survey", "Berhasil Menyimpan Data", "Ok", (){
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          }
                          // Encode and store data in SharedPreferences
                          else{
                            final String encodedData = Rumah.encode([
                              Rumah(
                                  provinsi: selectedProvinsi,
                                  kabupatenKota: selectedKabupaten,
                                  kecamatan: selectedKecamatan,
                                  kelurahanDesa: selectedKelurahan,
                                  rw: rwController.text,
                                  rt: rtController.text,
                                  nomorRumah: nomorRumahController.text,
                                  jalan: jalanController.text,
                                  lorongGang: lorongController.text,
                                  koordinatX: koordinatXController.text,
                                  koordinatY: koordinatYController.text,
                                  namaKkPemilikRumah: namaKKController.text,
                                  pekerjaan: selectedPekerjaan,
                                  idKtpkkKepalaRumahTangga: idKTPController.text,
                                  jumlahKk: jumlahKKController.text,
                                  jumlahPenghuniRumah: jumlahPenghuniController.text,
                                  fungsiBangunan: selectedFungsiBangunan,
                                  jumlahLantaiBangunan: selectedJumlahLntaiBangunan,
                                  jenisBangunan: selectedJenisBangunan,
                                  statusKepemilikanRumah:
                                  selectedStatusKepemilikanRumah,
                                  statusKepemilikanTanah:
                                  selectedStatusKepemilikanTanah,
                                  penghasilanRupiah: penghasilanController.text,
                                  materialAtap: selectedMaterialAtap,
                                  kondisiAtap: selectedKondisiAtap,
                                  materialLantai: selectedMaterialLantai,
                                  kondisiLantai: selectedKondisiLantai,
                                  materialDinding: selectedMaterialDinding,
                                  kondisiMaterial: selectedKondisiMaterial,
                                  kondisiRumah: selectedKondisiRumah,
                                  pondasi: selectedPondasi,
                                  luasBangunanMeter: luasBangunanController.text,
                                  sumberListrik: selectedSubmerListrik,
                                  sumberAir: selectedSubmerAir,
                                  jarakSumberAirKePembuanganMeter: jarakSumberAirController.text,
                                  sanitasi: selectedSanitasi,
                                  persampahan: selectedPersampahan,
                                  email: emailController.text,
                                  gambarRumahTampakDepan: _imageTampakDepan.path.toString(),
                                  gambarRumahTampakKanan: _imageTampakKanan.path.toString(),
                                  gambarRumahTampakKiri: _imageTampakKiri.path.toString(),
                                  gambarRumahTampakBelakang: _imageTampakBelakang.path.toString())
                            ]);

                            await prefs.setString('rumah_survey', encodedData);
                            print("SIMPAN DATA LOCAL BERHASIL");
                            FormHelper.showMessage(context, "Survey", "Berhasil Menyimpan Data", "Ok", (){
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
                          }

                        }else{
                          FormHelper.showMessage(context, "Peringatan", "Gambar wajib dimasukkan", "Ok", (){
                            Navigator.of(context).pop();
                          });
                        }



                      // }
                      // //KALAU TERDAPAT INTERNET
                      // else {

                      // }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "Submit",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
