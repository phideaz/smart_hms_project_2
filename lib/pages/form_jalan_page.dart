import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress_api/model/survey_jalan_model.dart';
import 'package:flutter_wordpress_api/model/survey_rumah_model.dart';
import 'package:flutter_wordpress_api/utils/form_helper.dart';
import 'package:flutter_wordpress_api/utils/list_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormJalanPage extends StatefulWidget {
  @override
  _FormJalanPageState createState() => _FormJalanPageState();
}

class _FormJalanPageState extends State<FormJalanPage> {
  final _formKeyJalan = GlobalKey<FormState>();

  String selectedProvinsi;
  String selectedKabupaten;
  String selectedKecamatan;
  String selectedKelurahan;
  String selectedJenisPermukaan;
  String selectedKondisiJalan;
  String selectedMemilikiSaluran;
  String selectedJikaAdaSaluran;
  String selectedJenisSaluran;
  String selectedKondisiSaluran;
  TextEditingController rwController = TextEditingController();
  TextEditingController rtController = TextEditingController();
  TextEditingController identController = TextEditingController();
  TextEditingController namaJalanController = TextEditingController();
  TextEditingController panjangRuasController = TextEditingController();
  TextEditingController lebarLuasController = TextEditingController();
  TextEditingController tebalJalanController = TextEditingController();
  TextEditingController tahunPembuatanController = TextEditingController();
  TextEditingController yangMembangunController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  File _imageFotoJalan1, _imageFotoJalan2, _imageFotoJalan3, _imageFotoJalan4;
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

  Future getImageJalan1() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;
    //

    // print("FILE : ${pickedFile.path}");

    setState(() {
      if (pickedFile != null) {
        _imageFotoJalan1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageJalan2() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFotoJalan2 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageJalan3() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFotoJalan3 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageJalan4() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFotoJalan4 = File(pickedFile.path);
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Survey Jalan"),
      ),
      body: Form(
        key: _formKeyJalan,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Pendataan Lapangan Meliputi Nama Jalan, Jenis Permukaan, Kondisi, Panjang Ruas, Nomor Jalan, dsb"),
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
                      // Container(
                      //   margin: EdgeInsets.only(top: 8),
                      //   child: DropdownButtonFormField(
                      //     value: selectedKelurahan,
                      //     hint: Text(
                      //       '--Select--',
                      //     ),
                      //     onChanged: (value) =>
                      //         setState(() => selectedKelurahan = value),
                      //     autovalidateMode: AutovalidateMode.onUserInteraction,
                      //     validator: (value) =>
                      //         value == null ? 'Diwajibkan memilih' : null,
                      //     decoration: InputDecoration(
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(5),
                      //         ),
                      //         fillColor: Colors.white),
                      //     items: ListHelper()
                      //         .keluarahan
                      //         .map<DropdownMenuItem<String>>((String value) {
                      //       return DropdownMenuItem<String>(
                      //         value: value,
                      //         child: Container(
                      //           width: MediaQuery.of(context).size.width *
                      //               80 /
                      //               100,
                      //           child: Text(
                      //             value,
                      //             style: TextStyle(fontSize: 14),
                      //           ),
                      //         ),
                      //       );
                      //     }).toList(),
                      //   ),
                      // ),
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
                  //Nama Jalan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Nama Jalan",
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
                  //Jenis Permukaan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Jenis Permukaan",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedJenisPermukaan,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedJenisPermukaan = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .jenisPermukaan
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
                  //Kondisi
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Kondisi",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedKondisiJalan,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedKondisiJalan = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .kondisiJalan
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
                  //Memiliki Saluran
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Memiliki Saluran",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedMemilikiSaluran,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedMemilikiSaluran = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .memilikiSaluran
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
                  //Jika Ada Saluran
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Jika Ada Saluran",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedJikaAdaSaluran,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedJikaAdaSaluran = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .jikaAdaSaluran
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
                              .jenisSaluran
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
                  //Kondisi Saluran
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Kondisi Saluran",
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: DropdownButtonFormField(
                          value: selectedKondisiSaluran,
                          hint: Text(
                            '--Select--',
                          ),
                          onChanged: (value) =>
                              setState(() => selectedKondisiSaluran = value),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              value == null ? 'Diwajibkan memilih' : null,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              fillColor: Colors.white),
                          items: ListHelper()
                              .kondisiSaluran
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
                  //Panjang Ruas
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Panjang Ruas",
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
                        controller: panjangRuasController,
                      ),
                    ],
                  ),
                  //Lebar Ruas
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Lebar Ruas",
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
                        controller: lebarLuasController,
                      ),
                    ],
                  ),
                  //Tebal Jalan
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Tebal jalan",
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
                        controller: tebalJalanController,
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
                  //Foto Jalan 1
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Foto Jalan 1",
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
                                  getImageJalan1();
                                },
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 70,
                                ),
                              ),
                            ),
                            (_imageFotoJalan1 != null)
                                ? Image.file(
                                    _imageFotoJalan1,
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
                  //Foto Jalan 2
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Foto Jalan 2",
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
                                  getImageJalan2();
                                },
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 70,
                                ),
                              ),
                            ),
                            (_imageFotoJalan2 != null)
                                ? Image.file(
                                    _imageFotoJalan2,
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
                  //Foto Jalan 3
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "Foto Jalan 3",
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
                                  getImageJalan3();
                                },
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 70,
                                ),
                              ),
                            ),
                            (_imageFotoJalan3 != null)
                                ? Image.file(
                                    _imageFotoJalan3,
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
                  //Foto Jalan 4
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "Foto Jalan 4",
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
                                  getImageJalan4();
                                },
                                child: Icon(
                                  Icons.add_photo_alternate,
                                  size: 70,
                                ),
                              ),
                            ),
                            (_imageFotoJalan4 != null)
                                ? Image.file(
                                    _imageFotoJalan4,
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
                      if (_formKeyJalan.currentState.validate()) {
                        //form is valid, proceed further
                        _formKeyJalan.currentState
                            .save(); //save once fields are valid, onSaved method invoked for every form fields
                        if (isKonek == false) {
                          if (_imageFotoJalan1 != null ||
                              _imageFotoJalan2 != null) {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            // Fetch and decode data
                            final String jalansString =
                                prefs.getString('jalan_survey');
                            if (jalansString != null) {
                              final List<Jalan> jalan =
                                  Jalan.decode(jalansString);
                              //TODO aktifkan ketika data db udah ada
                              //sendDataToDB(rumah);
                              Jalan newData = Jalan(
                                  provinsi: selectedProvinsi,
                                  kabupatenKota: selectedKabupaten,
                                  kecamatan: selectedKecamatan,
                                  kelurahanDesa: selectedKelurahan,
                                  rw: rwController.text,
                                  rt: rtController.text,
                                  ident: identController.text,
                                  namaJalan: namaJalanController.text,
                                  jenisPermukaan: selectedJenisPermukaan,
                                  kondisi: selectedKondisiJalan,
                                  memilikiSaluran: selectedMemilikiSaluran,
                                  jikaAdaSaluran: selectedJikaAdaSaluran,
                                  jenisSaluran: selectedJenisSaluran,
                                  kondisiSaluran: selectedKondisiSaluran,
                                  panjangRuas: panjangRuasController.text,
                                  lebarRuas: lebarLuasController.text,
                                  tebalJalan: tebalJalanController.text,
                                  tahunPembuatan: tahunPembuatanController.text,
                                  yangMembangun: yangMembangunController.text,
                                  keterangan: keteranganController.text,
                                  fotoJalan1: _imageFotoJalan1.toString(),
                                  fotoJalan2: _imageFotoJalan2.toString(),
                                  fotoJalan3: _imageFotoJalan3.toString(),
                                  fotoJalan4: _imageFotoJalan4.toString());
                              jalan.add(newData);
                              String oldData = Jalan.encode(jalan);

                              await prefs.setString('jalan_survey', oldData);
                              print("SIMPAN DATA LOCAL BERHASIL");
                              FormHelper.showMessage(context, "Survey",
                                  "Berhasil Menyimpan Data", "Ok", () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              });
                            }
                            // Encode and store data in SharedPreferences
                            else {
                              final String encodedData = Jalan.encode([
                                Jalan(
                                    provinsi: selectedProvinsi,
                                    kabupatenKota: selectedKabupaten,
                                    kecamatan: selectedKecamatan,
                                    kelurahanDesa: selectedKelurahan,
                                    rw: rwController.text,
                                    rt: rtController.text,
                                    ident: identController.text,
                                    namaJalan: namaJalanController.text,
                                    jenisPermukaan: selectedJenisPermukaan,
                                    kondisi: selectedKondisiJalan,
                                    memilikiSaluran: selectedMemilikiSaluran,
                                    jikaAdaSaluran: selectedJikaAdaSaluran,
                                    jenisSaluran: selectedJenisSaluran,
                                    kondisiSaluran: selectedKondisiSaluran,
                                    panjangRuas: panjangRuasController.text,
                                    lebarRuas: lebarLuasController.text,
                                    tebalJalan: tebalJalanController.text,
                                    tahunPembuatan:
                                        tahunPembuatanController.text,
                                    yangMembangun: yangMembangunController.text,
                                    keterangan: keteranganController.text,
                                    fotoJalan1: _imageFotoJalan1.toString(),
                                    fotoJalan2: _imageFotoJalan2.toString(),
                                    fotoJalan3: _imageFotoJalan3.toString(),
                                    fotoJalan4: _imageFotoJalan4.toString())
                              ]);

                              await prefs.setString(
                                  'jalan_survey', encodedData);
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
                      }
                      //KALAU TERDAPAT INTERNET
                      else {}
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
