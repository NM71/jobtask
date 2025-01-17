import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/models/saved_card.dart';
import 'package:jobtask/screens/payment/add_card_screen.dart';
import 'package:jobtask/services/api_service.dart';

class PaymentSelectionSheet extends StatefulWidget {
  final String? initialPaymentMethod;

  const PaymentSelectionSheet({super.key, this.initialPaymentMethod});

  @override
  _PaymentSelectionSheetState createState() => _PaymentSelectionSheetState();
}

class _PaymentSelectionSheetState extends State<PaymentSelectionSheet> {
  String? selectedMethod;
  List<SavedCard> savedCards = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    selectedMethod = widget.initialPaymentMethod;
    _loadSavedCards();
  }

  Future<void> _loadSavedCards() async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'auth_token');

      if (token != null) {
        final cardsData = await ApiService.getSavedCards(token);
        setState(() {
          savedCards = cardsData; // Using List<SavedCard>
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Select Payment Method',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          if (isLoading)
            Center(child: CircularProgressIndicator())
          else if (savedCards.isEmpty)
            _buildAddFirstCard()
          else
            ..._buildPaymentOptions(),
          SizedBox(height: 20),
          if (savedCards.isNotEmpty)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff3c76ad),
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: selectedMethod != null
                    ? () => Navigator.pop(context, selectedMethod)
                    : null,
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAddFirstCard() {
    return Column(
      children: [
        Text(
          'No cards saved yet',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff3c76ad),
              minimumSize: Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCardScreen()),
              );

              if (result == true) {
                await _loadSavedCards();
              }
            },
            child: Text(
              'Add New Card',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPaymentOptions() {
    List<Widget> options = [];

    // Add saved cards
    for (var card in savedCards) {
      options.add(
        RadioListTile<String>(
          value: 'card_${card.id}',
          groupValue: selectedMethod,
          onChanged: (value) => setState(() => selectedMethod = value),
          title: Row(
            children: [
              _getCardBrandIcon(card.brand),
              SizedBox(width: 8),
              Text('•••• ${card.last4}'),
              if (card.isDefault)
                Container(
                  margin: EdgeInsets.only(left: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Color(0xff3c76ad),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Default',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
            ],
          ),
          subtitle: Text('Expires ${card.expMonth}/${card.expYear}'),
        ),
      );
    }

    // Add new card option if less than 5 cards
    if (savedCards.length < 5) {
      options.add(
        ListTile(
          leading: Icon(Icons.add),
          title: Text('Add New Card'),
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddCardScreen()),
            );

            if (result == true) {
              await _loadSavedCards();
            }
          },
        ),
      );
    }

    return options;
  }

  Widget _getCardBrandIcon(String brand) {
    IconData iconData;
    switch (brand.toLowerCase()) {
      case 'visa':
        iconData = Icons.payment;
        break;
      case 'mastercard':
        iconData = Icons.credit_card;
        break;
      case 'amex':
        iconData = Icons.credit_card;
        break;
      default:
        iconData = Icons.credit_card;
    }
    return Icon(iconData);
  }
}
