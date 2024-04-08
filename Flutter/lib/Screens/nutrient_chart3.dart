import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:mysql_client/mysql_client.dart';

void main() {
  dbConnector("kakao:");

  runApp(const FigmaToCodeApp());
}

Future<void> dbConnector(String firebaseUid) async {
  print("Connecting to mysql server...");

  // MySQL 접속 설정
  final conn = await MySQLConnection.createConnection(
    host: 'database-4.cluster-cniyjmhourjo.ap-northeast-2.rds.amazonaws.com',
    port: 3306,
    userName: 'jaehoon',
    password: '3346639a',
    databaseName: 'django1', // optional
  );

  // 연결 대기
  await conn.connect();

  //##############################################################################################################

  //아래 uid 변수에 사용자 정보가 들어가야함
  var uid = 'kakao:3162463219';

  //##############################################################################################################

  print("Connected");

  //##############################################################################################################
// base syntax
  var result = await conn.execute(
      "SELECT product_id FROM basket2 WHERE firebase_uid = :firebase_uid",
      {"firebase_uid": uid});
  String? temp = '';

  List<String> products = []; //결과를 리스트로 저장하기 위해 빈 리스트를 만들어주자.
  for (final row in result.rows) {
    // // 행의 인덱스 정보 출력
    // print(row.colAt(0));
    temp = row.colAt(0);
    print(temp);

    products += temp!.split(","); // 쿼리 결과를 쉼표로 구분하여 리스트에 추가

    // 컬럼의 내용 출력. 이건 그냥 보기용임.
    // print(row.colByName("product_id"));

    // // 쿼리 실행 결과의 모든 내용 출력
    // print(row.assoc());
  }

  //아래 products가 실제 사용할 리스트.
  // print(products);
  int len = products.length;

// 변수를 리스트에 넣습니다.
  List<String> product = ['', '', '', '', '', '', '', '', '', ''];

// for문 안에서 리스트에 값을 할당합니다.
  for (int i = 0; i < len; i++) {
    // 값을 찾습니다.
    String value = products[i];
    // 리스트에 값을 할당합니다.
    product[i] = value;
  }

  print(product);
  print(product[0]);

//##############################################################################################################
  List<String> ingredient = [];
  for (int i = 0; i < len; i++) {
    var productId = product[i];
    var result2 = await conn.execute(
        "SELECT Product_Ingredient_Information FROM product WHERE product_id = :product_id",
        {"product_id": productId});
    for (final row2 in result2.rows) {
      print(row2.colAt(0));
    }
  }

  // 종료 대기
  await conn.close();
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: const [
          Iphone1415ProMax45(),
        ]),
      ),
    );
  }
}

class Iphone1415ProMax45 extends StatelessWidget {
  const Iphone1415ProMax45({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
