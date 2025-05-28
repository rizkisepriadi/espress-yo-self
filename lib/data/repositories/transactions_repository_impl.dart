import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:espress_yo_self/domain/entities/transactions_entitty.dart';
import 'package:espress_yo_self/domain/repositories/transactions_repository.dart';
import 'package:espress_yo_self/data/models/transactions/transactions_model.dart';
import 'package:espress_yo_self/utils/safe_call.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  final _firestore = FirebaseFirestore.instance;
  final _transactionsCollection = 'transactions';
  final _rewardsCollection = 'rewards';

  @override
  Future<void> addTransactionFromQR({
    required String userId,
    required String qrData,
  }) {
    return safeCall(() async {
      final parsedData = _parseQRData(qrData);

      final productDoc = await _firestore
          .collection(_rewardsCollection)
          .doc(parsedData['productId'])
          .get();
      final productInfo = productDoc.exists
          ? productDoc.data()
          : _getProductInfo(parsedData['product']);

      final isEcoFriendly = _checkEcoFriendlyPurchase(parsedData);
      final basePoints = _calculatePoints(parsedData['amount']);
      final ecoBonus = isEcoFriendly ? (basePoints * 0.5).round() : 0;
      final totalPoints = basePoints + ecoBonus;

      final docRef = _firestore.collection(_transactionsCollection).doc();

      await docRef.set({
        'id': docRef.id,
        'user_id': userId,
        'time_stamp': DateTime.now().toIso8601String(),
        'points_earned': totalPoints,
        'eco_points_bonus': ecoBonus,
        'is_eco_friendly': isEcoFriendly,
        'transaction_type': 'qr_scan',
        'title':
            isEcoFriendly ? 'Eco-Friendly Coffee Purchase' : 'Coffee Purchase',
        'description': '${parsedData['product']} x${parsedData['quantity']}',
        'amount': parsedData['amount'],
        'image_250_url':
            productInfo?['image_250_url'] ?? 'assets/svgs/menu_default.svg',
        'image_url':
            productInfo?['image_url'] ?? 'assets/svgs/menu_default.svg',
      });
    }, label: 'addTransactionFromQR');
  }

  bool _checkEcoFriendlyPurchase(Map<String, dynamic> parsedData) {
    final productName = parsedData['product'].toLowerCase();

    final ecoKeywords = [
      'organic',
      'fair trade',
      'sustainable',
      'reusable cup',
      'plant-based',
      'eco',
      'green'
    ];

    return ecoKeywords.any((keyword) => productName.contains(keyword));
  }

  Map<String, dynamic> _parseQRData(String qrData) {
    final parts = qrData.split('|');
    if (parts.length < 5 || parts[0] != 'RECEIPT') {
      throw Exception('Invalid QR format');
    }

    return {
      'productId': parts[1],
      'product': parts[2],
      'amount': double.parse(parts[3]),
      'quantity': int.parse(parts[4]),
    };
  }

  Map<String, dynamic> _getProductInfo(String productName) {
    final lowerName = productName.toLowerCase();

    final productMap = {
      'Black Coffee': {'category': 'coffee'},
      'Cappuccino': {'category': 'coffee'},
      'Organic Fair Trade Coffee': {'category': 'eco_coffee'},
      'Sustainable Cold Brew': {'category': 'eco_coffee'},
      'Plant-Based Latte': {'category': 'eco_coffee'},
      'Iced Cold Brew with Cream': {'category': 'cold_coffee'},
      'Iced Coffee Swirl': {'category': 'cold_coffee'},
      'Rose Latte': {'category': 'coffee'},
      'Classic Cold Brew': {'category': 'coffee'},
      'Java Chip Frappuccino': {'category': 'coffee'},
    };

    for (final key in productMap.keys) {
      if (lowerName.contains(key)) {
        return productMap[key]!;
      }
    }

    return {
      'category': 'coffee',
    };
  }

  int _calculatePoints(double amount) {
    return (amount / 1000).floor();
  }

  @override
  Future<void> addTransaction(String userId, int points) {
    return safeCall(() async {
      final docRef = _firestore.collection(_transactionsCollection).doc();
      await docRef.set({
        'id': docRef.id,
        'user_id': userId,
        'time_stamp': DateTime.now().toIso8601String(),
        'points_earned': points,
        'transaction_type': 'manual',
        'title': 'Points Added',
        'description': 'Manual points addition',
        'is_eco_friendly': false,
        'eco_points_bonus': 0,
      });
    }, label: 'addTransaction');
  }

  @override
  Future<void> addDetailedTransaction({
    required String userId,
    required int points,
    required String transactionType,
    required String title,
    required String description,
    String? orderId,
    String? rewardId,
    double? amount,
    String? imageUrl,
    String? image250Url,
    bool isEcoFriendly = false,
    int ecoPointsBonus = 0,
  }) {
    return safeCall(() async {
      final docRef = _firestore.collection(_transactionsCollection).doc();
      await docRef.set({
        'id': docRef.id,
        'user_id': userId,
        'time_stamp': DateTime.now().toIso8601String(),
        'points_earned': points,
        'transaction_type': transactionType,
        'title': title,
        'description': description,
        'order_id': orderId,
        'reward_id': rewardId,
        'amount': amount,
        'image_url': imageUrl,
        'image_250_url': image250Url,
        'is_eco_friendly': isEcoFriendly,
        'eco_points_bonus': ecoPointsBonus,
      });
    }, label: 'addDetailedTransaction');
  }

  @override
  Future<List<TransactionsEntitty>> getUserTransactions(String userId) {
    return safeCall(() async {
      final query = await _firestore
          .collection(_transactionsCollection)
          .where('user_id', isEqualTo: userId)
          .orderBy('time_stamp', descending: true)
          .get();

      return query.docs.map((doc) {
        final data = doc.data();
        return TransactionsModel.fromJson(data).toEntity();
      }).toList();
    }, label: 'getUserTransactions');
  }

  @override
  Future<TransactionsEntitty> getTransactions() {
    return safeCall(() async {
      final query =
          await _firestore.collection(_transactionsCollection).limit(1).get();
      if (query.docs.isEmpty) {
        throw Exception('No transactions found');
      }
      final data = query.docs.first.data();
      final model = TransactionsModel.fromJson(data);
      return model.toEntity();
    }, label: 'getTransactions');
  }
}
