import 'dart:convert';
import 'package:dio/dio.dart';

Future<void> sendMsgApi(String title,String body) async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'key=AAAAWTBU6xM:APA91bFtSJ2z8v9FCrkMJXaO54bzuxgHKBbU57_nGlVEm2_7fBMfJHvL2CgeooBx9x68HxMuIF2kojwbh9RrHYfu9gpEaq3KOGi6YnaneDBJ9N-A7qvFusqzsKT9wIRK3i-iIaxQ8-0E'
  };
  var data = json.encode({
    "to":
        "ceK1HdXCTYqrdixRFskBdo:APA91bHBeAigbdPQkaizWFHiAGdPy1cCTUqzeNpRRO07hsyzeD-iyzeptAVv2IFv-9ViMubjaXA-w0zkXmZ11kTWQFf8CNHiNUycl_R3YE9qaXOapMjWAfU6Gg0_9fmPNIgWqkEOsUeJ",
    "notification": {
      "title": title,
      "body":body,
      "mutable_content": true,
      "sound": "Tri-tone"
    }
  });
  var dio = Dio();
  var response = await dio.request(
    'https://fcm.googleapis.com/fcm/send?api_key=784dea264f57cabb19cdc02f92e2c63c',
    options: Options(
      method: 'POST',
      headers: headers,
    ),
    data: data,
  );

  if (response.statusCode == 200) {
    print(json.encode(response.data));
  } else {
    print(response.statusMessage);
  }
}
