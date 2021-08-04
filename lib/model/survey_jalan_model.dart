import 'dart:convert';

class Jalan {
  Jalan({
    this.provinsi,
    this.kabupatenKota,
    this.kecamatan,
    this.kelurahanDesa,
    this.rw,
    this.rt,
    this.ident,
    this.namaJalan,
    this.jenisPermukaan,
    this.kondisi,
    this.memilikiSaluran,
    this.jikaAdaSaluran,
    this.jenisSaluran,
    this.kondisiSaluran,
    this.panjangRuas,
    this.lebarRuas,
    this.tebalJalan,
    this.tahunPembuatan,
    this.yangMembangun,
    this.keterangan,
    this.fotoJalan1,
    this.fotoJalan2,
    this.fotoJalan3,
    this.fotoJalan4,
  });

  String provinsi;
  String kabupatenKota;
  String kecamatan;
  String kelurahanDesa;
  String rw;
  String rt;
  String ident;
  String namaJalan;
  String jenisPermukaan;
  String kondisi;
  String memilikiSaluran;
  String jikaAdaSaluran;
  String jenisSaluran;
  String kondisiSaluran;
  String panjangRuas;
  String lebarRuas;
  String tebalJalan;
  String tahunPembuatan;
  String yangMembangun;
  String keterangan;
  String fotoJalan1;
  String fotoJalan2;
  String fotoJalan3;
  String fotoJalan4;

  factory Jalan.fromJson(Map<String, dynamic> json) => Jalan(
    provinsi: json["provinsi"],
    kabupatenKota: json["kabupaten__kota"],
    kecamatan: json["kecamatan"],
    kelurahanDesa: json["kelurahan__desa"],
    rw: json["rw"],
    rt: json["rt"],
    ident: json["ident"],
    namaJalan: json["nama_jalan"],
    jenisPermukaan: json["jenis_permukaan"],
    kondisi: json["kondisi"],
    memilikiSaluran: json["memiliki_saluran"],
    jikaAdaSaluran: json["jika_ada_saluran"],
    jenisSaluran: json["jenis_saluran"],
    kondisiSaluran: json["kondisi_saluran"],
    panjangRuas: json["panjang_ruas"],
    lebarRuas: json["lebar_ruas"],
    tebalJalan: json["tebal_jalan"],
    tahunPembuatan: json["tahun_pembuatan"],
    yangMembangun: json["yang_membangun"],
    keterangan: json["keterangan"],
    fotoJalan1: json["foto_jalan_1"],
    fotoJalan2: json["foto_jalan_2"],
    fotoJalan3: json["foto_jalan_3"],
    fotoJalan4: json["foto_jalan_4"],
  );

  Map<String, dynamic> toJson() => {
    "provinsi": provinsi,
    "kabupaten__kota": kabupatenKota,
    "kecamatan": kecamatan,
    "kelurahan__desa": kelurahanDesa,
    "rw": rw,
    "rt": rt,
    "ident": ident,
    "nama_jalan": namaJalan,
    "jenis_permukaan": jenisPermukaan,
    "kondisi": kondisi,
    "memiliki_saluran": memilikiSaluran,
    "jika_ada_saluran": jikaAdaSaluran,
    "jenis_saluran": jenisSaluran,
    "kondisi_saluran": kondisiSaluran,
    "panjang_ruas": panjangRuas,
    "lebar_ruas": lebarRuas,
    "tebal_jalan": tebalJalan,
    "tahun_pembuatan": tahunPembuatan,
    "yang_membangun": yangMembangun,
    "keterangan": keterangan,
    "foto_jalan_1": fotoJalan1,
    "foto_jalan_2": fotoJalan2,
    "foto_jalan_3": fotoJalan3,
    "foto_jalan_4": fotoJalan4,
  };

  static Map<String, dynamic> toMap(Jalan jalan) => {
    "provinsi": jalan.provinsi,
    "kabupaten__kota": jalan.kabupatenKota,
    "kecamatan": jalan.kecamatan,
    "kelurahan__desa": jalan.kelurahanDesa,
    "rw": jalan.rw,
    "rt": jalan.rt,
    "ident": jalan.ident,
    "nama_jalan": jalan.namaJalan,
    "jenis_permukaan": jalan.jenisPermukaan,
    "kondisi": jalan.kondisi,
    "memiliki_saluran": jalan.memilikiSaluran,
    "jika_ada_saluran": jalan.jikaAdaSaluran,
    "jenis_saluran": jalan.jenisSaluran,
    "kondisi_saluran": jalan.kondisiSaluran,
    "panjang_ruas": jalan.panjangRuas,
    "lebar_ruas": jalan.lebarRuas,
    "tebal_jalan": jalan.tebalJalan,
    "tahun_pembuatan": jalan.tahunPembuatan,
    "yang_membangun": jalan.yangMembangun,
    "keterangan": jalan.keterangan,
    "foto_jalan_1": jalan.fotoJalan1,
    "foto_jalan_2": jalan.fotoJalan2,
    "foto_jalan_3": jalan.fotoJalan3,
    "foto_jalan_4": jalan.fotoJalan4,
  };

  static String encode(List<Jalan> jalans) => json.encode(
    jalans
        .map<Map<String, dynamic>>((jalan) => Jalan.toMap(jalan))
        .toList(),
  );

  static List<Jalan> decode(String jalans) =>
      (json.decode(jalans) as List<dynamic>)
          .map<Jalan>((item) => Jalan.fromJson(item))
          .toList();
}
