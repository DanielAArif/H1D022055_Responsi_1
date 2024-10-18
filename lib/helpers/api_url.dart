class ApiUrl {
  static const String baseUrl =
      'http://103.196.155.42/api/pariwisata/pemandu_wisata';
  static const String registrasi = 'http://103.196.155.42/api/registrasi';
  static const String login = 'http://103.196.155.42/api/login';

  static const String listPemanduWisata = 'http://103.196.155.42/api/pariwisata/pemandu_wisata';
  static const String createPemanduWisata = 'http://103.196.155.42/api/pariwisata/pemandu_wisata';

  static String updatePemanduWisata(int id) {
    return 'http://103.196.155.42/api/pariwisata/pemandu_wisata/' + id.toString() + '/update';
  }

  static String showPemanduWisata(int id) {
    return 'http://103.196.155.42/api/pariwisata/pemandu_wisata/' + id.toString();
  }

  static String deletePemanduWisata(int id) {
    return 'http://103.196.155.42/api/pariwisata/pemandu_wisata/' + id.toString() + '/delete';
  }
}
