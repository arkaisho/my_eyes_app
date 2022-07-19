import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_eyes/app/modules/home/home_store.dart';
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

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    _controller!.resumeCamera();
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
            onTap: () async {
              await _controller!.pauseCamera();
              await Modular.to.pushReplacementNamed("login");
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
      (scanData) async {
        if (scanData.code.toString().compareTo(store.lastReadCode) != 0 &&
            store.canReadAgain) {
          store.lastReadCode = scanData.code.toString();
          store.speak(scanData.code.toString());
        }
        store.lastReadedTime = DateTime.now();
      },
    );
  }
}
