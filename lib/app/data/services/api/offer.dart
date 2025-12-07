import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:wajibmotors/app/data/model/offer.dart';

class OfferService {
  static Future<List<OfferModel>> service() async {
    try {
      var url = Uri.parse("https://naturaldpl.com/service-api");
      log("url: $url");

      var headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};

      var response = await http.get(url, headers: headers);
      log("=====All User Notification Service URL : $url ======");
      log("=====All User Notification Service Response : ${response.body} ======");
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var decodedData = jsonData["data"];
        if (decodedData != null) {
          List<OfferModel> decodeDataList = [];
          for (var i in decodedData) {
            var a = OfferModel.fromJson(i);

            decodeDataList.add(a);
          }
          return decodeDataList;
        } else {
          return [];
        }
      } else {
        log("Error: Failed to retrieve checklist. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      log('Exception: $e');
    }
    return [];
  }
}
