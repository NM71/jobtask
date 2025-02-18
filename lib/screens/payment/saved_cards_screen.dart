import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobtask/models/saved_card.dart';
import 'package:jobtask/screens/payment/add_card_screen.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/custom_snackbar.dart';

class SavedCardsScreen extends StatefulWidget {
  const SavedCardsScreen({super.key});

  @override
  _SavedCardsScreenState createState() => _SavedCardsScreenState();
}

class _SavedCardsScreenState extends State<SavedCardsScreen> {
  List<SavedCard> _cards = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  // Load Cards method
  Future<void> _loadCards() async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'auth_token');

      if (token != null) {
        final cardsData = await ApiService.getSavedCards(token);
        setState(() {
          _cards = cardsData; // Using the List<SavedCard>
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
      CustomSnackbar.show(
        context: context,
        message: 'Failed to load saved cards',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Cards'),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _cards.isEmpty
              ? _buildEmptyState()
              : _buildCardsList(),
      floatingActionButton: _cards.length < 5
          ? FloatingActionButton(
              onPressed: () => _navigateToAddCard(),
              backgroundColor: Color(0xff3c76ad),
              child: Icon(Icons.add),
            )
          : null,
    );
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
            'No saved cards',
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
          SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff3c76ad),
              minimumSize: Size(200, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: _navigateToAddCard,
            child: Text(
              'Add New Card',
              style: TextStyle(color: Colors.white),
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
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          child: ListTile(
            leading: _getCardIcon(card.brand),
            title: Text('•••• ${card.last4}'),
            subtitle: Text('Expires ${card.expMonth}/${card.expYear}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (card.isDefault)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xff3c76ad),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Default',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    if (!card.isDefault)
                      PopupMenuItem(
                        value: 'default',
                        child: Text('Set as Default'),
                      ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                  onSelected: (value) async {
                    if (value == 'default') {
                      await _setDefaultCard(card.id);
                    } else if (value == 'delete') {
                      await _deleteCard(card.id);
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getCardIcon(String brand) {
    // Implement card brand icons
    return Icon(Icons.credit_card);
  }

  Future<void> _setDefaultCard(int cardId) async {
    try {
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: 'auth_token');

      if (token != null) {
        await ApiService.updateDefaultCard(token, cardId);
        await _loadCards();
      }
    } catch (e) {
      CustomSnackbar.show(
        context: context,
        message: 'Failed to update default card',
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
      }
    } catch (e) {
      CustomSnackbar.show(
        context: context,
        message: 'Failed to delete card',
      );
    }
  }

  void _navigateToAddCard() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCardScreen()),
    );

    if (result == true) {
      _loadCards();
    }
  }
}
