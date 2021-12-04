import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

var apiUrl =
    "https://api.avax-test.network/ext/bc/C/rpc"; //Replace with your API

var httpClient = Client();
var ethClient = Web3Client(apiUrl, httpClient);
