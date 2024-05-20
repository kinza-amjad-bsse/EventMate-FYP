import 'transactions_model/transactions_model.dart';

class WalletModel {
  String depositAmount, earnedAmount, withdrawnAmount;
  List<TransactionModel> transactions;

  WalletModel({
    required this.depositAmount,
    required this.earnedAmount,
    required this.withdrawnAmount,
    required this.transactions,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      depositAmount: json['deposit_amount'],
      earnedAmount: json['earned_amount'],
      withdrawnAmount: json['withdrawn_amount'],
      transactions: json.containsKey("transactions")
          ? List<TransactionModel>.from(
              json["transactions"].map(
                (x) => TransactionModel.fromJson(x),
              ),
            ).reversed.toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'deposit_amount': depositAmount,
      'earned_amount': earnedAmount,
      'withdrawn_amount': withdrawnAmount,
      'transactions': List<dynamic>.from(
        transactions.map(
          (x) => x.toJson(),
        ),
      ),
    };
  }
}
