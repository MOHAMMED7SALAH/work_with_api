import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

Future<Welcome> fetchAlbum() async {
  final response = await http
      .get(Uri.parse('https://mayaexpress.todeliver.co/api/getcolis/270'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Welcome.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    required this.idColis,
    required this.nomClient,
    required this.produit,
    this.codeBar,
    required this.adress,
    required this.wilaya,
    required this.tel,
    required this.idCom,
    required this.commune,
    required this.price,
    required this.shippingPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.qte,
    required this.remarque,
    required this.validation,
    required this.tmpValidation,
    required this.tmpSignaler,
    required this.signaler,
    this.idStats,
    required this.idHub,
    required this.wilayaId,
    required this.comunId,
    this.stopdesk,
    required this.idComs,
    required this.nomCom,
    required this.idClt,
    required this.confirmed,
    this.cloture,
    required this.confirmedUser,
  });

  int idColis;
  String nomClient;
  String produit;
  dynamic codeBar;
  String adress;
  String wilaya;
  String tel;
  int idCom;
  String commune;
  String price;
  String shippingPrice;
  DateTime createdAt;
  DateTime updatedAt;
  int qte;
  String remarque;
  int validation;
  int tmpValidation;
  int tmpSignaler;
  int signaler;
  dynamic idStats;
  int idHub;
  int wilayaId;
  int comunId;
  dynamic stopdesk;
  int idComs;
  String nomCom;
  int idClt;
  int confirmed;
  dynamic cloture;
  int confirmedUser;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idColis: json["id_colis"],
        nomClient: json["nom_client"],
        produit: json["produit"],
        codeBar: json["code_bar"],
        adress: json["adress"],
        wilaya: json["wilaya"],
        tel: json["tel"],
        idCom: json["id_com"],
        commune: json["commune"],
        price: json["price"],
        shippingPrice: json["shipping_price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        qte: json["qte"],
        remarque: json["remarque"],
        validation: json["validation"],
        tmpValidation: json["tmp_validation"],
        tmpSignaler: json["tmp_signaler"],
        signaler: json["signaler"],
        idStats: json["id_stats"],
        idHub: json["id_hub"],
        wilayaId: json["wilaya_id"],
        comunId: json["comun_id"],
        stopdesk: json["stopdesk"],
        idComs: json["id_coms"],
        nomCom: json["nom_com"],
        idClt: json["id_clt"],
        confirmed: json["confirmed"],
        cloture: json["cloture"],
        confirmedUser: json["confirmed_user"],
      );

  Map<String, dynamic> toJson() => {
        "id_colis": idColis,
        "nom_client": nomClient,
        "produit": produit,
        "code_bar": codeBar,
        "adress": adress,
        "wilaya": wilaya,
        "tel": tel,
        "id_com": idCom,
        "commune": commune,
        "price": price,
        "shipping_price": shippingPrice,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "qte": qte,
        "remarque": remarque,
        "validation": validation,
        "tmp_validation": tmpValidation,
        "tmp_signaler": tmpSignaler,
        "signaler": signaler,
        "id_stats": idStats,
        "id_hub": idHub,
        "wilaya_id": wilayaId,
        "comun_id": comunId,
        "stopdesk": stopdesk,
        "id_coms": idComs,
        "nom_com": nomCom,
        "id_clt": idClt,
        "confirmed": confirmed,
        "cloture": cloture,
        "confirmed_user": confirmedUser,
      };
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Welcome> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Welcome>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: 200,
                  width: 200,
                  child: Column(
                    children: [
                      Text(snapshot.data!.data[0].produit),
                      Text(snapshot.data!.data[0].commune),
                      Text(snapshot.data!.data[0].wilaya),
                      Text(snapshot.data!.data[0].nomClient),
                      Text('${snapshot.data!.data[0].tel}'),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
