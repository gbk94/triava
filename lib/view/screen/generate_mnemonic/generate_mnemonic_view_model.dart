import 'dart:math';

import 'package:http/http.dart';
import 'package:trivia/data/local/shared_constants.dart';
import 'package:trivia/data/local/shared_prefs.dart';
import 'package:trivia/route/routes.dart';
import 'package:trivia/utils/wallet_creation.dart';
import 'package:trivia/view/common/base_view_model.dart';
import 'package:web3dart/web3dart.dart';

class GenerateMnemonicViewModel extends BaseViewModel {
  var mnemonic = "";

  init() async {
    WalletAddress walletAddress = WalletAddress();
    mnemonic = walletAddress.generateMnemonic();
  }

  Future<void> createWallet() async {
    WalletAddress walletAddress = WalletAddress();
    String privateKey = await walletAddress.getPrivateKey(mnemonic);
    SharedPrefs.instance.set(SharedConstants.privateKey, privateKey);

    navigate(Routes.mainTab);
  }
}
