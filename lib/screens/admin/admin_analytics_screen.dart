//----------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:jobtask/services/admin_api_service.dart';
// import 'package:intl/intl.dart';

// class AdminAnalyticsScreen extends StatefulWidget {
//   @override
//   _AdminAnalyticsScreenState createState() => _AdminAnalyticsScreenState();
// }

// class _AdminAnalyticsScreenState extends State<AdminAnalyticsScreen> {
//   Map<String, dynamic> _analyticsData = {};
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadAnalytics();
//   }

//   Future<void> _loadAnalytics() async {
//     try {
//       final data = await AdminApiService.getServiceAnalytics();
//       setState(() {
//         _analyticsData = data;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() => _isLoading = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error loading analytics: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           const Positioned.fill(
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   opacity: 0.3,
//                   image: AssetImage('assets/images/rfkicks_bg.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           SafeArea(
//             child: _isLoading
//                 ? Center(child: CircularProgressIndicator(color: Colors.white))
//                 : RefreshIndicator(
//                     onRefresh: _loadAnalytics,
//                     child: SingleChildScrollView(
//                       physics: AlwaysScrollableScrollPhysics(),
//                       child: Padding(
//                         padding: EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildHeader(),
//                             _buildOverviewCards(),
//                             SizedBox(height: 20),
//                             _buildRevenueChart(),
//                             SizedBox(height: 20),
//                             _buildServicesList(),
//                             SizedBox(height: 20),
//                             _buildRecentOrders(),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: EdgeInsets.all(20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               IconButton(
//                 onPressed: () => Navigator.pop(context),
//                 icon: Icon(Icons.arrow_back_ios, color: Colors.white),
//               ),
//               SizedBox(width: 8),
//               Text(
//                 'Business Analytics',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           IconButton(
//             onPressed: _loadAnalytics,
//             icon: Icon(Icons.refresh, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOverviewCards() {
//     final formatter = NumberFormat.currency(symbol: '\$');
//     return GridView.count(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       crossAxisCount: 2,
//       crossAxisSpacing: 16,
//       mainAxisSpacing: 16,
//       children: [
//         _buildOverviewCard(
//           'Total Revenue',
//           formatter.format(_analyticsData['totalRevenue'] ?? 0),
//           Icons.attach_money,
//           Color(0xff3c76ad),
//         ),
//         _buildOverviewCard(
//           'Total Orders',
//           '${_analyticsData['totalOrders'] ?? 0}',
//           Icons.shopping_bag,
//           Color(0xff2c5582),
//         ),
//         _buildOverviewCard(
//           'Total Customers',
//           '${_analyticsData['totalCustomers'] ?? 0}',
//           Icons.people,
//           Color(0xff1e3d5c),
//         ),
//         _buildOverviewCard(
//           'Services',
//           '${(_analyticsData['services'] as List?)?.length ?? 0}',
//           Icons.design_services,
//           Color(0xff142943),
//         ),
//       ],
//     );
//   }

//   Widget _buildOverviewCard(
//       String title, String value, IconData icon, Color color) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [color, color.withOpacity(0.8)],
//         ),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: color.withOpacity(0.3),
//             blurRadius: 8,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: Colors.white, size: 32),
//           SizedBox(height: 8),
//           Text(
//             value,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             title,
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildRevenueChart() {
//     final services = _analyticsData['services'] as List? ?? [];
//     if (services.isEmpty) return SizedBox.shrink();

//     return Container(
//       height: 300,
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Service Revenue',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Expanded(
//             child: BarChart(
//               BarChartData(
//                 alignment: BarChartAlignment.spaceAround,
//                 // maxY: services.fold(
//                 //         0.0,
//                 //         (max, service) => service['service_revenue'] > max
//                 //             ? service['service_revenue']
//                 //             : max) *
//                 //     1.2,
//                 maxY: services.fold(
//                         0.0,
//                         (max, service) => double.parse(
//                                     service['service_revenue'].toString()) >
//                                 max
//                             ? double.parse(
//                                 service['service_revenue'].toString())
//                             : max) *
//                     1.2,
//                 barGroups: services.asMap().entries.map((entry) {
//                   return BarChartGroupData(
//                     x: entry.key,
//                     barRods: [
//                       // BarChartRodData(
//                       //   toY: entry.value['service_revenue']?.toDouble() ?? 0,
//                       //   color: Color(0xff3c76ad),
//                       //   width: 16,
//                       //   borderRadius: BorderRadius.circular(4),
//                       // ),
//                       BarChartRodData(
//                         toY: double.parse(
//                             entry.value['service_revenue'].toString()),
//                         color: Color(0xff3c76ad),
//                         width: 16,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//                 titlesData: FlTitlesData(
//                   show: true,
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, meta) {
//                         if (value.toInt() >= services.length)
//                           return const Text('');
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             services[value.toInt()]['name'] ?? '',
//                             style: TextStyle(color: Colors.white, fontSize: 10),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, meta) {
//                         return Text(
//                           '\$${value.toInt()}',
//                           style: TextStyle(color: Colors.white70, fontSize: 12),
//                         );
//                       },
//                     ),
//                   ),
//                   topTitles:
//                       AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   rightTitles:
//                       AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 ),
//                 gridData: FlGridData(show: false),
//                 borderData: FlBorderData(show: false),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildServicesList() {
//     final services = _analyticsData['services'] as List? ?? [];
//     if (services.isEmpty) return SizedBox.shrink();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Service Performance',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 16),
//         ...services.map((service) => _buildServiceCard(service)),
//       ],
//     );
//   }

//   Widget _buildServiceCard(Map<String, dynamic> service) {
//     return Card(
//       margin: EdgeInsets.only(bottom: 12),
//       color: Colors.white.withOpacity(0.1),
//       child: ListTile(
//         title: Text(
//           service['name'] ?? '',
//           style: TextStyle(color: Colors.white),
//         ),
//         subtitle: Text(
//           'Orders: ${service['order_count']} | Revenue: \$${service['service_revenue']}',
//           style: TextStyle(color: Colors.white70),
//         ),
//         trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
//         onTap: () {
//           // Navigate to detailed service analytics
//         },
//       ),
//     );
//   }

//   Widget _buildRecentOrders() {
//     final recentOrders = _analyticsData['recentOrders'] as List? ?? [];
//     if (recentOrders.isEmpty) return SizedBox.shrink();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Recent Orders',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 16),
//         ...recentOrders.map((order) => _buildOrderCard(order)),
//       ],
//     );
//   }

//   // Widget _buildOrderCard(Map<String, dynamic> order) {
//   //   final formatter = NumberFormat.currency(symbol: '\$');
//   //   final orderDate = DateTime.parse(order['date_created_gmt']);

//   //   return Card(
//   //     margin: EdgeInsets.only(bottom: 12),
//   //     color: Colors.white.withOpacity(0.1),
//   //     child: ListTile(
//   //       title: Text(
//   //         'Order #${order['id']}',
//   //         style: TextStyle(color: Colors.white),
//   //       ),
//   //       subtitle: Text(
//   //         '${formatter.format(order['total_amount'])} | ${DateFormat('MMM d, y').format(orderDate)}',
//   //         style: TextStyle(color: Colors.white70),
//   //       ),
//   //       trailing: Container(
//   //         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//   //         decoration: BoxDecoration(
//   //           color: _getStatusColor(order['status']),
//   //           borderRadius: BorderRadius.circular(12),
//   //         ),
//   //         child: Text(
//   //           order['status'] ?? '',
//   //           style: TextStyle(color: Colors.white),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//   Widget _buildOrderCard(Map<String, dynamic> order) {
//     final formatter = NumberFormat.currency(symbol: '\$');
//     final orderDate = DateTime.parse(order['date_created_gmt']);
//     final amount = double.parse(order['total_amount'].toString());

//     return Card(
//       margin: EdgeInsets.only(bottom: 12),
//       color: Colors.white.withOpacity(0.1),
//       child: ListTile(
//         title: Text(
//           'Order #${order['id']}',
//           style: TextStyle(color: Colors.white),
//         ),
//         subtitle: Text(
//           '${formatter.format(amount)} | ${DateFormat('MMM d, y').format(orderDate)}',
//           style: TextStyle(color: Colors.white70),
//         ),
//         trailing: Container(
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             color: _getStatusColor(order['status']),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Text(
//             order['status'] ?? '',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }

//   Color _getStatusColor(String? status) {
//     switch (status?.toLowerCase()) {
//       case 'completed':
//         return Colors.green;
//       case 'processing':
//         return Colors.blue;
//       case 'pending':
//         return Colors.orange;
//       case 'cancelled':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jobtask/services/admin_api_service.dart';
import 'package:intl/intl.dart';

class AdminAnalyticsScreen extends StatefulWidget {
  @override
  _AdminAnalyticsScreenState createState() => _AdminAnalyticsScreenState();
}

class _AdminAnalyticsScreenState extends State<AdminAnalyticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic> _analyticsData = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadAnalytics();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadAnalytics() async {
    try {
      final data = await AdminApiService.getServiceAnalytics();
      setState(() {
        _analyticsData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading analytics: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // const Positioned.fill(
          //   child: DecoratedBox(
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         opacity: 0.3,
          //         image: AssetImage('assets/images/rfk_preview.png'),
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                if (!_isLoading) ...[
                  _buildTabBar(),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildOverviewTab(),
                        _buildServicesTab(),
                        _buildTrendsTab(),
                        _buildCustomersTab(),
                      ],
                    ),
                  ),
                ] else
                  Expanded(
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
              ),
              SizedBox(width: 8),
              Text(
                'Business Analytics',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: _loadAnalytics,
            icon: Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white.withOpacity(0.1),
      child: TabBar(
        controller: _tabController,
        indicatorColor: Color(0xff3c76ad),
        labelColor: Colors.white,
        tabs: [
          Tab(icon: Icon(Icons.dashboard), text: 'Overview'),
          Tab(icon: Icon(Icons.shopping_bag), text: 'Services'),
          Tab(icon: Icon(Icons.trending_up), text: 'Trends'),
          Tab(icon: Icon(Icons.people), text: 'Customers'),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return RefreshIndicator(
      onRefresh: _loadAnalytics,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _buildOverviewCards(),
              SizedBox(height: 20),
              _buildOrderStatusPieChart(),
              SizedBox(height: 20),
              _buildRecentOrders(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCategoryComparison() {
    final services = _analyticsData['services'] as List? ?? [];
    final mainServices =
        services.where((s) => s['service_type'] == 'main').toList();
    final individualServices =
        services.where((s) => s['service_type'] == 'individual').toList();

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Service Category Performance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: _buildCategoryStats('Main Services', mainServices)),
              SizedBox(width: 16),
              Expanded(
                  child: _buildCategoryStats(
                      'Individual Services', individualServices)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryStats(String title, List<dynamic> services) {
    final totalRevenue = services.fold(
        0.0,
        (sum, service) =>
            sum + double.parse(service['service_revenue'].toString()));

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('${services.length} Services',
              style: TextStyle(color: Colors.white70)),
          Text('\$${totalRevenue.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildRecentOrders() {
    final recentOrders = _analyticsData['recentOrders'] as List? ?? [];

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Orders',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ...recentOrders.map((order) => _buildOrderItem(order)),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> order) {
    final amount = double.parse(order['total_amount'].toString());
    final date = DateTime.parse(order['date_created_gmt']);

    return Card(
      color: Colors.white.withOpacity(0.1),
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          'Order #${order['id']}',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          DateFormat('MMM d, y HH:mm').format(date),
          style: TextStyle(color: Colors.white70),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${amount.toStringAsFixed(2)}',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(order['status']),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                order['status'] ?? '',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'processing':
        return Colors.blue;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildOrderStatusPieChart() {
    final recentOrders = _analyticsData['recentOrders'] as List? ?? [];
    final statusCount = {
      'pending': 0,
      'processing': 0,
      'completed': 0,
      'cancelled': 0,
    };

    for (var order in recentOrders) {
      final status = order['status']?.toString().toLowerCase() ?? '';
      if (statusCount.containsKey(status)) {
        statusCount[status] = statusCount[status]! + 1;
      }
    }

    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Orders by Status',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: _generatePieChartSections(statusCount),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _generatePieChartSections(
      Map<String, int> statusCount) {
    final colors = {
      'pending': Colors.orange,
      'processing': Colors.blue,
      'completed': Colors.green,
      'cancelled': Colors.red,
    };

    return statusCount.entries.map((entry) {
      return PieChartSectionData(
        color: colors[entry.key] ?? Colors.grey,
        value: entry.value.toDouble(),
        title: '${entry.key}\n${entry.value}',
        radius: 80,
        titleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildOverviewCards() {
    final formatter = NumberFormat.currency(symbol: '\$');
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildOverviewCard(
          'Total Revenue',
          formatter
              .format(double.parse(_analyticsData['totalRevenue'].toString())),
          Icons.attach_money,
          Color(0xff3c76ad),
        ),
        _buildOverviewCard(
          'Total Orders',
          _analyticsData['totalOrders'].toString(),
          Icons.shopping_bag,
          Color(0xff2c5582),
        ),
        _buildOverviewCard(
          'Total Customers',
          _analyticsData['totalCustomers'].toString(),
          Icons.people,
          Color(0xff1e3d5c),
        ),
        _buildOverviewCard(
          'Services',
          (_analyticsData['services'] as List?)?.length.toString() ?? '0',
          Icons.design_services,
          Color(0xff142943),
        ),
      ],
    );
  }

  Widget _buildOverviewCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildRevenueChart(),
            SizedBox(height: 20),
            _buildServicePerformanceList(),
            SizedBox(height: 20),
            _buildServiceCategoryComparison(),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueChart() {
    final services = _analyticsData['services'] as List? ?? [];
    return Container(
      height: 450, // Increased height for better visibility
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Revenue by Service',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Last 30 days performance',
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.white70, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Tap bars for details',
                      style: TextStyle(color: Colors.white70, fontSize: 8),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: services.fold(
                        0.0,
                        (max, service) => double.parse(
                                    service['service_revenue'].toString()) >
                                max
                            ? double.parse(
                                service['service_revenue'].toString())
                            : max) *
                    1.1,
                barGroups: services.asMap().entries.map((entry) {
                  final revenue =
                      double.parse(entry.value['service_revenue'].toString());
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: revenue,
                        color: Color(0xff3c76ad),
                        width: 10,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(6)),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          // toY: services.fold(
                          //     0.0,
                          //     (max, service) => double.parse(
                          //                 service['service_revenue']
                          //                     .toString()) >
                          //             max
                          //         ? double.parse(
                          //             service['service_revenue'].toString())
                          //         : max),
                          toY: services.fold<double>(
                                  0.0,
                                  (max, service) => double.parse(
                                              service['service_revenue']
                                                      ?.toString() ??
                                                  '0') >
                                          max
                                      ? double.parse(service['service_revenue']
                                              ?.toString() ??
                                          '0')
                                      : max) *
                              1.1,

                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                    ],
                  );
                }).toList(),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= services.length)
                          return const Text('');
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Text(
                              services[value.toInt()]['name'] ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                      reservedSize: 60,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            '\$${value.toInt()}',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                      reservedSize: 40,
                    ),
                  ),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1000,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
          // Legend
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Color(0xff3c76ad),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Revenue',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget _buildRevenueChart() {
  //   final services = _analyticsData['services'] as List? ?? [];
  //   return Container(
  //     height: 300,
  //     padding: EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white.withOpacity(0.1),
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Service Revenue',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         Expanded(
  //           child: BarChart(
  //             BarChartData(
  //               alignment: BarChartAlignment.spaceAround,
  //               maxY: services.fold(
  //                       0.0,
  //                       (max, service) => double.parse(
  //                                   service['service_revenue'].toString()) >
  //                               max
  //                           ? double.parse(
  //                               service['service_revenue'].toString())
  //                           : max) *
  //                   1.2,
  //               barGroups: services.asMap().entries.map((entry) {
  //                 return BarChartGroupData(
  //                   x: entry.key,
  //                   barRods: [
  //                     BarChartRodData(
  //                       toY: double.parse(
  //                           entry.value['service_revenue'].toString()),
  //                       color: Color(0xff3c76ad),
  //                       width: 16,
  //                       borderRadius: BorderRadius.circular(4),
  //                     ),
  //                   ],
  //                 );
  //               }).toList(),
  //               titlesData: FlTitlesData(
  //                 show: true,
  //                 bottomTitles: AxisTitles(
  //                   sideTitles: SideTitles(
  //                     showTitles: true,
  //                     getTitlesWidget: (value, meta) {
  //                       if (value.toInt() >= services.length)
  //                         return const Text('');
  //                       return Padding(
  //                         padding: const EdgeInsets.all(8.0),
  //                         child: Text(
  //                           services[value.toInt()]['name'] ?? '',
  //                           style: TextStyle(color: Colors.white, fontSize: 10),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //                 leftTitles: AxisTitles(
  //                   sideTitles: SideTitles(
  //                     showTitles: true,
  //                     getTitlesWidget: (value, meta) {
  //                       return Text(
  //                         '\$${value.toInt()}',
  //                         style: TextStyle(color: Colors.white70, fontSize: 12),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ),
  //               gridData: FlGridData(show: false),
  //               borderData: FlBorderData(show: false),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildServicePerformanceList() {
    final services = _analyticsData['services'] as List? ?? [];
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Service Performance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ...services.map((service) => _buildServicePerformanceCard(service)),
        ],
      ),
    );
  }

  Widget _buildServicePerformanceCard(Map<String, dynamic> service) {
    final revenue = double.parse(service['service_revenue'].toString());
    final orders = int.parse(service['order_count'].toString());

    return Card(
      color: Colors.white.withOpacity(0.05),
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          service['name'] ?? '',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Revenue: \$${revenue.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.white70),
            ),
            Text(
              'Orders: $orders',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
        // trailing: SizedBox(
        //   width: 60,
        //   height: 60,
        //   child: PieChart(
        //     PieChartData(
        //       sections: [
        //         PieChartSectionData(
        //           color: Color(0xff3c76ad),
        //           value: revenue,
        //           radius: 20,
        //           showTitle: false,
        //         ),
        //       ],
        //       sectionsSpace: 0,
        //       centerSpaceRadius: 20,
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget _buildTrendsTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDailyRevenueChart(),
            SizedBox(height: 20),
            _buildOrderTrendsChart(),
            SizedBox(height: 20),
            _buildPopularTimesChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyRevenueChart() {
    final recentOrders = _analyticsData['recentOrders'] as List? ?? [];
    final dailyData = <DateTime, double>{};

    for (var order in recentOrders) {
      final date = DateTime.parse(order['date_created_gmt']);
      final amount = double.parse(order['total_amount'].toString());
      final key = DateTime(date.year, date.month, date.day);
      dailyData[key] = (dailyData[key] ?? 0) + amount;
    }

    final sortedDates = dailyData.keys.toList()..sort();
    final spots = sortedDates.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), dailyData[e.value]!);
    }).toList();

    return Container(
      height: 450,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Revenue',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1000,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.white10,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= sortedDates.length)
                          return Text('');
                        final date = sortedDates[value.toInt()];
                        return Padding(
                          padding: EdgeInsets.all(2),
                          child: Text(
                            DateFormat('MM/dd').format(date),
                            style:
                                TextStyle(color: Colors.white70, fontSize: 10),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '\$${value.toInt()}',
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                        );
                      },
                    ),
                  ),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Color(0xff3c76ad),
                    barWidth: 3,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Color(0xff3c76ad).withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTrendsChart() {
    final recentOrders = _analyticsData['recentOrders'] as List? ?? [];
    final ordersByStatus = {
      'pending': 0,
      'processing': 0,
      'completed': 0,
      'cancelled': 0,
    };

    for (var order in recentOrders) {
      final status = order['status']?.toString().toLowerCase() ?? '';
      if (ordersByStatus.containsKey(status)) {
        ordersByStatus[status] = ordersByStatus[status]! + 1;
      }
    }

    return Container(
      height: 350,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Status Distribution',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: [
                  PieChartSectionData(
                    color: Colors.orange,
                    value: ordersByStatus['pending']!.toDouble(),
                    title: 'Pending\n${ordersByStatus['pending']}',
                    radius: 80,
                    titleStyle: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  PieChartSectionData(
                    color: Colors.blue,
                    value: ordersByStatus['processing']!.toDouble(),
                    title: 'Processing\n${ordersByStatus['processing']}',
                    radius: 80,
                    titleStyle: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  PieChartSectionData(
                    color: Colors.green,
                    value: ordersByStatus['completed']!.toDouble(),
                    title: 'Completed\n${ordersByStatus['completed']}',
                    radius: 80,
                    titleStyle: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  PieChartSectionData(
                    color: Colors.red,
                    value: ordersByStatus['cancelled']!.toDouble(),
                    title: 'Cancelled\n${ordersByStatus['cancelled']}',
                    radius: 80,
                    titleStyle: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularTimesChart() {
    return Container(
      height: 450,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Order Times',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: _buildHourlyOrdersChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyOrdersChart() {
    final recentOrders = _analyticsData['recentOrders'] as List? ?? [];
    final hourlyOrders = List.filled(24, 0);

    for (var order in recentOrders) {
      final date = DateTime.parse(order['date_created_gmt']);
      hourlyOrders[date.hour]++;
    }

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: hourlyOrders.reduce((a, b) => a > b ? a : b) * 1.2,
        barGroups: hourlyOrders.asMap().entries.map((entry) {
          return BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value.toDouble(),
                color: Color(0xff3c76ad),
                width: 8,
                borderRadius: BorderRadius.circular(2),
              ),
            ],
          );
        }).toList(),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value % 4 != 0) return const Text('');
                return Text(
                  '${value.toInt()}:00',
                  style: TextStyle(color: Colors.white70, fontSize: 10),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(color: Colors.white70, fontSize: 10),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  Widget _buildCustomersTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCustomerMetrics(),
            SizedBox(height: 20),
            _buildTopCustomers(),
            SizedBox(height: 20),
            _buildCustomerRetentionChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerMetrics() {
    final recentOrders = _analyticsData['recentOrders'] as List? ?? [];
    final uniqueCustomers =
        recentOrders.map((o) => o['customer_id']).toSet().length;
    final repeatCustomers = _calculateRepeatCustomers(recentOrders);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Insights',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Active Customers',
                  uniqueCustomers.toString(),
                  Icons.people_outline,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard(
                  'Repeat Customers',
                  repeatCustomers.toString(),
                  Icons.repeat,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTopCustomers() {
    final recentOrders = _analyticsData['recentOrders'] as List? ?? [];
    final customerOrders = _calculateCustomerOrders(recentOrders);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Customers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ...customerOrders
              .take(5)
              .map((customer) => _buildCustomerCard(customer)),
        ],
      ),
    );
  }

  Widget _buildCustomerCard(Map<String, dynamic> customer) {
    return Card(
      color: Colors.white.withOpacity(0.05),
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xff3c76ad),
          child: Text(
            customer['email'][0].toUpperCase(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          customer['email'],
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'Orders: ${customer['orderCount']} | Total: \$${customer['totalSpent'].toStringAsFixed(2)}',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }

  Widget _buildCustomerRetentionChart() {
    return Container(
      height: 350,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Retention',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: _buildRetentionLineChart(),
          ),
        ],
      ),
    );
  }

  // Helper methods for calculations
  int _calculateRepeatCustomers(List<dynamic> orders) {
    final customerOrderCounts = {};
    for (var order in orders) {
      final customerId = order['customer_id'];
      customerOrderCounts[customerId] =
          (customerOrderCounts[customerId] ?? 0) + 1;
    }
    return customerOrderCounts.values.where((count) => count > 1).length;
  }

  List<Map<String, dynamic>> _calculateCustomerOrders(List<dynamic> orders) {
    final customerData = {};

    for (var order in orders) {
      final customerId = order['customer_id'];
      final email = order['billing_email'];
      final amount = double.parse(order['total_amount'].toString());

      if (!customerData.containsKey(customerId)) {
        customerData[customerId] = {
          'email': email,
          'orderCount': 0,
          'totalSpent': 0.0,
        };
      }

      customerData[customerId]['orderCount']++;
      customerData[customerId]['totalSpent'] += amount;
    }

    final sortedCustomers = customerData.values.toList()
      ..sort((a, b) => b['totalSpent'].compareTo(a['totalSpent']));

    return List<Map<String, dynamic>>.from(sortedCustomers);
  }

  // Widget _buildRetentionLineChart() {
  //   // Implementation of retention line chart
  //   // This would show customer retention over time
  //   return Container(); // Placeholder for now
  // }
  Widget _buildRetentionLineChart() {
    final recentOrders = _analyticsData['recentOrders'] as List? ?? [];
    final retentionData = _calculateRetentionData(recentOrders);

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.white10,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= retentionData.length)
                  return const Text('');
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Month ${value.toInt() + 1}',
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}%',
                  style: TextStyle(color: Colors.white70, fontSize: 10),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: retentionData.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value);
            }).toList(),
            isCurved: true,
            color: Color(0xff3c76ad),
            barWidth: 3,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Color(0xff3c76ad).withOpacity(0.2),
            ),
          ),
        ],
        minY: 0,
        maxY: 100,
      ),
    );
  }

  List<double> _calculateRetentionData(List<dynamic> orders) {
    final monthlyCustomers = <int, Set<dynamic>>{};
    final retentionRates = <double>[];

    // Group customers by month
    for (var order in orders) {
      final date = DateTime.parse(order['date_created_gmt']);
      final monthKey = date.year * 12 + date.month;
      monthlyCustomers[monthKey] = (monthlyCustomers[monthKey] ?? {})
        ..add(order['customer_id']);
    }

    // Calculate retention rates
    final months = monthlyCustomers.keys.toList()..sort();
    if (months.isEmpty) return [0];

    final initialCustomers = monthlyCustomers[months.first]!;
    for (var i = 1; i < months.length; i++) {
      final currentCustomers = monthlyCustomers[months[i]]!;
      final retained = currentCustomers.intersection(initialCustomers).length;
      final rate = (retained / initialCustomers.length) * 100;
      retentionRates.add(rate);
    }

    return retentionRates.isEmpty ? [0] : retentionRates;
  }
}
