import 'dart:developer';

import 'package:assessment_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assessment_app/logic/home/home_bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRCodeButton extends StatelessWidget {
  const QRCodeButton({Key? key, required this.blocContext}) : super(key: key);

  final BuildContext blocContext;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await FlutterBarcodeScanner.scanBarcode(
                  '#ff6666', 'Cancelar', true, ScanMode.QR)
              .then((barcodeScanRes) => BlocProvider.of<HomeBloc>(blocContext)
                  .add(VerifyCode(barcodeScanRes)));
        } on PlatformException {
          log("erro ao ler QR Code");
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: const Text("SCANEAR QR CODE",
          style: TextStyle(
              color: kBackground, fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}
