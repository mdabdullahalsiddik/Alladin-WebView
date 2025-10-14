import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class WebStatusService {
  static Future<bool> service() async {
    try {
      var url = Uri.parse("https://naturaldpl.com/check-api-status");
      log("Checking API status at: $url");

      var headers = {'Accept': 'application/json', 'Content-Type': 'application/json'};

      var response = await http.get(url, headers: headers);
      log("Response: ${response.body}");

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        // The API returns { "status": true }
        return jsonData['status'] ?? false;
      } else {
        log("Error: Failed to check API status. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      log('Exception while checking API status: $e');
      return false;
    }
  }
}
