// ignore_for_file: unnecessary_import, duplicate_import, unused_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:appxemphim/data/model/account.dart';
import 'package:appxemphim/data/provider/accountprovider.dart';
import 'package:intl/intl.dart';
import '../config/const.dart';
import '../data/provider/accountprovider.dart';
import 'package:flutter/widgets.dart';

class OptionalAccount extends StatefulWidget {
  const OptionalAccount({Key? key});

  @override
  State<OptionalAccount> createState() => _OptionalAccountState();
}

class _OptionalAccountState extends State<OptionalAccount> {
  List<AccountModel> lstAccount = [];

  @override
  void initState() {
    super.initState();
    lstAccount = createDataList(5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        // toolbarHeight: 100,
        centerTitle: true,
        title: Container(
          child: Image.asset(
            'assets/images/HUFLIX.png',
            width: 200,
            height: 80,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              // Mốt làm lệnh cho nó truyển trang
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "Chọn tài khoản",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.fromLTRB(65, 0, 65, 0), //LTRB 65,25,65,0
              alignment: Alignment.center,
              child: GridView.builder(
                  itemCount: lstAccount.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                  ),
                  itemBuilder: (context, index) {
                    return itemGridView(lstAccount[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemGridView(AccountModel accountModel) {
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
            errorBuilder: (context, error, StackTrace) =>
                const Icon(Icons.image),
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
}
