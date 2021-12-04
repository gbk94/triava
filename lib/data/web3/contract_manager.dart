import 'dart:math';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../local/shared_prefs.dart';

class ContractManager {
  static const contractAddress = "0x74A9CF88B46c195Bf3F094CF98BD78173FC49448";

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

  static Future<String> submitTransactionPayable(
      String functionName, List<dynamic> args, BigInt value) async {
    EthPrivateKey credentials =
        EthPrivateKey.fromHex(SharedPrefs.instance.privateKey);
    DeployedContract contract = await loadContract();
    var apiUrl = "https://api.avax-test.network/ext/bc/C/rpc";
    final ethFunction = contract.function(functionName);
    var httpClient = Client();
    var ethClient = Web3Client(apiUrl, httpClient);
    var result = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
          contract: contract,
          function: ethFunction,
          parameters: args,
          value: EtherAmount.fromUnitAndValue(EtherUnit.wei, value),
        ),
        chainId: 43113);
    print(result);
    return result;
  }

  static Future<String> submitTransaction(
      String functionName, List<dynamic> args) async {
    EthPrivateKey credentials =
        EthPrivateKey.fromHex(SharedPrefs.instance.privateKey);
    DeployedContract contract = await loadContract();
    var apiUrl = "https://api.avax-test.network/ext/bc/C/rpc";
    final ethFunction = contract.function(functionName);
    var httpClient = Client();
    var ethClient = Web3Client(apiUrl, httpClient);
    var result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
          contract: contract, function: ethFunction, parameters: args),
      chainId: 43113,
    );
    print(result);
    return result;
  }

  static double weiToAvax(dynamic data) {
    final wei = data as BigInt;
    final avax = wei.toDouble() / pow(10, 18);
    return avax;
  }

  static BigInt avaxToWei(dynamic data) {
    final avax = double.parse(data);
    final wei = BigInt.from(avax.toDouble() * pow(10, 18));
    return wei;
  }
}
