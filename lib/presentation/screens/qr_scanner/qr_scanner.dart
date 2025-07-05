import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/presentation/widgets/arrow_back_ios.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart';

import '../../../constants/colors_constants.dart';
import '../../../utils/app.dart';
import '../../../utils/share_chat.dart';
import '../../widgets/ink_well_custom.dart';

class QRScannerWidget extends StatefulWidget {

  final Function navigateToHome;
  const QRScannerWidget({super.key, required this.navigateToHome});

  @override
  State<QRScannerWidget> createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Container(
        height: MediaQuery.of(context).size.height - 1,
        width: MediaQuery.of(context).size.width,
        color: Colors.white12,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          primary: false,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 60,
              ),
              ArrowBackButton(onTap: widget.navigateToHome),
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 65),
                child: Column(
                  children: [
                    _buildQrView(context),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 170,
                      height: 33,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      // margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWellCustom(
                        onTap: () async {
                          XFile? res = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (res != null) {
                            try {
                              String? str = await Scan.parse(res.path);
                              if (str != null) {
                                if (context.mounted) {
                                      ShareChat.changeScreen(str);
                                  // Navigator.pop(context,str);
                                }
                              } else {
                                if (context.mounted) {
                                  // Navigator.pop(context);
                                }
                              }
                            } catch (e) {
                              if (context.mounted) {
                                // Navigator.pop(context);
                              }
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: AutoSizeText(
                                AppHelper.getDynamicString(
                                    context, "Upload from gallery"),
                                maxFontSize: 13,
                                maxLines: 1,
                                minFontSize: 10,
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: ColorsConstants.skipColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 350.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
        height: scanArea,
        width: scanArea,
        child: QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.transparent,
            borderRadius: 5,
            borderLength: 10,
            borderWidth: 0,
            overlayColor: Colors.transparent,
            cutOutSize: scanArea,
          ),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
          ShareChat.changeScreen(scanData.code ?? "");
      // Navigator.pop(context,scanData.code);
      // controller.dispose();
    });
  }

  Future<void> _onPermissionSet(
      BuildContext context, QRViewController ctrl, bool p) async {
    if (!p) {
      var status = await Permission.camera.status;
      if (status.isDenied) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(AppHelper.getDynamicString(context, "No_Permission"))),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
