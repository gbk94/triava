import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:trivia/data/local/shared_prefs.dart';
import 'package:trivia/data/networking/endpoints.dart';
import 'package:web3dart/credentials.dart';

class RestService {
  late BaseOptions baseOptions;
  late Dio client;

  RestService() {}

  Future<Dio> getClient() async {
    EthPrivateKey credentials =
        EthPrivateKey.fromHex(SharedPrefs.instance.privateKey);
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    List<int> list = timeStamp.codeUnits;
    Uint8List bytes = Uint8List.fromList(list);
    final signedSecondary = await credentials.signPersonalMessage(bytes);
    var resultSeconday = hex.encode(signedSecondary);

    baseOptions = BaseOptions(
      baseUrl: Endpoints.baseUrl,
      headers: <String, dynamic>{
        HttpHeaders.acceptHeader: "application/json",
        'pure-message': timeStamp,
        'signed-message': resultSeconday
      },
    );
    client = Dio(baseOptions);
    return client;
  }
}
