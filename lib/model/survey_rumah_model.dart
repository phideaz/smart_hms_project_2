import 'dart:convert';

import 'dart:io';


class Rumah {
  Rumah({
    this.provinsi,
    this.kabupaten,
    this.kecamatan,
    this.kelurahan,
    this.rw,
    this.rt,
    this.nomorRumah,
    this.jalan,
    this.lorong,
    this.koordinatX,
    this.koordinatY,
    this.namaKk,
    this.pekerjaan,
    this.idKtp,
    this.jumlahKk,
    this.jumlahPenghuni,
    this.fungsiBangunan,
    this.jumlahLantai,
    this.jenisBangunan,
    this.statusKepemilikanRumah,
    this.statusKepemilikanTanah,
    this.penghasilan,
    this.materialAtap,
    this.kondisiAtap,
    this.materialLantai,
    this.kondisiLantai,
    this.materialDinding,
    this.kondisiMaterial,
    this.kondisiRumah,
    this.pondasi,
    this.luasBangunan,
    this.sumberListrik,
    this.sumberAir,
    this.jarakSumberkeAir,
    this.sanitasi,
    this.persampahan,
    this.email,
    this.gambarDepan,
    this.gambarKanan,
    this.gambarKiri,
    this.gambarBelakang,
  });

  String provinsi;
  String kabupaten;
  String kecamatan;
  String kelurahan;
  String rw;
  String rt;
  String nomorRumah;
  String jalan;
  String lorong;
  String koordinatX;
  String koordinatY;
  String namaKk;
  String pekerjaan;
  String idKtp;
  String jumlahKk;
  String jumlahPenghuni;
  String fungsiBangunan;
  String jumlahLantai;
  String jenisBangunan;
  String statusKepemilikanRumah;
  String statusKepemilikanTanah;
  String penghasilan;
  String materialAtap;
  String kondisiAtap;
  String materialLantai;
  String kondisiLantai;
  String materialDinding;
  String kondisiMaterial;
  String kondisiRumah;
  String pondasi;
  String luasBangunan;
  String sumberListrik;
  String sumberAir;
  String jarakSumberkeAir;
  String sanitasi;
  String persampahan;
  String email;
  String gambarDepan;
  String gambarKanan;
  String gambarKiri;
  String gambarBelakang;

  factory Rumah.fromJson(Map<String, dynamic> json) => Rumah(
    provinsi: json["provinsi"],
    kabupaten: json["kabupaten"],
    kecamatan: json["kecamatan"],
    kelurahan: json["kelurahan"],
    rw: json["rw"],
    rt: json["rt"],
    nomorRumah: json["nomorRumah"],
    jalan: json["jalan"],
    lorong: json["lorong"],
    koordinatX: json["koordinatX"],
    koordinatY: json["koordinatY"],
    namaKk: json["namaKK"],
    pekerjaan: json["pekerjaan"],
    idKtp: json["idKTP"],
    jumlahKk: json["jumlahKK"],
    jumlahPenghuni: json["jumlahPenghuni"],
    fungsiBangunan: json["fungsiBangunan"],
    jumlahLantai: json["jumlahLantai"],
    jenisBangunan: json["jenisBangunan"],
    statusKepemilikanRumah: json["statusKepemilikanRumah"],
    statusKepemilikanTanah: json["statusKepemilikanTanah"],
    penghasilan: json["penghasilan"],
    materialAtap: json["materialAtap"],
    kondisiAtap: json["kondisiAtap"],
    materialLantai: json["materialLantai"],
    kondisiLantai: json["kondisiLantai"],
    materialDinding: json["materialDinding"],
    kondisiMaterial: json["kondisiMaterial"],
    kondisiRumah: json["kondisiRumah"],
    pondasi: json["pondasi"],
    luasBangunan: json["luasBangunan"],
    sumberListrik: json["sumberListrik"],
    sumberAir: json["sumberAir"],
    jarakSumberkeAir: json["jarakSumberkeAir"],
    sanitasi: json["sanitasi"],
    persampahan: json["persampahan"],
    email: json["email"],
    gambarDepan: json["gambarDepan"],
    gambarKanan: json["gambarKanan"],
    gambarKiri: json["gambarKiri"],
    gambarBelakang: json["gambarBelakang"],
  );

  Map<String, dynamic> toJson() => {
    "provinsi": provinsi,
    "kabupaten": kabupaten,
    "kecamatan": kecamatan,
    "kelurahan": kelurahan,
    "rw": rw,
    "rt": rt,
    "nomorRumah": nomorRumah,
    "jalan": jalan,
    "lorong": lorong,
    "koordinatX": koordinatX,
    "koordinatY": koordinatY,
    "namaKK": namaKk,
    "pekerjaan": pekerjaan,
    "idKTP": idKtp,
    "jumlahKK": jumlahKk,
    "jumlahPenghuni": jumlahPenghuni,
    "fungsiBangunan": fungsiBangunan,
    "jumlahLantai": jumlahLantai,
    "jenisBangunan": jenisBangunan,
    "statusKepemilikanRumah": statusKepemilikanRumah,
    "statusKepemilikanTanah": statusKepemilikanTanah,
    "penghasilan": penghasilan,
    "materialAtap": materialAtap,
    "kondisiAtap": kondisiAtap,
    "materialLantai": materialLantai,
    "kondisiLantai": kondisiLantai,
    "materialDinding": materialDinding,
    "kondisiMaterial": kondisiMaterial,
    "kondisiRumah": kondisiRumah,
    "pondasi": pondasi,
    "luasBangunan": luasBangunan,
    "sumberListrik": sumberListrik,
    "sumberAir": sumberAir,
    "jarakSumberkeAir": jarakSumberkeAir,
    "sanitasi": sanitasi,
    "persampahan": persampahan,
    "email": email,
    "gambarDepan": gambarDepan,
    "gambarKanan": gambarKanan,
    "gambarKiri": gambarKiri,
    "gambarBelakang": gambarBelakang,
  };

  static Map<String, dynamic> toMap(Rumah rumah) => {
    "provinsi": rumah.provinsi,
    "kabupaten": rumah.kabupaten,
    "kecamatan": rumah.kecamatan,
    "kelurahan": rumah.kelurahan,
    "rw": rumah.rw,
    "rt": rumah.rt,
    "nomorRumah": rumah.nomorRumah,
    "jalan": rumah.jalan,
    "lorong": rumah.lorong,
    "koordinatX": rumah.koordinatX,
    "koordinatY": rumah.koordinatY,
    "namaKK": rumah.namaKk,
    "pekerjaan": rumah.pekerjaan,
    "idKTP": rumah.idKtp,
    "jumlahKK": rumah.jumlahKk,
    "jumlahPenghuni": rumah.jumlahPenghuni,
    "fungsiBangunan": rumah.fungsiBangunan,
    "jumlahLantai": rumah.jumlahLantai,
    "jenisBangunan": rumah.jenisBangunan,
    "statusKepemilikanRumah": rumah.statusKepemilikanRumah,
    "statusKepemilikanTanah": rumah.statusKepemilikanTanah,
    "penghasilan": rumah.penghasilan,
    "materialAtap": rumah.materialAtap,
    "kondisiAtap": rumah.kondisiAtap,
    "materialLantai": rumah.materialLantai,
    "kondisiLantai": rumah.kondisiLantai,
    "materialDinding": rumah.materialDinding,
    "kondisiMaterial": rumah.kondisiMaterial,
    "kondisiRumah": rumah.kondisiRumah,
    "pondasi": rumah.pondasi,
    "luasBangunan": rumah.luasBangunan,
    "sumberListrik": rumah.sumberListrik,
    "sumberAir": rumah.sumberAir,
    "jarakSumberkeAir": rumah.jarakSumberkeAir,
    "sanitasi": rumah.sanitasi,
    "persampahan": rumah.persampahan,
    "email": rumah.email,
    "gambarDepan": rumah.gambarDepan,
    "gambarKanan": rumah.gambarKanan,
    "gambarKiri": rumah.gambarKiri,
    "gambarBelakang": rumah.gambarBelakang,
  };

  static String encode(List<Rumah> rumahs) => json.encode(
    rumahs
        .map<Map<String, dynamic>>((rumah) => Rumah.toMap(rumah))
        .toList(),
  );

  static List<Rumah> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<Rumah>((item) => Rumah.fromJson(item))
          .toList();
}
