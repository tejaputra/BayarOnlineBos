import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference accountCollection = Firestore.instance.collection('Account');
  final CollectionReference DataTransactionCollection = Firestore.instance.collection('Data Transaction');

  //user
  Future newUserData(String nickname,int saldo) async {
    return await accountCollection.document(uid).setData({
      'nickname': nickname,
      'saldo': saldo,
    });
  }
  Future<DocumentSnapshot> getData(String uid) async{
    return await accountCollection.document(uid).get();
  }

  Future<String> getDataNickname(String uid) async{
    DocumentSnapshot data = await accountCollection.document(uid).get();
    if (uid != null) {
      return data.data['nickname'];
    } else {
      return "empty";
    }
  }
  Future<String> getDataSaldo(String uid) async{
    DocumentSnapshot data = await accountCollection.document(uid).get();
    if (uid != null) {
      return data.data['saldo'].toString();
    } else {
      return "empty";
    }
  }

  Stream<QuerySnapshot> getStream() {
    return accountCollection.snapshots();
  }

  //isi saldo
  Future createSaldo(String uid,int saldo,String Bank,String rekening,int time) async {
    DocumentSnapshot data = await accountCollection.document(uid).get();

    //history isiSaldo
    await DataTransactionCollection.document(uid).collection("Isi Saldo").add({
      'bank': Bank,
      'rekening': rekening,
      'nominal': saldo,
      'time': time,
    });
    //penambahan saldo user
    return await accountCollection.document(uid).setData({
      'saldo': data.data['saldo'] + saldo,
    },merge: true);
  }

  //check saldo cukup atau tidak
  Future<bool> checkSaldo(String uid,int saldo) async {
    DocumentSnapshot data = await accountCollection.document(uid).get();
    int angka = data.data['saldo'];
    if (saldo > angka) {
      return false;
    } else {
      return true;
    }
  }

  //transfer
  Future createTransfer(String uid,String Bank,String rekening,int nominal,int time) async {
    DocumentSnapshot data = await accountCollection.document(uid).get();
    int angka = data.data['saldo'];
    await DataTransactionCollection.document(uid).collection("Transfer").add({
      'bank': Bank,
      'rekening': rekening,
      'nominal': nominal,
      'time': time,
    });
    //pengurangan saldo akun
    return await accountCollection.document(uid).setData({
        'saldo': data.data['saldo'] - nominal,
    },merge: true);
  }

  //pembayaran PLN
  Future createPLN(String uid,String nomorPLN,int nominal,int time) async {
    DocumentSnapshot data = await accountCollection.document(uid).get();
    int angka = data.data['saldo'];
    await DataTransactionCollection.document(uid).collection("PLN").add({
      'nomor_pln': nomorPLN,
      'nominal': nominal,
      'time': time,
    });
    //pengurangan saldo akun
    return await accountCollection.document(uid).setData({
      'saldo': data.data['saldo'] - nominal,
    },merge: true);
  }

  //pembayaran pulsa
  Future createPulsa(String uid,String kartu,String nomorKartu,int nominal,int time) async {
    DocumentSnapshot data = await accountCollection.document(uid).get();
    int angka = data.data['saldo'];
    await DataTransactionCollection.document(uid).collection("Pulsa").add({
      'kartu': kartu,
      'nomor_kartu': nomorKartu,
      'nominal': nominal,
      'time': time,
    });
    //pengurangan saldo akun
    return await accountCollection.document(uid).setData({
      'saldo': data.data['saldo'] - nominal,
    },merge: true);
  }

  //pembayaran Voucher Game
  Future createVoucherGame(String uid,String game,String idGame,int nominal,int time) async {
    DocumentSnapshot data = await accountCollection.document(uid).get();
    int angka = data.data['saldo'];
    await DataTransactionCollection.document(uid).collection("VoucherGame").add({
      'game': game,
      'id_game': idGame,
      'nominal': nominal,
      'time': time,
    });
    //pengurangan saldo akun
    return await accountCollection.document(uid).setData({
      'saldo': data.data['saldo'] - nominal,
    },merge: true);
  }

  //pembayaran BPJS
  Future createBPJS(String uid,String tipeBPJS,String noBPJS,int nominal,int time) async {
    DocumentSnapshot data = await accountCollection.document(uid).get();
    int angka = data.data['saldo'];
    await DataTransactionCollection.document(uid).collection("BPJS").add({
      'bpjs': tipeBPJS,
      'no_bpjs': noBPJS,
      'nominal': nominal,
      'time': time,
    });
    //pengurangan saldo akun
    return await accountCollection.document(uid).setData({
      'saldo': data.data['saldo'] - nominal,
    },merge: true);
  }

  Stream<QuerySnapshot> get user {
    return accountCollection.snapshots();
  }
}