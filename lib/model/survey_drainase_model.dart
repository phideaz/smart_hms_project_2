import 'dart:convert';

class Drainase {
  Drainase({
    this.provinsi,
    this.kabupatenKota,
    this.kecamatan,
    this.kelurahanDesa,
    this.rw,
    this.rt,
    this.ident,
    this.namaJalanLokasiSaluran,
    this.jenisSaluran,
    this.jenisKonstruksi,
    this.kondisiKonstruksi,
    this.jenisSaluranAtas,
    this.kondisiAliranDrainase,
    this.panjang,
    this.tinggi,
    this.lebarBawah,
    this.lebarAtas,
    this.tebalBibirDrainase,
    this.arahAliran,
    this.tahunPembuatan,
    this.yangMembangun,
    this.keterangan,
    this.fotoDrainase1,
    this.fotoDrainase2,
    this.fotoDrainase3,
    this.fotoDrainase4,
  });

  String provinsi;
  String kabupatenKota;
  String kecamatan;
  String kelurahanDesa;
  String rw;
  String rt;
  String ident;
  String namaJalanLokasiSaluran;
  String jenisSaluran;
  String jenisKonstruksi;
  String kondisiKonstruksi;
  String jenisSaluranAtas;
  String kondisiAliranDrainase;
  String panjang;
  String tinggi;
  String lebarBawah;
  String lebarAtas;
  String tebalBibirDrainase;
  String arahAliran;
  String tahunPembuatan;
  String yangMembangun;
  String keterangan;
  String fotoDrainase1;
  String fotoDrainase2;
  String fotoDrainase3;
  String fotoDrainase4;

  factory Drainase.fromJson(Map<String, dynamic> json) => Drainase(
    provinsi: json["provinsi"],
    kabupatenKota: json["kabupaten__kota"],
    kecamatan: json["kecamatan"],
    kelurahanDesa: json["kelurahan__desa"],
    rw: json["rw"],
    rt: json["rt"],
    ident: json["ident"],
    namaJalanLokasiSaluran: json["nama_jalan__lokasi_saluran"],
    jenisSaluran: json["jenis_saluran"],
    jenisKonstruksi: json["jenis_konstruksi"],
    kondisiKonstruksi: json["kondisi_konstruksi"],
    jenisSaluranAtas: json["jenis_saluran_atas"],
    kondisiAliranDrainase: json["kondisi_aliran_drainase"],
    panjang: json["panjang"],
    tinggi: json["tinggi"],
    lebarBawah: json["lebar_bawah"],
    lebarAtas: json["lebar_atas"],
    tebalBibirDrainase: json["tebal_bibir_drainase"],
    arahAliran: json["arah_aliran"],
    tahunPembuatan: json["tahun_pembuatan"],
    yangMembangun: json["yang_membangun"],
    keterangan: json["keterangan"],
    fotoDrainase1: json["foto_drainase_1"],
    fotoDrainase2: json["foto_drainase_2"],
    fotoDrainase3: json["foto_drainase_3"],
    fotoDrainase4: json["foto_drainase_4"],
  );

  Map<String, dynamic> toJson() => {
    "provinsi": provinsi,
    "kabupaten__kota": kabupatenKota,
    "kecamatan": kecamatan,
    "kelurahan__desa": kelurahanDesa,
    "rw": rw,
    "rt": rt,
    "ident": ident,
    "nama_jalan__lokasi_saluran": namaJalanLokasiSaluran,
    "jenis_saluran": jenisSaluran,
    "jenis_konstruksi": jenisKonstruksi,
    "kondisi_konstruksi": kondisiKonstruksi,
    "jenis_saluran_atas": jenisSaluranAtas,
    "kondisi_aliran_drainase": kondisiAliranDrainase,
    "panjang": panjang,
    "tinggi": tinggi,
    "lebar_bawah": lebarBawah,
    "lebar_atas": lebarAtas,
    "tebal_bibir_drainase": tebalBibirDrainase,
    "arah_aliran": arahAliran,
    "tahun_pembuatan": tahunPembuatan,
    "yang_membangun": yangMembangun,
    "keterangan": keterangan,
    "foto_drainase_1": fotoDrainase1,
    "foto_drainase_2": fotoDrainase2,
    "foto_drainase_3": fotoDrainase3,
    "foto_drainase_4": fotoDrainase4,
  };

  static Map<String, dynamic> toMap(Drainase drainase) => {
    "provinsi": drainase.provinsi,
    "kabupaten__kota": drainase.kabupatenKota,
    "kecamatan": drainase.kecamatan,
    "kelurahan__desa": drainase.kelurahanDesa,
    "rw": drainase.rw,
    "rt": drainase.rt,
    "ident": drainase.ident,
    "nama_jalan__lokasi_saluran": drainase.namaJalanLokasiSaluran,
    "jenis_saluran": drainase.jenisSaluran,
    "jenis_konstruksi": drainase.jenisKonstruksi,
    "kondisi_konstruksi": drainase.kondisiKonstruksi,
    "jenis_saluran_atas": drainase.jenisSaluranAtas,
    "kondisi_aliran_drainase": drainase.kondisiAliranDrainase,
    "panjang": drainase.panjang,
    "tinggi": drainase.tinggi,
    "lebar_bawah": drainase.lebarBawah,
    "lebar_atas": drainase.lebarAtas,
    "tebal_bibir_drainase": drainase.tebalBibirDrainase,
    "arah_aliran": drainase.arahAliran,
    "tahun_pembuatan": drainase.tahunPembuatan,
    "yang_membangun": drainase.yangMembangun,
    "keterangan": drainase.keterangan,
    "foto_drainase_1": drainase.fotoDrainase1,
    "foto_drainase_2": drainase.fotoDrainase2,
    "foto_drainase_3": drainase.fotoDrainase3,
    "foto_drainase_4": drainase.fotoDrainase4,
  };

  static String encode(List<Drainase> drainases) => json.encode(
    drainases
        .map<Map<String, dynamic>>((drainase) => Drainase.toMap(drainase))
        .toList(),
  );

  static List<Drainase> decode(String drainases) =>
      (json.decode(drainases) as List<dynamic>)
          .map<Drainase>((item) => Drainase.fromJson(item))
          .toList();
}
