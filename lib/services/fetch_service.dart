import 'dart:convert';

import 'package:http/http.dart' as http;

class FetchService {
  Future<Map<String, dynamic>> getPackage(String packageID) async {
    final req = await http.get(Uri.parse('http://api.scraperapi.com/?api_key=a52aa9b2675afdb67814ebe5ad6e8228&url=https://global.cainiao.com/global/detail.json?mailNos=$packageID&lang=pt-BR&language=pt-BR'));
    
    return json.decode(req.body)['module'][0];
  }
}
