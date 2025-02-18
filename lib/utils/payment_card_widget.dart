import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jobtask/models/billing_address.dart';

class PaymentCardWidget extends StatefulWidget {
  final String cardBrand;
  final String last4;
  final String expiryMonth;
  final String expiryYear;
  final bool isDefault;
  final String cardholderName;
  final String createdAt;
  final BillingAddress billingAddress;

  const PaymentCardWidget({
    super.key,
    required this.cardBrand,
    required this.last4,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cardholderName,
    required this.createdAt,
    required this.billingAddress,
    this.isDefault = false,
  });

  @override
  State<PaymentCardWidget> createState() => _PaymentCardWidgetState();
}

class _PaymentCardWidgetState extends State<PaymentCardWidget> {
  bool _showDetails = false;

  String getCardBrandLogo() {
    switch (widget.cardBrand.toLowerCase()) {
      case 'visa':
        return 'assets/icons/visa.svg';
      case 'mastercard':
        return 'assets/icons/mastercard.svg';
      case 'amex':
        return 'assets/icons/amex.svg';
      default:
        return 'assets/icons/generic_card.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff3c76ad), Color(0xff2c5a8f)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      getCardBrandLogo(),
                      colorFilter:
                          ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      height: 40,
                      width: 60,
                    ),
                    Row(
                      children: [
                        if (widget.isDefault)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Default',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        SizedBox(width: 8),
                        IconButton(
                          icon: Icon(
                            _showDetails
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _showDetails = !_showDetails;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  widget.cardholderName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: Text(
                    '•••• •••• •••• ${widget.last4}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expiry Date',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${widget.expiryMonth}/${widget.expiryYear}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (_showDetails) ...[
                  SizedBox(height: 16),
                  Divider(color: Colors.white.withOpacity(0.2)),
                  SizedBox(height: 16),
                  Text(
                    'Billing Address',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${widget.billingAddress.address1}\n${widget.billingAddress.city}, ${widget.billingAddress.state} ${widget.billingAddress.postcode}\n${widget.billingAddress.country}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Added on ${DateFormat('MMM dd, yyyy').format(DateTime.parse(widget.createdAt))}',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
