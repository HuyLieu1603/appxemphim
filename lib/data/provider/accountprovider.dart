import '../model/account.dart';

createDataList(int amount)
{
  List<AccountModel> lstAccount = [];
  for (int i=1  ; i<= amount ;i++)
  {
    lstAccount.add(AccountModel(
      id: i,
      name: "Account User number  $i",
      img: "img_$i.png",
    ));
  }
  return lstAccount;
}