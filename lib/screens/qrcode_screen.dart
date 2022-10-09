import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assessment_app/logic/home/home_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../widgets/qrscanner_overlay.dart';

class QRCodeScreen extends StatelessWidget {
  const QRCodeScreen({Key? key, required this.blocContext}) : super(key: key);

  final BuildContext blocContext;

  @override
  Widget build(BuildContext context) {
    MobileScannerController cameraController = MobileScannerController();

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  return const Icon(Icons.cameraswitch);
                },
              ),
              iconSize: 25.0,
              onPressed: () => cameraController.switchCamera(),
            ),
          ],
        ),
        body: Stack(
          children: [
            MobileScanner(
                allowDuplicates: false,
                controller: cameraController,
                onDetect: (barcode, args) {
                  if (barcode.rawValue == null) {
                    cameraController.stop();
                    cameraController.dispose();
                    debugPrint('Failed to scan Barcode');
                  } else {
                    cameraController.stop();
                    cameraController.dispose();
                    final String code = barcode.rawValue!;
                    BlocProvider.of<HomeBloc>(blocContext)
                        .add(VerifyCode(code));
                    Navigator.pop(context);
                  }
                }),
            QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
          ],
        ));
  }
}
