import 'package:flutter/material.dart';
import 'package:appxemphim/data/model/account.dart';
import 'package:appxemphim/data/provider/accountprovider.dart';
import 'package:intl/intl.dart';
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
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/HUFLIX.png',
              width: 200,
              height: 80,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child : Center(
            child: Text(
              "Who's watching",
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
              padding: EdgeInsets.only(
                top: 25,
                bottom: 0,
                left: 65,
                right: 65,
              ),
              alignment: Alignment.center,
              child: GridView.builder(
                  itemCount: lstAccount.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
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