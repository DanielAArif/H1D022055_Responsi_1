import 'dart:convert';
import '/helpers/api.dart';
import '/helpers/api_url.dart';
import '/model/pemandu_wisata.dart';

class PemanduWisataBloc {
  static Future<List<PemanduWisata>> getPemanduWisatas() async {
    String apiUrl = ApiUrl.listPemanduWisata;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listPemanduWisata = (jsonObj as Map<String, dynamic>)['data'];
    List<PemanduWisata> pemanduWisatas = [];
    for (int i = 0; i < listPemanduWisata.length; i++) {
      pemanduWisatas.add(PemanduWisata.fromJson(listPemanduWisata[i]));
    }
    return pemanduWisatas;
  }

  static Future addPemanduWisata({PemanduWisata? pemanduWisata}) async {
    String apiUrl = ApiUrl.createPemanduWisata;
    var body = {
      "guide": pemanduWisata!.guide,
      "languages": pemanduWisata.languages,
      "rating": pemanduWisata.rating.toString()
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updatePemanduWisata(
      {required PemanduWisata pemanduWisata}) async {
    String apiUrl = ApiUrl.updatePemanduWisata(pemanduWisata.id!);
    print(apiUrl);
    var body = {
      "guide": pemanduWisata.guide,
      "languages": pemanduWisata.languages,
      "rating": pemanduWisata.rating
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deletePemanduWisata({int? id}) async {
    String apiUrl = ApiUrl.deletePemanduWisata(id!);
    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
