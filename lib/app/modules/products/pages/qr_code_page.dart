import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:my_eyes/app/modules/products/products_store.dart';
import 'package:my_eyes/app/shareds/circular_button.dart';
import 'package:my_eyes/app/shareds/custom_bottom_navigation_bar.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodePage extends StatefulWidget {
  final String title;
  const QrCodePage({Key? key, this.title = 'ProfilePage'}) : super(key: key);
  @override
  QrCodePageState createState() => QrCodePageState();
}

class QrCodePageState extends State<QrCodePage> {
  ProductsStore store = Modular.get();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String lastReadCode = "";

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Theme.of(context).platform == TargetPlatform.android) {
      controller!.pauseCamera();
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: CustomColors.mainBlue,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) {
        setState(
          () async {
            if (scanData.code.toString().compareTo(lastReadCode) != 0) {
              await controller.pauseCamera();
              lastReadCode = scanData.code.toString();
              store.speak(scanData.code.toString()).then((value) {
                lastReadCode = "";
              });
              await Future.delayed(Duration(seconds: 1));
              await controller.resumeCamera();
            } else {
              await controller.pauseCamera();
              await Future.delayed(Duration(seconds: 1));
              await controller.resumeCamera();
            }
          },
        );
      },
    );
  }
}

class ProfileOptionTile extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Widget icon;
  const ProfileOptionTile({
    required this.onTap,
    required this.icon,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.raleway(
                color: CustomColors.mainBlue,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            icon
          ],
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black.withOpacity(.3),
            ),
          ),
        ),
      ),
    );
  }
}
