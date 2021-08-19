import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress_api/model/survey_drainase_model.dart';
import 'package:flutter_wordpress_api/model/survey_jalan_model.dart';
import 'package:flutter_wordpress_api/model/survey_rumah_model.dart';
import 'package:flutter_wordpress_api/utils/form_helper.dart';
import 'package:flutter_wordpress_api/utils/list_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormDrainasePage extends StatefulWidget {
  @override
  _FormDrainasePageState createState() => _FormDrainasePageState();
}

class _FormDrainasePageState extends State<FormDrainasePage> {
  final _formKeyDrainase = GlobalKey<FormState>();

  String selectedProvinsi;
  String selectedKabupaten;
  String selectedKecamatan;
  String selectedKelurahan;
  String selectedJenisSaluran;
  String selectedJenisKonstruksi;
  String selectedKondisiKonstruksi;
  String selectedJenisSaluranAtas;
  String selectedKondisiAliranDrainase;

  TextEditingController rwController = TextEditingController();
  TextEditingController rtController = TextEditingController();
  TextEditingController identController = TextEditingController();
  TextEditingController namaJalanController = TextEditingController();
  TextEditingController panjangController = TextEditingController();
  TextEditingController tinggiController = TextEditingController();
  TextEditingController lebarBawahController = TextEditingController();
  TextEditingController lebarAtasController = TextEditingController();
  TextEditingController tebalBibirDrainaseController = TextEditingController();
  TextEditingController arahAliranController = TextEditingController();
  TextEditingController tahunPembuatanController = TextEditingController();
  TextEditingController yangMembangunController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  File _imageFoto1, _imageFoto2, _imageFoto3, _imageFoto4;
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

  Future getImage1() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;
    //

    // print("FILE : ${pickedFile.path}");
    String fileName = pickedFile.path.split('/').last;
    String fileExt = fileName.split('.').last;
    print("fileEXT : $fileExt");
    if(fileExt.toLowerCase() == "jpg" || fileExt.toLowerCase() == "jpeg" || fileExt.toLowerCase() == "png"){
      setState(() {
        if (pickedFile != null) {
          _imageFoto1 = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }else{
      FormHelper.showMessage(context, "Upload Gambar", "Harus format jpg, jpeg, atau png", "Ok", (){
        Navigator.of(context).pop();
      });
    }

  }

  Future getImage2() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    String fileName = pickedFile.path.split('/').last;
    String fileExt = fileName.split('.').last;
    print("fileEXT : $fileExt");
    if(fileExt.toLowerCase() == "jpg" || fileExt.toLowerCase() == "jpeg" || fileExt.toLowerCase() == "png"){
      setState(() {
        if (pickedFile != null) {
          _imageFoto2 = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }else{
      FormHelper.showMessage(context, "Upload Gambar", "Harus format jpg, jpeg, atau png", "Ok", (){
        Navigator.of(context).pop();
      });
    }

  }

  Future getImage3() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    String fileName = pickedFile.path.split('/').last;
    String fileExt = fileName.split('.').last;
    print("fileEXT : $fileExt");
    if(fileExt.toLowerCase() == "jpg" || fileExt.toLowerCase() == "jpeg" || fileExt.toLowerCase() == "png"){
      setState(() {
        if (pickedFile != null) {
          _imageFoto3 = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }else{
      FormHelper.showMessage(context, "Upload Gambar", "Harus format jpg, jpeg, atau png", "Ok", (){
        Navigator.of(context).pop();
      });
    }


  }

  Future getImage4() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    String fileName = pickedFile.path.split('/').last;
    String fileExt = fileName.split('.').last;
    print("fileEXT : $fileExt");
    if(fileExt.toLowerCase() == "jpg" || fileExt.toLowerCase() == "jpeg" || fileExt.toLowerCase() == "png"){
      setState(() {
        if (pickedFile != null) {
          _imageFoto4 = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }else{
      FormHelper.showMessage(context, "Upload Gambar", "Harus format jpg, jpeg, atau png", "Ok", (){
        Navigator.of(context).pop();
      });
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnection();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Survey Drainase"),
      ),
      body: Form(
        key: _formKeyDrainase,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Pendataan Data Drainase yang Ada di Provinsi Sumatera Selatan"),
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
                  //Ident
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Ident",
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
                        controller: identController,
                      ),
                    ],
                  ),
                  //Nama Jalan / Lokasi Saluran
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Nama Jalan / Lokasi Saluran",
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
                        controller: namaJalanController,
                      ),
                    ],
                  ),
                  //Jenis Saluran
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Jenis Saluran",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedJenisSaluran,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedJenisSaluran = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                          value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .jenisSaluranDrainase
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
                  //Jenis Konstruksi
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Jenis Konstruksi",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedJenisKonstruksi,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedJenisKonstruksi = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                          value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .jenisKonstruksi
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
                  //Kondisi Konstruksi
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Kondisi Konstruksi",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedKondisiKonstruksi,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedKondisiKonstruksi = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                          value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .kondisiKonstruksi
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
                  //Jenis Saluran Atas
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Jenis Saluran Atas",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedJenisSaluranAtas,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedJenisSaluranAtas = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                          value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .jenisSaluranAtas
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
                  //Kondisi Aliran Drainase
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Kondisi Aliran Drainase",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedKondisiAliranDrainase,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedKondisiAliranDrainase = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                          value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .kondisiAliranDrainase
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
                  //Panjang
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Panjang",
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
                            prefixIcon: Icon(Icons.event_note_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: panjangController,
                      ),
                    ],
                  ),
                  //Tinggi
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Tinggi",
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
                            prefixIcon: Icon(Icons.event_note_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: tinggiController,
                      ),
                    ],
                  ),
                  //Lebar Bawah
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Lebar Bawah",
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
                            prefixIcon: Icon(Icons.event_note_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: lebarBawahController,
                      ),
                    ],
                  ),
                  //Lebar Atas
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Lebar Atas",
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
                            prefixIcon: Icon(Icons.event_note_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: lebarAtasController,
                      ),
                    ],
                  ),
                  //Tebal Bibir Drainase
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Arah Aliran",
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
                            prefixIcon: Icon(Icons.event_note_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: arahAliranController,
                      ),
                    ],
                  ),
                  //Tebal Bibir Drainase
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Tebal Bibir Drainase",
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
                            prefixIcon: Icon(Icons.event_note_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: tebalBibirDrainaseController,
                      ),
                    ],
                  ),
                  //Tahun Pembuatan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Tahun Pembuatan",
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
                            prefixIcon: Icon(Icons.event_note_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: tahunPembuatanController,
                      ),
                    ],
                  ),
                  //Yang Membangun
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Yang Membangun",
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
                            prefixIcon: Icon(Icons.event_note_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: yangMembangunController,
                      ),
                    ],
                  ),
                  //Keterangan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Keterangan",
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
                            prefixIcon: Icon(Icons.event_note_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fillColor: Colors.white),
                        controller: keteranganController,
                      ),
                    ],
                  ),
                  //Foto Drainase 1
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Foto Drainase 1",
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
                                  getImage1();
                                },
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 70,
                                ),
                              ),
                            ),
                            (_imageFoto1 != null)
                                ? Image.file(
                              _imageFoto1,
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
                  //Foto Drainase 2
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Foto Drainase 2",
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
                                  getImage2();
                                },
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 70,
                                ),
                              ),
                            ),
                            (_imageFoto2 != null)
                                ? Image.file(
                              _imageFoto2,
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
                  //Foto Drainase 3
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "Foto Drainase 3",
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
                                  getImage3();
                                },
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 70,
                                ),
                              ),
                            ),
                            (_imageFoto3 != null)
                                ? Image.file(
                              _imageFoto3,
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
                  //Foto Drainase 4
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "Foto Drainase 4",
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
                                  getImage4();
                                },
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 70,
                                ),
                              ),
                            ),
                            (_imageFoto4 != null)
                                ? Image.file(
                              _imageFoto4,
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
                      if (_formKeyDrainase.currentState.validate()) {
                        //form is valid, proceed further
                        _formKeyDrainase.currentState
                            .save(); //save once fields are valid, onSaved method invoked for every form fields
                        if (_imageFoto1 != null ||
                            _imageFoto2 != null) {
                          final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          // Fetch and decode data
                          final String drainasesString =
                          prefs.getString('drainase_survey');
                          if (drainasesString != null) {
                            final List<Drainase> drainase =
                            Drainase.decode(drainasesString);
                            //TODO aktifkan ketika data db udah ada
                            //sendDataToDB(rumah);
                            Drainase newData = Drainase(
                                provinsi: selectedProvinsi,
                                kabupatenKota: selectedKabupaten,
                                kecamatan: selectedKecamatan,
                                kelurahanDesa: selectedKelurahan,
                                rw: rwController.text,
                                rt: rtController.text,
                                ident: identController.text,
                                namaJalanLokasiSaluran: namaJalanController.text,
                                jenisSaluran: selectedJenisSaluran,
                                jenisKonstruksi: selectedJenisKonstruksi,
                                kondisiKonstruksi: selectedKondisiKonstruksi,
                                jenisSaluranAtas: selectedJenisSaluranAtas,
                                kondisiAliranDrainase: selectedKondisiAliranDrainase,
                                panjang: panjangController.text,
                                tinggi: tinggiController.text,
                                lebarBawah: lebarBawahController.text,
                                lebarAtas: lebarAtasController.text,
                                tebalBibirDrainase: tebalBibirDrainaseController.text,
                                arahAliran: arahAliranController.text,
                                tahunPembuatan: tahunPembuatanController.text,
                                yangMembangun: yangMembangunController.text,
                                keterangan: keteranganController.text,
                                fotoDrainase1: _imageFoto1.path.toString(),
                                fotoDrainase2: _imageFoto2.path.toString(),
                                fotoDrainase3: _imageFoto3.path.toString(),
                                fotoDrainase4: _imageFoto4.path.toString());
                            drainase.add(newData);
                            String oldData = Drainase.encode(drainase);

                            await prefs.setString('drainase_survey', oldData);
                            print("SIMPAN DATA LOCAL BERHASIL");
                            FormHelper.showMessage(context, "Survey",
                                "Berhasil Menyimpan Data", "Ok", () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                });
                          }
                          // Encode and store data in SharedPreferences
                          else {
                            final String encodedData = Drainase.encode([
                              Drainase(
                                  provinsi: selectedProvinsi,
                                  kabupatenKota: selectedKabupaten,
                                  kecamatan: selectedKecamatan,
                                  kelurahanDesa: selectedKelurahan,
                                  rw: rwController.text,
                                  rt: rtController.text,
                                  ident: identController.text,
                                  namaJalanLokasiSaluran: namaJalanController.text,
                                  jenisSaluran: selectedJenisSaluran,
                                  jenisKonstruksi: selectedJenisKonstruksi,
                                  kondisiKonstruksi: selectedKondisiKonstruksi,
                                  jenisSaluranAtas: selectedJenisSaluranAtas,
                                  kondisiAliranDrainase: selectedKondisiAliranDrainase,
                                  panjang: panjangController.text,
                                  tinggi: tinggiController.text,
                                  lebarBawah: lebarBawahController.text,
                                  lebarAtas: lebarAtasController.text,
                                  tebalBibirDrainase: tebalBibirDrainaseController.text,
                                  arahAliran: arahAliranController.text,
                                  tahunPembuatan: tahunPembuatanController.text,
                                  yangMembangun: yangMembangunController.text,
                                  keterangan: keteranganController.text,
                                  fotoDrainase1: _imageFoto1.path.toString(),
                                  fotoDrainase2: _imageFoto2.path.toString(),
                                  fotoDrainase3: _imageFoto3.path.toString(),
                                  fotoDrainase4: _imageFoto4.path.toString())
                            ]);

                            await prefs.setString(
                                'drainase_survey', encodedData);
                            print("SIMPAN DATA LOCAL BERHASIL");
                            FormHelper.showMessage(context, "Survey",
                                "Berhasil Menyimpan Data", "Ok", () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                });
                          }
                        } else {
                          FormHelper.showMessage(context, "Peringatan",
                              "Gambar wajib dimasukkan", "Ok", () {
                                Navigator.of(context).pop();
                              });
                        }
                      }
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
