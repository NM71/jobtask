import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/models/saved_card.dart';
import 'package:jobtask/screens/payment/add_card_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/custom_snackbar.dart';
import 'package:jobtask/utils/payment_card_widget.dart';

class PaymentInformationScreen extends StatefulWidget {
  const PaymentInformationScreen({super.key});

  @override
  _PaymentInformationScreenState createState() =>
      _PaymentInformationScreenState();
}

class _PaymentInformationScreenState extends State<PaymentInformationScreen> {
  List<SavedCard> _cards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  Future<void> _loadCards() async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'auth_token');

      if (token != null) {
        final cardsData = await ApiService.getSavedCards(token);
        if (mounted) {
          setState(() {
            _cards = cardsData;
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        CustomSnackbar.show(
          context: context,
          message: 'Failed to load payment methods',
        );
      }
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.credit_card,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No Payment Methods',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add a card to make faster payments',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardsList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _cards.length,
      itemBuilder: (context, index) {
        final card = _cards[index];
        return GestureDetector(
          onTap: () => _showCardOptions(card),
          child: PaymentCardWidget(
            cardBrand: card.brand,
            last4: card.last4,
            expiryMonth: card.expMonth.toString(),
            expiryYear: card.expYear.toString(),
            isDefault: card.isDefault,
            cardholderName: card.cardholderName,
            createdAt: card.createdAt,
            billingAddress: card.billingAddress,
          ),
        );
      },
    );
  }

  Future<void> _showCardOptions(SavedCard card) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            if (!card.isDefault)
              ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('Set as Default'),
                onTap: () async {
                  Navigator.pop(context);
                  await _setDefaultCard(card.id);
                },
              ),
            ListTile(
              leading: Icon(Icons.delete_outline, color: Colors.red),
              title: Text('Remove Card', style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                await _deleteCard(card.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setDefaultCard(int cardId) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'auth_token');

      if (token != null) {
        await ApiService.updateDefaultCard(token, cardId);
        await _loadCards();

        if (mounted) {
          CustomSnackbar.show(
            context: context,
            message: 'Default payment method updated',
          );
        }
      }
    } catch (e) {
      CustomSnackbar.show(
        context: context,
        message: 'Failed to update default payment method',
      );
    }
  }

  Future<void> _deleteCard(int cardId) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'auth_token');

      if (token != null) {
        await ApiService.deleteCard(token, cardId);
        await _loadCards();

        if (mounted) {
          CustomSnackbar.show(
            context: context,
            message: 'Card removed successfully',
          );
        }
      }
    } catch (e) {
      CustomSnackbar.show(
        context: context,
        message: 'Failed to remove card',
      );
    }
  }

  Future<void> _addNewCard() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCardScreen()),
    );

    if (result == true) {
      _loadCards();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text('Payment Methods'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3c76ad)),
            ))
          : Column(
              children: [
                Expanded(
                  child:
                      _cards.isEmpty ? _buildEmptyState() : _buildCardsList(),
                ),
                if (_cards.length < 5)
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff3c76ad),
                        minimumSize: Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _addNewCard,
                      child: Text(
                        'Add New Card',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
