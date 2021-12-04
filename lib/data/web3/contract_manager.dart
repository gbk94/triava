import 'dart:math';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class ContractManager {
  static const contractAddress = "0xb31EFEB6B13FD966126f41F3F3340501b985A28c";

  static Future<DeployedContract> loadContract() async {
    String abiCode = await rootBundle.loadString("assets/abi.json");

    final contract = DeployedContract(ContractAbi.fromJson(abiCode, "MetaCoin"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  static Future<List<dynamic>> query(
      String functionName, List<dynamic> args) async {
    final contract = await loadContract();
    final ethFunction = contract.function(functionName);

    var apiUrl =
        "https://api.avax-test.network/ext/bc/C/rpc"; //Replace with your API

    var httpClient = Client();
    var ethClient = Web3Client(apiUrl, httpClient);

    final data = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    print(data);
    return data;
  }

  static double weiToAvax(dynamic data) {
    final wei = data as BigInt;
    final avax = wei.toDouble() / pow(10, 18);
    return avax;
  }
}
