import 'package:trivia/view/common/base_view_model.dart';

import 'package:trivia/data/local/shared_prefs.dart';
import 'package:trivia/data/web3/contract_manager.dart';
import 'package:trivia/data/web3/eth_client.dart';
import 'package:trivia/utils/wallet_creation.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class CreateEarnViewModel extends BaseViewModel {
  var address = "";
  var balance = "0";

  Future<void> init() async {
    await Future.wait([
      getPublickey(),
      getBalance(),
    ]);
    notify();
  }

  Future<void> getPublickey() async {
    WalletAddress walletAddress = WalletAddress();
    EthereumAddress publicKey =
        await walletAddress.getPublicKey(SharedPrefs.instance.privateKey);
    address = publicKey.toString();
    notify();
  }

  Future<void> getBalance() async {
    WalletAddress walletAddress = WalletAddress();
    EthereumAddress publicKey =
        await walletAddress.getPublicKey(SharedPrefs.instance.privateKey);

    final avaxBalance = await ethClient.getBalance(publicKey);
    balance = avaxBalance.getInEther.toString();
    notify();
    // print(ethClient.getGasPrice().toString());
    // EtherAmount etherAmount = await ethClient.getBalance(publicKey);
  }
}
