import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:media_scanner/media_scanner.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../widgets/my_snackbar.dart';

class PdfService {
  static Future<void> generateAndDownloadInvoice({
    required String title,
    String? invoiceNo,
    String? billNo,
    required String amount,
    required String date,
    required String time,
    required String referenceNumber,
    String? status,
    String? details,
    required BuildContext context,
  }) async {
    try {
      // طلب صلاحية التخزين حسب النظام
      if (Platform.isAndroid) {
        PermissionStatus permissionStatus = await Permission.manageExternalStorage.status;
        if (!permissionStatus.isGranted) {
          permissionStatus = await Permission.manageExternalStorage.request();
        }

        // إذا لم تُمنح، جرب صلاحية التخزين العادية
        if (!permissionStatus.isGranted) {
          permissionStatus = await Permission.storage.request();
        }

        // إذا كانت الصلاحية محدودة أو ممنوحة، تابع
        if (!permissionStatus.isGranted && !permissionStatus.isLimited) {
          FloatingSnackBar.show(
            context,
            "يرجى منح صلاحية الوصول للتخزين من الإعدادات",
            isError: true,
          );
          await openAppSettings();
          return;
        }
      }
      // iOS لا يحتاج صلاحيات خاصة للحفظ في مجلد التطبيق
      // تحميل الخط العربي
      final arabicFont =
          await rootBundle.load("assets/fonts/LamaSans-Regular.ttf");
      final ttf = pw.Font.ttf(arabicFont);

      // إنشاء مستند PDF
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData.withFont(
            base: ttf,
          ),
          build: (pw.Context context) {
            return pw.Directionality(
              textDirection: pw.TextDirection.rtl,
              child: pw.Padding(
                padding: pw.EdgeInsets.all(40),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Header
                    pw.Center(
                      child: pw.Text(
                        'تفاصيل المعاملة',
                        style: pw.TextStyle(
                          font: ttf,
                          fontSize: 28,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 40),

                    // Main Card
                    pw.Container(
                      padding: pw.EdgeInsets.all(20),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.grey300,
                          width: 1,
                        ),
                        borderRadius: pw.BorderRadius.circular(12),
                      ),
                      child: pw.Column(
                        children: [
                          // Title and Amount Row
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                title,
                                style: pw.TextStyle(
                                  font: ttf,
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text(
                                '$amount ريال',
                                style: pw.TextStyle(
                                  font: ttf,
                                  fontSize: 22,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.blue800,
                                ),
                              ),
                            ],
                          ),
                          pw.SizedBox(height: 20),

                          // Details Card
                          pw.Container(
                            padding: pw.EdgeInsets.all(16),
                            decoration: pw.BoxDecoration(
                              color: PdfColors.grey100,
                              border: pw.Border.all(
                                color: PdfColors.grey300,
                                width: 1,
                              ),
                              borderRadius: pw.BorderRadius.circular(8),
                            ),
                            child: pw.Column(
                              children: [
                                _buildDetailRow(ttf, 'تاريخ المعاملة', date),
                                pw.Divider(height: 20, color: PdfColors.grey300),
                                _buildDetailRow(ttf, 'وقت المعاملة', time),
                                pw.Divider(height: 20, color: PdfColors.grey300),
                                _buildDetailRow(ttf, 'الرقم المرجعي', referenceNumber),
                                if (status != null) ...[
                                  pw.Divider(height: 20, color: PdfColors.grey300),
                                  _buildDetailRow(ttf, 'حالة الطلب', status),
                                ],
                                if (invoiceNo != null) ...[
                                  pw.Divider(height: 20, color: PdfColors.grey300),
                                  _buildDetailRow(ttf, 'رقم الفاتورة', invoiceNo),
                                ],
                                if (billNo != null) ...[
                                  pw.Divider(height: 20, color: PdfColors.grey300),
                                  _buildDetailRow(ttf, 'رقم السند/الإيصال', billNo),
                                ],
                                if (details != null) ...[
                                  pw.Divider(height: 20, color: PdfColors.grey300),
                                  _buildDetailRow(ttf, 'التفاصيل', details),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    pw.Spacer(),

                    // Footer
                    pw.Center(
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'فاتورة فلك المزادات',
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 16,
                              color: PdfColors.grey700,
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Text(
                            'تم إنشاء الفاتورة في ${DateTime.now().toString().split('.')[0]}',
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 12,
                              color: PdfColors.grey600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      // حفظ الملف حسب النظام
      String fileName = "invoice_${DateTime.now().millisecondsSinceEpoch}.pdf";
      String filePath;

      if (Platform.isIOS) {
        // للـ iOS: احفظ في مجلد المستندات
        final directory = await getApplicationDocumentsDirectory();
        filePath = '${directory.path}/$fileName';
      } else {
        // للأندرويد: احفظ في مجلد التنزيلات
        filePath = "/storage/emulated/0/Download/$fileName";
      }

      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      // مسح الملف في معرض الملفات (للأندرويد فقط)
      if (Platform.isAndroid) {
        await MediaScanner.loadMedia(path: filePath);
      }

      // فتح الملف بعد التنزيل
      final result = await OpenFile.open(filePath);

      if (result.type == ResultType.done) {
        FloatingSnackBar.show(
          context,
          Platform.isIOS
            ? "تم حفظ الفاتورة بنجاح في مجلد المستندات"
            : "تم حفظ الفاتورة بنجاح",
          isError: false,
        );
      } else {
        FloatingSnackBar.show(
          context,
          "فشل في فتح الملف: ${result.message}",
          isError: true,
        );
      }
    } catch (e) {
      FloatingSnackBar.show(
        context,
        "فشل في إنشاء الفاتورة: $e",
        isError: true,
      );
    }
  }

  static pw.Widget _buildDetailRow(pw.Font font, String label, String value) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            font: font,
            fontSize: 14,
            color: PdfColors.grey700,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            font: font,
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
