import 'package:flutter/material.dart';
import '../../data/model/bankmodel.dart';
import '../../data/provider/bankprovider.dart';
import 'banklistbody.dart';
import '../../config/const.dart';

class BankWidget extends StatefulWidget {
  const BankWidget({super.key});

  @override
  State<BankWidget> createState() => _BankWidgetState();
}

class _BankWidgetState extends State<BankWidget> {
  List<Bank> lstBank = [];
  Future<String> loadBankList() async {
    lstBank = await ReadData().loadData();
    return '';
  }

  @override 
  void initState() {
    super.initState();
    loadBankList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadBankList(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        return Center(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child : Text("Chọn ngân hàng", style: titleStyle),
                ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: GridView.builder(
                    shrinkWrap: true, // Ensure that the GridView takes only the space it needs
                    // physics: NeverScrollableScrollPhysics(), // Disable scrolling of the GridView
                    itemCount: lstBank.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 8,
                      ),
                    itemBuilder: (context, index) {
                    return itemBankView(lstBank[index]);
                    },
                  ),
                ),)
            ],
          ),
        );
      });
  }
}