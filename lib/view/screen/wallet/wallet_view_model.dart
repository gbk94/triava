import 'package:trivia/data/local/shared_prefs.dart';
import 'package:trivia/data/web3/contract_manager.dart';
import 'package:trivia/data/web3/eth_client.dart';
import 'package:trivia/utils/wallet_creation.dart';
import 'package:trivia/view/common/base_view_model.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';

class WalletViewModel extends BaseViewModel {
  var address = "";
  var balance = "0";
  var minValidatorAvax = "";
  var minCreatorAvax = "";
  var validatorStaking = "0";
  var creatorStaking = "0";

  Future<void> init() async {
    flow(() async {
      await Future.wait([
        getPublickey(),
        getBalance(),
        getCreateAmount(),
        getValidateAmount(),
        getStaking(),
      ]);
      notify();
    });
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
    balance = ContractManager.weiToAvax(avaxBalance.getInWei).toString();
    notify();
    // print(ethClient.getGasPrice().toString());
    // EtherAmount etherAmount = await ethClient.getBalance(publicKey);
  }

  Future<void> getValidateAmount() async {
    List<dynamic> data = await ContractManager.query("minValidatorStaking", []);
    minValidatorAvax = ContractManager.weiToAvax(data[0]).toString();
    notify();
  }

  Future<void> getCreateAmount() async {
    List<dynamic> data = await ContractManager.query("minCreatorStaking", []);
    minCreatorAvax = ContractManager.weiToAvax(data[0]).toString();
    notify();
  }

  Future<void> getStaking() async {
    WalletAddress walletAddress = WalletAddress();
    EthereumAddress publicKey =
        await walletAddress.getPublicKey(SharedPrefs.instance.privateKey);

    List<dynamic> data =
        await ContractManager.query("creatorStakings", [publicKey]);
    print('data ${data[0]}');
    final creatorStakingRes = ContractManager.weiToAvax(data[0]);
    creatorStaking = creatorStakingRes.toString();
    List<dynamic> dataVal =
        await ContractManager.query("validatorStakings", [publicKey]);

    print('dataVal ${dataVal[0]}');
    final validatorStakingRes = ContractManager.weiToAvax(dataVal[0]);
    validatorStaking = validatorStakingRes.toString();
    notify();
  }

  Future<void> stakeForCreator() async {
    flow(() async {
      final valx = ContractManager.avaxToWei(minCreatorAvax);
      await ContractManager.submitTransactionPayable("creatorStake", [], valx);
      getStaking();
    });
  }

  Future<void> stakeForValidator() async {
    flow(() async {
      final valx = ContractManager.avaxToWei(minValidatorAvax);
      await ContractManager.submitTransactionPayable(
          "validatorStake", [], valx);
      getStaking();
    });
  }
}
