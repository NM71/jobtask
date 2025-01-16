import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:jobtask/models/order_receipt.dart';
import 'package:jobtask/services/api_service.dart';
import 'package:jobtask/utils/custom_buttons/my_button.dart';
import 'package:jobtask/utils/custom_buttons/my_button_outlined.dart';
import 'package:jobtask/utils/custom_snackbar.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class ReceiptDialog extends StatelessWidget {
  final OrderReceipt receipt;
  final ScreenshotController screenshotController = ScreenshotController();

  ReceiptDialog({Key? key, required this.receipt}) : super(key: key);

  Future<void> _saveReceipt(BuildContext context) async {
    // First check if we have permission
    var status = await Permission.storage.status;

    // If permission is permanently denied, open app settings
    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return;
    }

    // If permission is not granted, request it
    if (!status.isGranted) {
      status = await Permission.storage.request();

      // For Android 11 (API level 30) and above
      if (!status.isGranted) {
        status = await Permission.manageExternalStorage.request();
      }
    }

    // If we still don't have permission after requesting
    if (!status.isGranted) {
      CustomSnackbar.show(
        context: context,
        message:
            'Storage access needed to save receipt. Please grant permission in Settings.',
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Center(
        child: Container(
          padding: EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3c76ad)),
              ),
              SizedBox(height: 16),
              Text(
                'Saving receipt...',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    try {
      final pdf = pw.Document();

      // Load RFK logo
      final logoImage = await rootBundle.load('assets/images/rfkicks_logo.png');
      final logoBytes = logoImage.buffer.asUint8List();

      // Fetch service images
      List<Uint8List> serviceImages = await Future.wait(receipt.services.map(
          (service) => NetworkAssetBundle(Uri.parse(service.imageUrl))
              .load(service.imageUrl)
              .then((byteData) => byteData.buffer.asUint8List())));

      pdf.addPage(
        pw.Page(
          margin: pw.EdgeInsets.all(24),
          build: (context) {
            return pw.Column(
              children: [
                // Header with Logo
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(pw.MemoryImage(logoBytes), width: 120),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('RECEIPT',
                            style: pw.TextStyle(
                                fontSize: 24, fontWeight: pw.FontWeight.bold)),
                        pw.Text('Order #${receipt.orderId}'),
                        pw.Text(DateFormat('MMM dd, yyyy')
                            .format(receipt.dateCreated)),
                      ],
                    ),
                  ],
                ),
                pw.Divider(thickness: 2),
                pw.SizedBox(height: 20),

                // Customer Info
                pw.Container(
                  padding: pw.EdgeInsets.all(12),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
                    borderRadius: pw.BorderRadius.circular(8),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('Customer Details',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text(receipt.customerEmail),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text('Payment Method',
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text(receipt.paymentMethodTitle),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),

                // Services
                pw.Text('Services',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                ...List.generate(receipt.services.length, (index) {
                  final service = receipt.services[index];
                  return pw.Container(
                    margin: pw.EdgeInsets.symmetric(vertical: 8),
                    padding: pw.EdgeInsets.all(12),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey300),
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    child: pw.Row(
                      children: [
                        pw.Image(pw.MemoryImage(serviceImages[index]),
                            width: 60, height: 60),
                        pw.SizedBox(width: 12),
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(service.name,
                                  style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold)),
                              if (service.description != null)
                                pw.Text(service.description!,
                                    style:
                                        pw.TextStyle(color: PdfColors.grey700)),
                              pw.Text('Quantity: ${service.quantity}'),
                            ],
                          ),
                        ),
                        pw.Text(
                          '${receipt.currency} ${(service.price * service.quantity).toStringAsFixed(2)}',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }),
                pw.SizedBox(height: 20),

                // Totals
                pw.Container(
                  padding: pw.EdgeInsets.all(12),
                  decoration: pw.BoxDecoration(
                    color: PdfColors.grey100,
                    borderRadius: pw.BorderRadius.circular(8),
                  ),
                  child: pw.Column(
                    children: [
                      _buildPdfTotalRow(
                          'Subtotal', receipt.totalAmount - (receipt.tax ?? 0)),
                      if (receipt.tax != null)
                        _buildPdfTotalRow('Tax', receipt.tax!),
                      pw.Divider(),
                      _buildPdfTotalRow('Total', receipt.totalAmount,
                          isTotal: true),
                    ],
                  ),
                ),

                // Footer
                pw.Spacer(),
                pw.Text(
                  'Thank you for choosing ReFresh Kicks!',
                  style: pw.TextStyle(
                      color: PdfColors.blue800, fontWeight: pw.FontWeight.bold),
                  textAlign: pw.TextAlign.center,
                ),
              ],
            );
          },
        ),
      );

      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      final String fileName =
          'RFKicks_Receipt_${receipt.orderId}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(await pdf.save());

      Navigator.pop(context);

      await showModalBottomSheet(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'Receipt Saved',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Your receipt has been saved to your Downloads folder.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff767676),
                ),
              ),
              SizedBox(height: 30),
              MyButton(
                height: 51,
                text: 'Got It',
                onTap: () {
                  Navigator.pop(context);
                  CustomSnackbar.show(
                    context: context,
                    message: 'Receipt saved successfully',
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      CustomSnackbar.show(
        context: context,
        message: 'Unable to save receipt. Please try again',
      );
    }
  }

  // Future<void> _saveReceipt(BuildContext context) async {
  //   var status = await Permission.storage.status;
  //   if (!status.isGranted) {
  //     status = await Permission.storage.request();
  //     if (!status.isGranted) {
  //       CustomSnackbar.show(
  //         context: context,
  //         message: 'Storage access needed to save receipt',
  //       );
  //       return;
  //     }
  //   }

  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) => Center(
  //       child: Container(
  //         padding: EdgeInsets.all(32),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(6),
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             CircularProgressIndicator(
  //               valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3c76ad)),
  //             ),
  //             SizedBox(height: 16),
  //             Text(
  //               'Saving receipt...',
  //               style: TextStyle(
  //                 color: Colors.black,
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );

  //   try {
  //     final pdf = pw.Document();

  //     // Load RFK logo
  //     final logoImage = await rootBundle.load('assets/images/rfkicks_logo.png');
  //     final logoBytes = logoImage.buffer.asUint8List();

  //     // Fetch service images
  //     List<Uint8List> serviceImages = await Future.wait(receipt.services.map(
  //         (service) => NetworkAssetBundle(Uri.parse(service.imageUrl))
  //             .load(service.imageUrl)
  //             .then((byteData) => byteData.buffer.asUint8List())));
  //     // // Create a list to store image fetching futures
  //     // List<Future<Uint8List>> imageFutures = [];

  //     // // Fetch all images first
  //     // for (var service in receipt.services) {
  //     //   imageFutures.add(NetworkAssetBundle(Uri.parse(service.imageUrl))
  //     //       .load(service.imageUrl)
  //     //       .then((byteData) => byteData.buffer.asUint8List()));
  //     // }

  //     // // Wait for all images to be fetched
  //     // final serviceImages = await Future.wait(imageFutures);

  //     pdf.addPage(
  //       pw.Page(
  //         margin: pw.EdgeInsets.all(24),
  //         build: (context) {
  //           return pw.Column(
  //             children: [
  //               // Header with Logo
  //               pw.Row(
  //                 mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   pw.Image(pw.MemoryImage(logoBytes), width: 120),
  //                   pw.Column(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.end,
  //                     children: [
  //                       pw.Text('RECEIPT',
  //                           style: pw.TextStyle(
  //                               fontSize: 24, fontWeight: pw.FontWeight.bold)),
  //                       pw.Text('Order #${receipt.orderId}'),
  //                       pw.Text(DateFormat('MMM dd, yyyy')
  //                           .format(receipt.dateCreated)),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               pw.Divider(thickness: 2),
  //               pw.SizedBox(height: 20),

  //               // Customer Info
  //               pw.Container(
  //                 padding: pw.EdgeInsets.all(12),
  //                 decoration: pw.BoxDecoration(
  //                   color: PdfColors.grey100,
  //                   borderRadius: pw.BorderRadius.circular(8),
  //                 ),
  //                 child: pw.Row(
  //                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     pw.Column(
  //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                       children: [
  //                         pw.Text('Customer Details',
  //                             style:
  //                                 pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //                         pw.Text(receipt.customerEmail),
  //                       ],
  //                     ),
  //                     pw.Column(
  //                       crossAxisAlignment: pw.CrossAxisAlignment.end,
  //                       children: [
  //                         pw.Text('Payment Method',
  //                             style:
  //                                 pw.TextStyle(fontWeight: pw.FontWeight.bold)),
  //                         pw.Text(receipt.paymentMethodTitle),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               pw.SizedBox(height: 20),

  //               // Services
  //               pw.Text('Services',
  //                   style: pw.TextStyle(
  //                       fontSize: 18, fontWeight: pw.FontWeight.bold)),
  //               pw.SizedBox(height: 10),
  //               ...List.generate(receipt.services.length, (index) {
  //                 final service = receipt.services[index];
  //                 return pw.Container(
  //                   margin: pw.EdgeInsets.symmetric(vertical: 8),
  //                   padding: pw.EdgeInsets.all(12),
  //                   decoration: pw.BoxDecoration(
  //                     border: pw.Border.all(color: PdfColors.grey300),
  //                     borderRadius: pw.BorderRadius.circular(8),
  //                   ),
  //                   child: pw.Row(
  //                     children: [
  //                       pw.Image(pw.MemoryImage(serviceImages[index]),
  //                           width: 60, height: 60),
  //                       pw.SizedBox(width: 12),
  //                       pw.Expanded(
  //                         child: pw.Column(
  //                           crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                           children: [
  //                             pw.Text(service.name,
  //                                 style: pw.TextStyle(
  //                                     fontWeight: pw.FontWeight.bold)),
  //                             if (service.description != null)
  //                               pw.Text(service.description!,
  //                                   style:
  //                                       pw.TextStyle(color: PdfColors.grey700)),
  //                             pw.Text('Quantity: ${service.quantity}'),
  //                           ],
  //                         ),
  //                       ),
  //                       pw.Text(
  //                         '${receipt.currency} ${(service.price * service.quantity).toStringAsFixed(2)}',
  //                         style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               }),
  //               pw.SizedBox(height: 20),

  //               // Totals
  //               pw.Container(
  //                 padding: pw.EdgeInsets.all(12),
  //                 decoration: pw.BoxDecoration(
  //                   color: PdfColors.grey100,
  //                   borderRadius: pw.BorderRadius.circular(8),
  //                 ),
  //                 child: pw.Column(
  //                   children: [
  //                     _buildPdfTotalRow(
  //                         'Subtotal', receipt.totalAmount - (receipt.tax ?? 0)),
  //                     if (receipt.tax != null)
  //                       _buildPdfTotalRow('Tax', receipt.tax!),
  //                     pw.Divider(),
  //                     _buildPdfTotalRow('Total', receipt.totalAmount,
  //                         isTotal: true),
  //                   ],
  //                 ),
  //               ),

  //               // Footer
  //               pw.Spacer(),
  //               pw.Text(
  //                 'Thank you for choosing ReFresh Kicks!',
  //                 style: pw.TextStyle(
  //                     color: PdfColors.blue800, fontWeight: pw.FontWeight.bold),
  //                 textAlign: pw.TextAlign.center,
  //               ),
  //             ],
  //           );
  //         },
  //       ),
  //     );

  //     final directory = Directory('/storage/emulated/0/Download');
  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }

  //     final String fileName =
  //         'RFKicks_Receipt_${receipt.orderId}_${DateTime.now().millisecondsSinceEpoch}.pdf';
  //     final file = File('${directory.path}/$fileName');
  //     await file.writeAsBytes(await pdf.save());

  //     Navigator.pop(context);

  //     await showModalBottomSheet(
  //       context: context,
  //       backgroundColor: Colors.transparent,
  //       builder: (context) => Container(
  //         padding: EdgeInsets.all(20),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Center(
  //               child: Container(
  //                 width: 40,
  //                 height: 4,
  //                 margin: EdgeInsets.only(bottom: 20),
  //                 decoration: BoxDecoration(
  //                   color: Colors.grey[300],
  //                   borderRadius: BorderRadius.circular(2),
  //                 ),
  //               ),
  //             ),
  //             Text(
  //               'Receipt Saved',
  //               style: TextStyle(
  //                 fontSize: 24,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             Text(
  //               'Your receipt has been saved to your Downloads folder.',
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 color: Color(0xff767676),
  //               ),
  //             ),
  //             SizedBox(height: 30),
  //             MyButton(
  //               height: 51,
  //               text: 'Got It',
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 CustomSnackbar.show(
  //                   context: context,
  //                   message: 'Receipt saved successfully',
  //                 );
  //               },
  //             ),
  //             SizedBox(height: 20),
  //           ],
  //         ),
  //       ),
  //     );
  //   } catch (e) {
  //     Navigator.pop(context);
  //     CustomSnackbar.show(
  //       context: context,
  //       message: 'Unable to save receipt. Please try again',
  //     );
  //   }
  // }

  pw.Widget _buildPdfTotalRow(String label, double amount,
      {bool isTotal = false}) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontWeight: isTotal ? pw.FontWeight.bold : null,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          pw.Text(
            '\$${amount.toStringAsFixed(2)}',
            style: pw.TextStyle(
              fontWeight: isTotal ? pw.FontWeight.bold : null,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }

// Helper method for PDF info rows
  pw.Widget _buildPdfInfoRow(String label, String value) {
    return pw.Container(
      margin: pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: pw.TextStyle(color: PdfColors.grey)),
          pw.Text(value),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Screenshot(
        controller: screenshotController,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(context),
                SizedBox(height: 20),
                Text(
                  "We\’ve emailed you a confirmation to ${receipt.customerEmail} and we\’ll notify you when your order has been dispatched.",
                  style: TextStyle(color: Color(0xff767676), fontSize: 16),
                ),
                SizedBox(height: 20),
                Divider(
                  height: 20,
                  thickness: 5,
                  color: Color(0xffe4e4e4),
                ),
                SizedBox(height: 20),
                _buildOrderDetails(),
                Divider(
                  height: 20,
                  thickness: 5,
                  color: Color(0xffe4e4e4),
                ),
                SizedBox(height: 20),
                _buildServicesList(),
                SizedBox(height: 20),
                _buildTotalSection(),
                SizedBox(height: 20),
                _buildDoneButton(context),
                SizedBox(height: 20),
                _buildButtons(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Thank You\nFor Your Order',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Container(
          decoration:
              BoxDecoration(color: Color(0xff3d76ad), shape: BoxShape.circle),
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Order Details'),
        _buildInfoRow('Order ID', '#${receipt.orderId}'),
        _buildInfoRow(
            'Date', DateFormat('MMM dd, yyyy').format(receipt.dateCreated)),
        _buildInfoRow('Status', receipt.status.toUpperCase()),
        _buildInfoRow('Payment Method', receipt.paymentMethodTitle),
        _buildInfoRow('Delivery Type', receipt.deliveryType),
        if (receipt.transactionId?.isNotEmpty ?? false)
          _buildInfoRow('Transaction ID', receipt.transactionId!),
        SizedBox(height: 16),
      ],
    );
  }

// Inside _buildServicesList() method
  Widget _buildServicesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Services'),
        ...receipt.services
            .map((service) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service Image
                      // Container(
                      //   width: 60,
                      //   height: 60,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(8),
                      //     border: Border.all(color: Colors.grey[200]!),
                      //   ),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(8),
                      //     child: Image.network(
                      //       service.imageUrl,
                      //       fit: BoxFit.cover,
                      //       errorBuilder: (context, error, stackTrace) =>
                      //           Container(
                      //         color: Colors.grey[100],
                      //         child: Icon(Icons.image_not_supported,
                      //             color: Colors.grey),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      CachedNetworkImage(
                        imageUrl: service.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[100],
                          child: Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xff3c76ad)),
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[100],
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey),
                        ),
                      ),

                      SizedBox(width: 12),
                      // Service Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (service.description?.isNotEmpty ?? false)
                              Text(
                                service.description!,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            Text(
                              'Quantity: ${service.quantity}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Price
                      Text(
                        '${receipt.currency} ${(service.price * service.quantity).toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ))
            .toList(),
        Divider(
          height: 20,
          thickness: 5,
          color: Color(0xffe4e4e4),
        ),
      ],
    );
  }

  Widget _buildTotalSection() {
    return Column(
      children: [
        if (receipt.tax != null)
          _buildInfoRow(
            'Tax',
            '${receipt.currency.toUpperCase()} ${receipt.tax!.toStringAsFixed(2)}',
          ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Amount',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${receipt.currency.toUpperCase()} ${receipt.totalAmount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff3c76ad),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff3c76ad),
        minimumSize: Size(double.infinity, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () => Navigator.pop(context),
      child: Text(
        'Done',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MyButtonOutlined(
            text: 'Save Receipt',
            textStyle: TextStyle(color: Colors.black),
            onTap: () => _saveReceipt(context),
          ),
        ),
        SizedBox(height: 12),
        if (receipt.status.toLowerCase() != 'cancelled')
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
              minimumSize: Size(double.infinity, 50),
            ),
            onPressed: () {
              final parentContext = context;
              showModalBottomSheet<bool>(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Text(
                        'Want to cancel your order?',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'You can cancel orders for a short time after they are placed - free of charge',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff767676),
                        ),
                      ),
                      SizedBox(height: 30),
                      MyButton(
                        text: 'Yes, Cancel Order',
                        height: 51,
                        onTap: () async {
                          Navigator.pop(context);

                          showDialog(
                            context: parentContext,
                            barrierDismissible: false,
                            builder: (BuildContext context) => Center(
                              child: Container(
                                padding: EdgeInsets.all(32),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xff3c76ad)),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Cancelling order...',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );

                          try {
                            final storage = const FlutterSecureStorage();
                            final token = await storage.read(key: 'auth_token');

                            if (token != null) {
                              await ApiService.updateOrderStatus(token,
                                  receipt.orderId.toString(), 'cancelled');

                              Navigator.pop(parentContext);
                              Navigator.pop(parentContext);

                              CustomSnackbar.show(
                                context: parentContext,
                                message: 'Order cancelled successfully',
                              );
                            }
                          } catch (e) {
                            Navigator.pop(parentContext);
                            CustomSnackbar.show(
                              context: parentContext,
                              message: 'Failed to cancel order',
                            );
                          }
                        },
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: MyButtonOutlined(
                          text: 'Go Back',
                          textStyle: TextStyle(color: Colors.black),
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              );
            },
            child: Text('Cancel Order'),
          )
      ],
    );
  }
  // Widget _buildButtons(BuildContext context) {
  //   return Column(
  //     children: [
  //       SizedBox(
  //         width: double.infinity,
  //         child: MyButtonOutlined(
  //           text: 'Save Receipt',
  //           textStyle: TextStyle(color: Colors.black),
  //           onTap: () => _saveReceipt(context),
  //         ),
  //       ),
  //       SizedBox(height: 12),
  //       if (receipt.status.toLowerCase() != 'cancelled')
  //         TextButton(
  //           style: TextButton.styleFrom(
  //             foregroundColor: Colors.red,
  //             minimumSize: Size(double.infinity, 50),
  //           ),
  //           onPressed: () async {
  //             final confirmed = await showModalBottomSheet<bool>(
  //               context: context,
  //               backgroundColor: Colors.transparent,
  //               builder: (context) => Container(
  //                 padding: EdgeInsets.all(20),
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius:
  //                       BorderRadius.vertical(top: Radius.circular(20)),
  //                 ),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Center(
  //                       child: Container(
  //                         width: 40,
  //                         height: 4,
  //                         margin: EdgeInsets.only(bottom: 20),
  //                         decoration: BoxDecoration(
  //                           color: Colors.grey[300],
  //                           borderRadius: BorderRadius.circular(2),
  //                         ),
  //                       ),
  //                     ),
  //                     Text(
  //                       'Want to cancel your order?',
  //                       style: TextStyle(
  //                         fontSize: 24,
  //                         fontWeight: FontWeight.bold,
  //                         // color: Color(0xff3c76ad),
  //                       ),
  //                     ),
  //                     SizedBox(height: 20),
  //                     Text(
  //                       'You can cancel orders for a short time after they are placed - free of charge',
  //                       style: TextStyle(
  //                         fontSize: 14,
  //                         color: Color(0xff767676),
  //                       ),
  //                     ),
  //                     SizedBox(height: 30),
  //                     MyButton(
  //                       text: 'Yes, Cancel Order',
  //                       height: 51,
  //                       onTap: () => Navigator.pop(context, true),
  //                     ),
  //                     SizedBox(height: 12),
  //                     SizedBox(
  //                       width: double.infinity,
  //                       child: MyButtonOutlined(
  //                         text: 'Go Back',
  //                         textStyle: TextStyle(color: Colors.black),
  //                         onTap: () => Navigator.pop(context, false),
  //                       ),
  //                     ),
  //                     SizedBox(height: 20),
  //                   ],
  //                 ),
  //               ),
  //             );

  //             if (confirmed == true) {
  //               // Show loading indicator
  //               showDialog(
  //                 context: context,
  //                 barrierDismissible: false,
  //                 builder: (BuildContext context) {
  //                   return Center(
  //                     child: Container(
  //                       padding: EdgeInsets.all(32),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius: BorderRadius.circular(6),
  //                       ),
  //                       child: Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           CircularProgressIndicator(
  //                             strokeWidth: 4,
  //                             valueColor: AlwaysStoppedAnimation<Color>(
  //                                 Color(0xff3c76ad)),
  //                           ),
  //                           SizedBox(height: 16),
  //                           Text(
  //                             'Cancelling order...',
  //                             style: TextStyle(
  //                               color: Colors.black,
  //                               fontSize: 16,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               );

  //               try {
  //                 final storage = const FlutterSecureStorage();
  //                 final token = await storage.read(key: 'auth_token');

  //                 if (token != null) {
  //                   await ApiService.updateOrderStatus(
  //                       token, receipt.orderId.toString(), 'cancelled');

  //                   // Close loading indicator
  //                   Navigator.pop(context);

  //                   // Show success bottom sheet
  //                   await showModalBottomSheet(
  //                     context: context,
  //                     backgroundColor: Colors.transparent,
  //                     builder: (context) => Container(
  //                       padding: EdgeInsets.all(20),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         borderRadius:
  //                             BorderRadius.vertical(top: Radius.circular(20)),
  //                       ),
  //                       child: Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Center(
  //                             child: Container(
  //                               width: 40,
  //                               height: 4,
  //                               margin: EdgeInsets.only(bottom: 20),
  //                               decoration: BoxDecoration(
  //                                 color: Colors.grey[300],
  //                                 borderRadius: BorderRadius.circular(2),
  //                               ),
  //                             ),
  //                           ),
  //                           Text(
  //                             'Your order has been cancelled',
  //                             style: TextStyle(
  //                               fontSize: 24,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                           SizedBox(height: 20),
  //                           Text(
  //                             'Good news! Your cancellation has been processed and you won\'t be charged. It can take a few minutes for this page to show your order\'s status updated.',
  //                             style: TextStyle(
  //                               fontSize: 16,
  //                               color: Color(0xff767676),
  //                             ),
  //                           ),
  //                           SizedBox(height: 30),
  //                           MyButton(
  //                             height: 51,
  //                             text: 'Got It',
  //                             onTap: () {
  //                               Navigator.pop(context);
  //                               Navigator.pushReplacementNamed(
  //                                   context, '/order-history');
  //                               CustomSnackbar.show(
  //                                 context: context,
  //                                 message: 'Order cancelled successfully',
  //                               );
  //                             },
  //                           ),
  //                           SizedBox(height: 20),
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 }
  //               } catch (e) {
  //                 // Close loading indicator if error occurs
  //                 Navigator.pop(context);
  //                 CustomSnackbar.show(
  //                   context: context,
  //                   message: 'Failed to cancel order',
  //                 );
  //               }
  //             }
  //           },
  //           child: Text('Cancel Order'),
  //         )
  //     ],
  //   );
  // }
}
