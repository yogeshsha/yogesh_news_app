import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/presentation/widgets/primary_button_component.dart';
import 'package:newsapp/presentation/widgets/simple_text.dart';
import 'package:newsapp/utils/app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants/colors_constants.dart';
import '../../constants/images_constants.dart';

class QrCodeWidget extends StatelessWidget {
  final String qrCode;

  const QrCodeWidget({super.key, required this.qrCode});

  // @override
  // Widget build(BuildContext context) {
  //   return QrImageView(
  //     data: qrCode,
  //     version: QrVersions.auto,
  //     size: 200.0,
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return QrImageView(
        embeddedImageStyle: const QrEmbeddedImageStyle(size: Size(30, 30)),
        data: qrCode,
        padding: EdgeInsets.zero,
        version: QrVersions.auto,
        size: MediaQuery.of(context).size.width / 1.8);
  }
}

class QrCodeFunctions {
  static void showDialogForQR(
      {required BuildContext context,
      required String qrCode,
      required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Colors.white,
          title: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: QrCodeWidget(qrCode: qrCode),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: SelectableText(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.zero,
          actionsPadding: const EdgeInsets.only(bottom: 10),
          actions: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: PrimaryButtonComponent(
                backGroundColor: ColorsConstants.appColor,
                textColor: ColorsConstants.white,
                title: "Share",
                onTap: () async {
                  await _shareQRCode(
                          context: context, code: qrCode, message: message)
                      .then((value) => Navigator.pop(context));
                },
              )),
            )
          ],
        );
      },
    );
  }

  static Future<void> _shareQRCode(
      {required BuildContext context,
      required String code,
      required String message}) async {
    const bool gapLess = true;
    const int errorCorrectLevel = QrErrorCorrectLevel.M;
    const double size = 400;
    final double actualQRCodeSize = _getActualQRCodeSize(
      text: code,
      size: size,
      gapLess: gapLess,
      errorCorrectLevel: errorCorrectLevel,
    );

    final ByteData? image = await QrPainter(
      data: code,
      version: QrVersions.auto,
      gapless: gapLess,
      color: const Color(0xFF000000),
      emptyColor: const Color(0xFFFFFFFF),
      errorCorrectionLevel: errorCorrectLevel,
    ).toImageData(actualQRCodeSize);

    const filename = 'qr_code.png';
    final tempDir =
        await getTemporaryDirectory(); // Get temporary directory to store the generated image
    final file = await File('${tempDir.path}/$filename')
        .create(); // Create a file to store the generated image
    var bytes = image!.buffer.asUint8List(); // Get the image bytes
    await file.writeAsBytes(bytes); // Write the image bytes to the file
    if (context.mounted) {
      await Share.shareFiles([file.path],
          text: '${AppHelper.getDynamicString(context, "QR code for")} $code',
          subject: message,
          mimeTypes: ['image/png']);
    }
  }

  static double _getActualQRCodeSize({
    required String text,
    required double size,
    required bool gapLess,
    required int errorCorrectLevel,
  }) {
    // These calculations are from `_PaintMetrics._calculateMetrics`
    final double gap = gapLess ? 0 : 0.25;
    final QrCode qrCode = QrCode.fromData(
      data: text,
      errorCorrectLevel: errorCorrectLevel,
    );

    final double gapTotal = (qrCode.moduleCount - 1) * gap;

    final double actualQRCodeSize;
    double pixelSize = (size - gapTotal) / qrCode.moduleCount;
    pixelSize = (pixelSize * 2).roundToDouble() / 2;

    actualQRCodeSize = (pixelSize * qrCode.moduleCount) + gapTotal;

    return actualQRCodeSize;
  }
}
