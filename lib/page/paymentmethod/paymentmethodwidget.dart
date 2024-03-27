import 'package:flutter/material.dart';
import '../../page/banklist/banklistwidget.dart';
import '../../page/onlinepayment/onlinepaymentwidget.dart';
import '../../config/const.dart';

class PaymentMethodWidget  extends StatelessWidget {
  const PaymentMethodWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Chọn phương thức thanh toán', style: titleStyle),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topCenter,
                child : Text("Chỉ cần vài bước là bạn sẽ hoàn tất!\nChúng tôi cũng chẳng thích thú gì với các loại giấy tờ", style: backgroundtextStyle),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BankWidget()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black, // Màu của text và icon
                        backgroundColor: Colors.white, // Màu nền của nút
                        side: const BorderSide(color: Colors.grey, width: 1), // Màu và độ rộng của viền
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Bo góc
                        ),
                      ),
                      child: const Text('Thẻ ngân hàng nội địa'),
                    ),
                    const SizedBox(height: 10), // Khoảng cách giữa các nút
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => onlinepaymentwidget()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black, // Màu của text và icon
                        backgroundColor: Colors.white, // Màu nền của nút
                        side: const BorderSide(color: Colors.grey, width: 1), // Màu và độ rộng của viền
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Bo góc
                        ),
                      ),
                      child: const Text('Ví điện tử'),
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
