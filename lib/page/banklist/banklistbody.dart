import 'package:appxemphim/data/API/api.dart';
import 'package:appxemphim/page/payment/paymentwidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/bank.dart';
import '../../config/const.dart';

class BankBuilder extends StatefulWidget {
  const BankBuilder({
    Key? key,
  }) : super(key: key);

  @override
  State<BankBuilder> createState() => _BankBuilderState();
}

class _BankBuilderState extends State<BankBuilder> {
  Future<List<Bank>> _getBank() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await APIResponsitory().getBank(
        prefs.getString('name').toString(), prefs.getString('img').toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Bank>>(
        future: _getBank(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
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
                        itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 30,
                        ),
                        itemBuilder: (context, index) {
                          final itemBank = snapshot.data![index];
                          return _buildBank(itemBank, context);
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
        });
  }
}

// Create sub Widget
Widget _buildBank(Bank itembank, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentWidget(
            objBank: itembank,
          ),
        ),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.network(
        itembank.img,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
      ),
    ),
  );
}
