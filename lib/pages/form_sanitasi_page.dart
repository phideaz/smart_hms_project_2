import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordpress_api/model/survey_sanitasi_model.dart';
import 'package:flutter_wordpress_api/utils/form_helper.dart';
import 'package:flutter_wordpress_api/utils/list_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormSanitasiPage extends StatefulWidget {
  @override
  _FormSanitasiPageState createState() => _FormSanitasiPageState();
}

class _FormSanitasiPageState extends State<FormSanitasiPage> {
  final _formKeySanitasi = GlobalKey<FormState>();

  String selectedProvinsi;
  String selectedKabupaten;
  String selectedKecamatan;
  String selectedKelurahan;
  String selectedFasilitasSanitasi;
  String selectedBangunanAtas;
  String selectedBangunanBawah;
  String selectedPembuanganAirLimbahRt;
  String selectedPembuanganSampahRt;

  TextEditingController rwController = TextEditingController();
  TextEditingController rtController = TextEditingController();
  TextEditingController jumlahKamarMandiWcController = TextEditingController();
  TextEditingController namaKkPemilikRumahController = TextEditingController();

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

    setState(() {
      if (pickedFile != null) {
        _imageFoto1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage2() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFoto2 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage3() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFoto3 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage4() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFoto4 = File(pickedFile.path);
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
        title: Text("Survey Sanitasi"),
      ),
      body: Form(
        key: _formKeySanitasi,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Pendataan Sanitasi yang Ada di Provinsi Sumatera Selatan"),
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
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: SearchableDropdown.single(
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
                          value: selectedProvinsi,
                          displayClearIcon: false,
                          hint: "Pilih Provinsi",
                          searchHint: "Pilih Provinsi",
                          validator: (value) =>
                          value == null ? 'Diwajibkan memilih' : null,
                          onChanged: (value) {
                            setState(() {
                              selectedProvinsi = value;
                            });
                          },
                          isExpanded: true,
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
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: SearchableDropdown.single(
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
                          value: selectedKabupaten,
                          displayClearIcon: false,
                          hint: "Pilih Kabupaten / Kota",
                          searchHint: "Pilih Kabupaten / Kota",
                          validator: (value) =>
                          value == null ? 'Diwajibkan memilih' : null,
                          onChanged: (value) {
                            setState(() {
                              selectedKabupaten = value;
                            });
                          },
                          isExpanded: true,
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
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: SearchableDropdown.single(
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
                          value: selectedKecamatan,
                          displayClearIcon: false,
                          hint: "Pilih Kecamatan",
                          searchHint: "Pilih Kecamatan",
                          validator: (value) =>
                          value == null ? 'Diwajibkan memilih' : null,
                          onChanged: (value) {
                            setState(() {
                              selectedKecamatan = value;
                            });
                          },
                          isExpanded: true,
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
                  //Jumlah Kamar Mandi / WC
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Jumlah Kamar Mandi / WC",
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
                        controller: jumlahKamarMandiWcController,
                      ),
                    ],
                  ),
                  //Nama KK / Pemilik Rumah
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Nama KK / Pemilik Rumah",
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
                        controller: namaKkPemilikRumahController,
                      ),
                    ],
                  ),
                  //Fasilitas Sanitasi
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Fasilitas Sanitasi",
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
                              .fasilitasSanitasi
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
                          value: selectedFasilitasSanitasi,
                          displayClearIcon: false,
                          hint: "Pilih Fasilitas Sanitasi",
                          searchHint: "Pilih Fasilitas Sanitasi",
                          validator: (value) =>
                          value == null ? 'Diwajibkan memilih' : null,
                          onChanged: (value) {
                            setState(() {
                              selectedFasilitasSanitasi = value;
                            });
                          },
                          isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                  //Bangunan Atas
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Bangunan Atas",
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
                              .bangunanAtas
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
                          value: selectedBangunanAtas,
                          displayClearIcon: false,
                          hint: "Pilih Bangunan Atas",
                          searchHint: "Pilih Bangunan Atas",
                          validator: (value) =>
                          value == null ? 'Diwajibkan memilih' : null,
                          onChanged: (value) {
                            setState(() {
                              selectedBangunanAtas = value;
                            });
                          },
                          isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                  //Bangunan Bawah
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Bangunan Bawah",
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
                              .bangunanBawah
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
                          value: selectedBangunanBawah,
                          displayClearIcon: false,
                          hint: "Pilih Bangunan Bawah",
                          searchHint: "Pilih Bangunan Bawah",
                          validator: (value) =>
                          value == null ? 'Diwajibkan memilih' : null,
                          onChanged: (value) {
                            setState(() {
                              selectedBangunanBawah = value;
                            });
                          },
                          isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                  //Pembuangan Air Limbah Rumah Tangga
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Pembuangan Air Limbah RT",
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
                              .pembuanganAirLimbahRt
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
                          value: selectedPembuanganAirLimbahRt,
                          displayClearIcon: false,
                          hint: "Pilih Pembuangan Air Limbah RT",
                          searchHint: "Pilih Pembuangan Air Limbah RT",
                          validator: (value) =>
                          value == null ? 'Diwajibkan memilih' : null,
                          onChanged: (value) {
                            setState(() {
                              selectedPembuanganAirLimbahRt = value;
                            });
                          },
                          isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                  //Pembuangan Sampah Rumah Tangga
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Pembuangan Sampah RT",
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
                              .pembuanganSampahRt
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
                          value: selectedPembuanganSampahRt,
                          displayClearIcon: false,
                          hint: "Pilih Pembuangan Sampah RT",
                          searchHint: "Pilih Pembuangan Sampah RT",
                          validator: (value) =>
                          value == null ? 'Diwajibkan memilih' : null,
                          onChanged: (value) {
                            setState(() {
                              selectedPembuanganSampahRt = value;
                            });
                          },
                          isExpanded: true,
                        ),
                      ),
                    ],
                  ),
                  //Foto Sanitasi 1
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Foto Sanitasi 1",
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
                  //Foto Sanitasi 2
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "*Foto Sanitasi 2",
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
                  //Foto Sanitasi 3
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "Foto Sanitasi 3",
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
                  //Foto Persampahan 1
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "Foto Persampahan 1",
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
                      if (_formKeySanitasi.currentState.validate()) {
                        //form is valid, proceed further
                        _formKeySanitasi.currentState
                            .save(); //save once fields are valid, onSaved method invoked for every form fields
                        if (isKonek == false) {
                          if (_imageFoto1 != null ||
                              _imageFoto2 != null) {
                            final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            // Fetch and decode data
                            final String sanitasisString =
                            prefs.getString('sanitasi_survey');
                            if (sanitasisString != null) {
                              final List<Sanitasi> sanitasi =
                              Sanitasi.decode(sanitasisString);
                              //TODO aktifkan ketika data db udah ada
                              //sendDataToDB(sanitasi);
                              Sanitasi newData = Sanitasi(
                                  provinsi: selectedProvinsi,
                                  kabupatenKota: selectedKabupaten,
                                  kecamatan: selectedKecamatan,
                                  kelurahanDesa: selectedKelurahan,
                                  rw: rwController.text,
                                  rt: rtController.text,
                                  jumlahKamarMandiWc: jumlahKamarMandiWcController.text,
                                  namaKkPemilikRumah: namaKkPemilikRumahController.text,
                                  fasilitasSanitasi: selectedFasilitasSanitasi,
                                  bangunanAtas: selectedBangunanAtas,
                                  bangunanBawah: selectedBangunanBawah,
                                  pembuanganAirLimbahRt: selectedPembuanganAirLimbahRt,
                                  pembuanganSampahRt: selectedPembuanganSampahRt,
                                  fotoSanitasi1: _imageFoto1.toString(),
                                  fotoSanitasi2: _imageFoto2.toString(),
                                  fotoSanitasi3: _imageFoto3.toString(),
                                  fotoSaranaPersampahan1: _imageFoto4.toString());
                              sanitasi.add(newData);
                              String oldData = Sanitasi.encode(sanitasi);

                              await prefs.setString('sanitasi_survey', oldData);
                              print("SIMPAN DATA LOCAL BERHASIL");
                              FormHelper.showMessage(context, "Survey",
                                  "Berhasil Menyimpan Data", "Ok", () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  });
                            }
                            // Encode and store data in SharedPreferences
                            else {
                              final String encodedData = Sanitasi.encode([
                                Sanitasi(
                                    provinsi: selectedProvinsi,
                                    kabupatenKota: selectedKabupaten,
                                    kecamatan: selectedKecamatan,
                                    kelurahanDesa: selectedKelurahan,
                                    rw: rwController.text,
                                    rt: rtController.text,
                                    jumlahKamarMandiWc: jumlahKamarMandiWcController.text,
                                    namaKkPemilikRumah: namaKkPemilikRumahController.text,
                                    fasilitasSanitasi: selectedFasilitasSanitasi,
                                    bangunanAtas: selectedBangunanAtas,
                                    bangunanBawah: selectedBangunanBawah,
                                    pembuanganAirLimbahRt: selectedPembuanganAirLimbahRt,
                                    pembuanganSampahRt: selectedPembuanganSampahRt,
                                    fotoSanitasi1: _imageFoto1.toString(),
                                    fotoSanitasi2: _imageFoto2.toString(),
                                    fotoSanitasi3: _imageFoto3.toString(),
                                    fotoSaranaPersampahan1: _imageFoto4.toString())
                              ]);

                              await prefs.setString(
                                  'sanitasi_survey', encodedData);
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
