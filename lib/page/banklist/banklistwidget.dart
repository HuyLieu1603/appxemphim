import 'package:flutter/material.dart';
import 'banklistbody.dart';

class BankWidget extends StatefulWidget {
  const BankWidget({super.key});

  @override
  State<BankWidget> createState() => _BankWidgetState();
}

class _BankWidgetState extends State<BankWidget> {
  @override
  Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.white,
            ),
            body: const Center(child: BankBuilder()),
          );
        }
  }
