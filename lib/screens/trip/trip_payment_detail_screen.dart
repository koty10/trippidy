import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:trippidy/model/app/future_payment.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../../providers/trip_detail_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TripPaymentDetailScreen extends ConsumerStatefulWidget {
  const TripPaymentDetailScreen({super.key, required this.futurePayment});

  final FuturePayment futurePayment;
  static const routeName = '/tripPaymentDetailScreen';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TripPaymentDetailScreenState();
}

class _TripPaymentDetailScreenState extends ConsumerState<TripPaymentDetailScreen> {
  GlobalKey globalKey = GlobalKey();

  Future<void> _shareImage() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      Share.shareXFiles(
        [
          XFile.fromData(
            pngBytes,
            name: 'qr.png',
            mimeType: 'image/png',
          )
        ],
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Trip currentTrip = ref.watch(tripDetailControllerProvider);
    // var futurePayments = currentTrip.getFuturePayments();
    // var format = DateFormat("dd.MM.yyyy");
    var qrCodeData = QrCode.fromData(
        data: "SPD*1.0*ACC:CZ2806000000000168540115*AM:450.00*CC:CZK*MSG:PLATBA ZA ZBOZI*X-VS:1234567890", errorCorrectLevel: QrErrorCorrectLevel.L);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - detail platby"),
      ),
      body: Column(
        children: [
          Image.asset(
            "assets/images/future_payments.jpg",
            fit: BoxFit.cover,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Dlužník: ${widget.futurePayment.payer.userProfileFirstname} ${widget.futurePayment.payer.userProfileLastname}"),
                    Text("Příjemce: ${widget.futurePayment.payee.userProfileFirstname} ${widget.futurePayment.payee.userProfileLastname}"),
                    Text("Částka: ${widget.futurePayment.amount} Kč"),
                    const SizedBox(height: 8),
                    RepaintBoundary(
                      key: globalKey,
                      child: QrImageView.withQr(
                        qr: qrCodeData,
                        version: QrVersions.auto,
                        size: 200,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _shareImage();
                      },
                      child: const Text("Sdílet"),
                    )
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          //if (futurePayment.payer.userProfileId == ref.read(authControllerProvider.notifier).getUserId())
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  foregroundColor: Colors.green,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                child: const Text(
                  "Potvrdit zaplacení",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  ref.read(tripDetailControllerProvider.notifier).addCompletedTransaction(widget.futurePayment);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }
}
