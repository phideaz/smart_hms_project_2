import 'dart:convert';

class Sanitasi {
  Sanitasi({
    this.provinsi,
    this.kabupatenKota,
    this.kecamatan,
    this.kelurahanDesa,
    this.rw,
    this.rt,
    this.jumlahKamarMandiWc,
    this.namaKkPemilikRumah,
    this.fasilitasSanitasi,
    this.bangunanAtas,
    this.bangunanBawah,
    this.pembuanganAirLimbahRt,
    this.pembuanganSampahRt,
    this.fotoSanitasi1,
    this.fotoSanitasi2,
    this.fotoSanitasi3,
    this.fotoSaranaPersampahan1,
  });

  String provinsi;
  String kabupatenKota;
  String kecamatan;
  String kelurahanDesa;
  String rw;
  String rt;
  String jumlahKamarMandiWc;
  String namaKkPemilikRumah;
  String fasilitasSanitasi;
  String bangunanAtas;
  String bangunanBawah;
  String pembuanganAirLimbahRt;
  String pembuanganSampahRt;
  String fotoSanitasi1;
  String fotoSanitasi2;
  String fotoSanitasi3;
  String fotoSaranaPersampahan1;

  factory Sanitasi.fromJson(Map<String, dynamic> json) => Sanitasi(
    provinsi: json["provinsi"],
    kabupatenKota: json["kabupaten__kota"],
    kecamatan: json["kecamatan"],
    kelurahanDesa: json["kelurahan__desa"],
    rw: json["rw"],
    rt: json["rt"],
    jumlahKamarMandiWc: json["jumlah_kamar_mandi__wc"],
    namaKkPemilikRumah: json["nama_kk__pemilik_rumah"],
    fasilitasSanitasi: json["fasilitas_sanitasi"],
    bangunanAtas: json["bangunan_atas"],
    bangunanBawah: json["bangunan_bawah"],
    pembuanganAirLimbahRt: json["pembuangan_air_limbah_rt"],
    pembuanganSampahRt: json["pembuangan_sampah_rt"],
    fotoSanitasi1: json["foto_sanitasi_1"],
    fotoSanitasi2: json["foto_sanitasi_2"],
    fotoSanitasi3: json["foto_sanitasi_3"],
    fotoSaranaPersampahan1: json["foto_sarana_persampahan_1"],
  );

  Map<String, dynamic> toJson() => {
    "provinsi": provinsi,
    "kabupaten__kota": kabupatenKota,
    "kecamatan": kecamatan,
    "kelurahan__desa": kelurahanDesa,
    "rw": rw,
    "rt": rt,
    "jumlah_kamar_mandi__wc": jumlahKamarMandiWc,
    "nama_kk__pemilik_rumah": namaKkPemilikRumah,
    "fasilitas_sanitasi": fasilitasSanitasi,
    "bangunan_atas": bangunanAtas,
    "bangunan_bawah": bangunanBawah,
    "pembuangan_air_limbah_rt": pembuanganAirLimbahRt,
    "pembuangan_sampah_rt": pembuanganSampahRt,
    "foto_sanitasi_1": fotoSanitasi1,
    "foto_sanitasi_2": fotoSanitasi2,
    "foto_sanitasi_3": fotoSanitasi3,
    "foto_sarana_persampahan_1": fotoSaranaPersampahan1,
  };

  static Map<String, dynamic> toMap(Sanitasi sanitasi) => {
    "provinsi": sanitasi.provinsi,
    "kabupaten__kota": sanitasi.kabupatenKota,
    "kecamatan": sanitasi.kecamatan,
    "kelurahan__desa": sanitasi.kelurahanDesa,
    "rw": sanitasi.rw,
    "rt": sanitasi.rt,
    "jumlah_kamar_mandi__wc": sanitasi.jumlahKamarMandiWc,
    "nama_kk__pemilik_rumah": sanitasi.namaKkPemilikRumah,
    "fasilitas_sanitasi": sanitasi.fasilitasSanitasi,
    "bangunan_atas": sanitasi.bangunanAtas,
    "bangunan_bawah": sanitasi.bangunanBawah,
    "pembuangan_air_limbah_rt": sanitasi.pembuanganAirLimbahRt,
    "pembuangan_sampah_rt": sanitasi.pembuanganSampahRt,
    "foto_sanitasi_1": sanitasi.fotoSanitasi1,
    "foto_sanitasi_2": sanitasi.fotoSanitasi2,
    "foto_sanitasi_3": sanitasi.fotoSanitasi3,
    "foto_sarana_persampahan_1": sanitasi.fotoSaranaPersampahan1,
  };

  static String encode(List<Sanitasi> sanitasis) => json.encode(
    sanitasis
        .map<Map<String, dynamic>>((sanitasi) => Sanitasi.toMap(sanitasi))
        .toList(),
  );

  static List<Sanitasi> decode(String sanitasis) =>
      (json.decode(sanitasis) as List<dynamic>)
          .map<Sanitasi>((item) => Sanitasi.fromJson(item))
          .toList();
}
