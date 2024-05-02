import 'package:flutter/material.dart';
import '../../data/model/bank.dart';
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
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
            body: Container(
              color: const Color.fromARGB(255, 243, 241, 241),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Chọn ngân hàng", style: titleStyle),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 7.0,
                          horizontal: 10.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                        labelText: "Tìm kiếm...",
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        suffixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(35, 10, 35, 20),
                      alignment: Alignment.center,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: lstBank.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 30,
                        ),
                        itemBuilder: (context, index) {
                          return itemBankView(lstBank[index], context);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
