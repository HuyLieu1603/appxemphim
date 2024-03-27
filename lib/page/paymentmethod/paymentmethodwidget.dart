import 'package:flutter/material.dart';
import '../../page/banklist/banklistwidget.dart';
import '../../page/onlinepayment/onlinepaymentwidget.dart';
import '../../config/const.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text("Chọn phương thức thanh toán", style: titleStyle),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                            "Chỉ cần vài bước là bạn sẽ hoàn tất!\nChúng tôi cũng chẳng thích thú gì với các loại giấy tờ",
                            style: backgroundtextStyle),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BankWidget()
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black, // Màu của text và icon
                        backgroundColor: Colors.white, // Màu nền của nút
                        fixedSize: const Size(75, 75),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ), // Màu và độ rộng của viền
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // Bo góc
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Căn các phần tử theo từng cạnh của hàng
                        children: [
                          Row(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Thẻ ngân hàng nội địa',
                                  textAlign: TextAlign.left,
                                  style: textStyle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Image.asset(
                                'assets/images/bank-logo-transparent-background.png',
                                width: 25,
                                height: 25,
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios), // Icon ở phía bên phải
                        ],
                      ),
                    ),
                    const SizedBox(height: 20), // Khoảng cách giữa các nút
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BankWidget()
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black, // Màu của text và icon
                        backgroundColor: Colors.white, // Màu nền của nút
                        fixedSize: const Size(75, 75),
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ), // Màu và độ rộng của viền
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // Bo góc
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Căn các phần tử theo từng cạnh của hàng
                        children: [
                          Row(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Ví điện tử',
                                  textAlign: TextAlign.left,
                                  style: textStyle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Image.asset(
                                'assets/images/Logo-MoMo-Square.webp',
                                width: 25,
                                height: 25,
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios), // Icon ở phía bên phải
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
