import 'package:flutter/material.dart';
import '../data/model/account.dart';
import '../data/provider/accountprovider.dart';
import '../config/const.dart';

class settingWidget extends StatefulWidget {
  const settingWidget({super.key});

  @override
  State<settingWidget> createState() => _settingWidgetState();
}

class _settingWidgetState extends State<settingWidget> {
  List<AccountModel> Accounts = [];

  @override
  void initState() {
    super.initState();
    Accounts = createDataList(5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text(
          "Profiles & More",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Accounts.length,
                itemBuilder: (context, index) {
                  return accountListView(Accounts[index]);
                },
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Thông tin cá nhân",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget accountListView(AccountModel accountModel) {
  return Container(
    // grid without margin
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          url_img + accountModel.img!,
          height: 80,
          width: 80,
          errorBuilder: (context, error, StackTrace) => const Icon(Icons.image),
        ),
        Text(
          accountModel.name ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
