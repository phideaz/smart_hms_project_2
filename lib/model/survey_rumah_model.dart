import 'dart:convert';

import 'dart:io';


class Rumah {
  Rumah({
    this.provinsi,
    this.kabupatenKota,
    this.kecamatan,
    this.kelurahanDesa,
    this.rw,
    this.rt,
    this.nomorRumah,
    this.jalan,
    this.lorongGang,
    this.ident,
    this.koordinatX,
    this.koordinatY,
    this.namaKkPemilikRumah,
    this.pekerjaan,
    this.idKtpkkKepalaRumahTangga,
    this.jumlahKk,
    this.jumlahPenghuniRumah,
    this.fungsiBangunan,
    this.jumlahLantaiBangunan,
    this.jenisBangunan,
    this.statusKepemilikanRumah,
    this.statusKepemilikanTanah,
    this.penghasilanRupiah,
    this.materialAtap,
    this.kondisiAtap,
    this.materialLantai,
    this.kondisiLantai,
    this.materialDinding,
    this.kondisiMaterial,
    this.kondisiRumah,
    this.pondasi,
    this.luasBangunanMeter,
    this.sumberListrik,
    this.sumberAir,
    this.jarakSumberAirKePembuanganMeter,
    this.sanitasi,
    this.persampahan,
    this.email,
    this.gambarRumahTampakDepan,
    this.gambarRumahTampakKanan,
    this.gambarRumahTampakKiri,
    this.gambarRumahTampakBelakang,
  });

  String provinsi;
  String kabupatenKota;
  String kecamatan;
  String kelurahanDesa;
  String rw;
  String rt;
  String nomorRumah;
  String jalan;
  String lorongGang;
  String ident;
  String koordinatX;
  String koordinatY;
  String namaKkPemilikRumah;
  String pekerjaan;
  String idKtpkkKepalaRumahTangga;
  String jumlahKk;
  String jumlahPenghuniRumah;
  String fungsiBangunan;
  String jumlahLantaiBangunan;
  String jenisBangunan;
  String statusKepemilikanRumah;
  String statusKepemilikanTanah;
  String penghasilanRupiah;
  String materialAtap;
  String kondisiAtap;
  String materialLantai;
  String kondisiLantai;
  String materialDinding;
  String kondisiMaterial;
  String kondisiRumah;
  String pondasi;
  String luasBangunanMeter;
  String sumberListrik;
  String sumberAir;
  String jarakSumberAirKePembuanganMeter;
  String sanitasi;
  String persampahan;
  String email;
  String gambarRumahTampakDepan;
  String gambarRumahTampakKanan;
  String gambarRumahTampakKiri;
  String gambarRumahTampakBelakang;

  factory Rumah.fromJson(Map<String, dynamic> json) => Rumah(
    provinsi: json["provinsi"],
    kabupatenKota: json["kabupaten__kota"],
    kecamatan: json["kecamatan"],
    kelurahanDesa: json["kelurahan__desa"],
    rw: json["rw"],
    rt: json["rt"],
    nomorRumah: json["nomor_rumah"],
    jalan: json["jalan"],
    lorongGang: json["lorong__gang"],
    ident: json["ident"],
    koordinatX: json["koordinat_x"],
    koordinatY: json["koordinat__y"],
    namaKkPemilikRumah: json["nama_kk_pemilik_rumah"],
    pekerjaan: json["pekerjaan"],
    idKtpkkKepalaRumahTangga: json["id_ktpkk_kepala_rumah_tangga"],
    jumlahKk: json["jumlah_kk"],
    jumlahPenghuniRumah: json["jumlah_penghuni_rumah"],
    fungsiBangunan: json["fungsi_bangunan"],
    jumlahLantaiBangunan: json["jumlah_lantai_bangunan"],
    jenisBangunan: json["jenis_bangunan"],
    statusKepemilikanRumah: json["status_kepemilikan_rumah"],
    statusKepemilikanTanah: json["status_kepemilikan_tanah"],
    penghasilanRupiah: json["penghasilan_rupiah"],
    materialAtap: json["material_atap"],
    kondisiAtap: json["kondisi_atap"],
    materialLantai: json["material_lantai"],
    kondisiLantai: json["kondisi_lantai"],
    materialDinding: json["material_dinding"],
    kondisiMaterial: json["kondisi_material"],
    kondisiRumah: json["kondisi_rumah"],
    pondasi: json["pondasi"],
    luasBangunanMeter: json["luas_bangunan_meter"],
    sumberListrik: json["sumber_listrik"],
    sumberAir: json["sumber_air"],
    jarakSumberAirKePembuanganMeter: json["jarak_sumber_air_ke_pembuangan_meter"],
    sanitasi: json["sanitasi"],
    persampahan: json["persampahan"],
    email: json["email"],
    gambarRumahTampakDepan: json["gambar_rumah_tampak_depan"],
    gambarRumahTampakKanan: json["gambar_rumah_tampak_kanan"],
    gambarRumahTampakKiri: json["gambar_rumah_tampak_kiri"],
    gambarRumahTampakBelakang: json["gambar_rumah_tampak_belakang"],
  );

  Map<String, dynamic> toJson() => {
    "provinsi": provinsi,
    "kabupaten__kota": kabupatenKota,
    "kecamatan": kecamatan,
    "kelurahan__desa": kelurahanDesa,
    "rw": rw,
    "rt": rt,
    "nomor_rumah": nomorRumah,
    "jalan": jalan,
    "lorong__gang": lorongGang,
    "ident": ident,
    "koordinat_x": koordinatX,
    "koordinat__y": koordinatY,
    "nama_kk_pemilik_rumah": namaKkPemilikRumah,
    "pekerjaan": pekerjaan,
    "id_ktpkk_kepala_rumah_tangga": idKtpkkKepalaRumahTangga,
    "jumlah_kk": jumlahKk,
    "jumlah_penghuni_rumah": jumlahPenghuniRumah,
    "fungsi_bangunan": fungsiBangunan,
    "jumlah_lantai_bangunan": jumlahLantaiBangunan,
    "jenis_bangunan": jenisBangunan,
    "status_kepemilikan_rumah": statusKepemilikanRumah,
    "status_kepemilikan_tanah": statusKepemilikanTanah,
    "penghasilan_rupiah": penghasilanRupiah,
    "material_atap": materialAtap,
    "kondisi_atap": kondisiAtap,
    "material_lantai": materialLantai,
    "kondisi_lantai": kondisiLantai,
    "material_dinding": materialDinding,
    "kondisi_material": kondisiMaterial,
    "kondisi_rumah": kondisiRumah,
    "pondasi": pondasi,
    "luas_bangunan_meter": luasBangunanMeter,
    "sumber_listrik": sumberListrik,
    "sumber_air": sumberAir,
    "jarak_sumber_air_ke_pembuangan_meter": jarakSumberAirKePembuanganMeter,
    "sanitasi": sanitasi,
    "persampahan": persampahan,
    "email": email,
    "gambar_rumah_tampak_depan": gambarRumahTampakDepan,
    "gambar_rumah_tampak_kanan": gambarRumahTampakKanan,
    "gambar_rumah_tampak_kiri": gambarRumahTampakKiri,
    "gambar_rumah_tampak_belakang": gambarRumahTampakBelakang,
  };

  static Map<String, dynamic> toMap(Rumah rumah) => {
    "provinsi": rumah.provinsi,
    "kabupaten__kota": rumah.kabupatenKota,
    "kecamatan": rumah.kecamatan,
    "kelurahan__desa": rumah.kelurahanDesa,
    "rw": rumah.rw,
    "rt": rumah.rt,
    "nomor_rumah": rumah.nomorRumah,
    "jalan": rumah.jalan,
    "lorong__gang": rumah.lorongGang,
    "ident": rumah.ident,
    "koordinat_x": rumah.koordinatX,
    "koordinat__y": rumah.koordinatY,
    "nama_kk_pemilik_rumah": rumah.namaKkPemilikRumah,
    "pekerjaan": rumah.pekerjaan,
    "id_ktpkk_kepala_rumah_tangga": rumah.idKtpkkKepalaRumahTangga,
    "jumlah_kk": rumah.jumlahKk,
    "jumlah_penghuni_rumah": rumah.jumlahPenghuniRumah,
    "fungsi_bangunan": rumah.fungsiBangunan,
    "jumlah_lantai_bangunan": rumah.jumlahLantaiBangunan,
    "jenis_bangunan": rumah.jenisBangunan,
    "status_kepemilikan_rumah": rumah.statusKepemilikanRumah,
    "status_kepemilikan_tanah": rumah.statusKepemilikanTanah,
    "penghasilan_rupiah": rumah.penghasilanRupiah,
    "material_atap": rumah.materialAtap,
    "kondisi_atap": rumah.kondisiAtap,
    "material_lantai": rumah.materialLantai,
    "kondisi_lantai": rumah.kondisiLantai,
    "material_dinding": rumah.materialDinding,
    "kondisi_material": rumah.kondisiMaterial,
    "kondisi_rumah": rumah.kondisiRumah,
    "pondasi": rumah.pondasi,
    "luas_bangunan_meter": rumah.luasBangunanMeter,
    "sumber_listrik": rumah.sumberListrik,
    "sumber_air": rumah.sumberAir,
    "jarak_sumber_air_ke_pembuangan_meter": rumah.jarakSumberAirKePembuanganMeter,
    "sanitasi": rumah.sanitasi,
    "persampahan": rumah.persampahan,
    "email": rumah.email,
    "gambar_rumah_tampak_depan": rumah.gambarRumahTampakDepan,
    "gambar_rumah_tampak_kanan": rumah.gambarRumahTampakKanan,
    "gambar_rumah_tampak_kiri": rumah.gambarRumahTampakKiri,
    "gambar_rumah_tampak_belakang": rumah.gambarRumahTampakBelakang,
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
