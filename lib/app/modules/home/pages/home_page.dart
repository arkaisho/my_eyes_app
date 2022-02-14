import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/modules/home/home_store.dart';
import 'package:my_eyes/app/shareds/circular_button.dart';
import 'package:my_eyes/app/shareds/custom_colors.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  HomeStore store = Modular.get();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;
  String lastReadCode = "";

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Theme.of(context).platform == TargetPlatform.android) {
      _controller!.pauseCamera();
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      _controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Text(
                  "Entrar",
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    color: CustomColors.mainBlack,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            onTap: () {
              Modular.to.pushReplacementNamed("login");
            },
          )
        ],
      ),
      body: Observer(
        builder: (context) => Column(
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
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this._controller = controller;
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
