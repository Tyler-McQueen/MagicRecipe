import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeTest4 extends StatefulWidget {
  const BarcodeTest4({Key? key}) : super(key: key);
  @override
  State<BarcodeTest4> createState() => BarcodeTest4State();
}

class BarcodeTest4State extends State<BarcodeTest4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.rawValue!;

              debugPrint('Barcode found! $code');
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        content: Builder(
                          builder: (context) {
                            // Get available height and width of the build area of this widget. Make a choice depending on the size.
                            var height = MediaQuery.of(context).size.height;
                            var width = MediaQuery.of(context).size.width;

                            return Container(
                              height: height,
                              width: width,
                              child: Scaffold(
                                appBar:
                                    AppBar(title: const Text('Mobile Scanner')),
                                body: (Column(
                                  children: [Text('$code')],
                                )),
                              ),
                            );
                          },
                        ),
                      ));
            }
          }),
    );
  }
}
