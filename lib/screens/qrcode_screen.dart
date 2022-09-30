import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assessment_app/logic/home/home_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeScreen extends StatelessWidget {
  const QRCodeScreen({Key? key, required this.blocContext}) : super(key: key);

  final BuildContext blocContext;

  @override
  Widget build(BuildContext context) {
    MobileScannerController cameraController = MobileScannerController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Scanear QR Code'),
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state as TorchState) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.white);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state as CameraFacing) {
                    case CameraFacing.front:
                      return const Icon(Icons.camera_front);
                    case CameraFacing.back:
                      return const Icon(Icons.camera_rear);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.switchCamera(),
            ),
          ],
        ),
        body: MobileScanner(
            allowDuplicates: false,
            controller: cameraController,
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                final String code = barcode.rawValue!;
                BlocProvider.of<HomeBloc>(blocContext).add(VerifyCode(code));
              }
            }));
  }
  // Widget build(BuildContext context) {
  //   return ElevatedButton(
  //     onPressed: () async {
  //       try {
  // await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'Cancelar', true, ScanMode.QR)
  //     .then((barcodeScanRes) => BlocProvider.of<HomeBloc>(blocContext)
  //         .add(VerifyCode(barcodeScanRes)));
  //       } on PlatformException {
  //         log("erro ao ler QR Code");
  //       }
  //     },
  //     style: ElevatedButton.styleFrom(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(30.0),
  //       ),
  //     ),
  //     child: const Text("SCANEAR QR CODE",
  //         style: TextStyle(
  //             color: kBackground, fontSize: 20, fontWeight: FontWeight.bold)),
  //   );
  // }
}
