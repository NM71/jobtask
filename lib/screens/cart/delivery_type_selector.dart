import 'package:flutter/material.dart';

class DeliveryTypeSelector extends StatelessWidget {
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
        children: [
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Color(0xff3c76ad),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            'Select Delivery Type',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          _buildDeliveryOption(
            context,
            'Standard Delivery',
            'Free • 3-5 business days',
            Icons.local_shipping_outlined,
            'standard',
          ),
          Divider(height: 1),
          _buildDeliveryOption(
            context,
            'Express Delivery',
            '\$9.99 • 1-2 business days',
            Icons.delivery_dining_outlined,
            'express',
          ),
          Divider(height: 1),
          _buildDeliveryOption(
            context,
            'Same Day Delivery',
            '\$14.99 • Delivered today',
            Icons.rocket_launch_outlined,
            'same_day',
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOption(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    String value,
  ) {
    return InkWell(
      onTap: () => Navigator.pop(context, value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: Color(0xff3c76ad),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
