import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hafta_6/bitir.dart';

class Sorular extends StatefulWidget {
  @override
  _SorularState createState() => _SorularState();
}

class _SorularState extends State<Sorular> {
  //değişkenler
  String adSoyad = '';
  String ogrNo = "";
  String mevcutcevap = '';
  int mevcutsoru = 0;
  int kullanilansure = 0;
  int puan = 0;
  var cevaplistesi = [];
  var sorular = [
    {
      'soru': 'Fatih Sultan Mehmet\'in babası kimdir?',
      'cevaplar': ['I. Mehmet', 'II. Murat', 'Yıldırım Beyazıt'],
      'dogrucevap': 'II. Murat'
    },
    {
      'soru': 'Hangi yabancı futbolcu Fenerbahçe forması giymiştir?',
      'cevaplar': ['Simoviç', 'Schumacher', 'Prekazi'],
      'dogrucevap': 'Schumacher'
    },
    {
      'soru': 'Magna Carta hangi ülkenin kralıyla yapılmış bir sözleşmedir?',
      'cevaplar': ['İngiltere', 'Fransa', 'İspanya'],
      'dogrucevap': 'İngiltere'
    },
    {
      'soru': 'Hangisi tarihteki Türk devletlerinden biri değildir?',
      'cevaplar': ['Avar Kağanlığı', 'Emevi Devleti', 'Hun İmparatorluğu'],
      'dogrucevap': 'Emevi Devleti'
    },
    {
      'soru': 'Hangi ülke Asya kıtasındadır?',
      'cevaplar': ['Madagaskar', 'Peru', 'Singapur'],
      'dogrucevap': 'Singapur'
    },
    {
      'soru':
          'ABD başkanlarından John Fitzgerald Kennedy’e suikast düzenleyerek öldüren kimdir?',
      'cevaplar': ['Lee Harvey Oswald', 'Clay Shaw', 'Jack Ruby'],
      'dogrucevap': 'Lee Harvey Oswald'
    },
    {
      'soru':
          'Aşağıdaki hangi Anadolu takımı Türkiye Süper Liginde şampiyon olmuştur?',
      'cevaplar': ['Kocaelispor', 'Bursaspor', 'Eskişehirspor'],
      'dogrucevap': 'Bursaspor'
    },
    {
      'soru': 'Hangisi Kanuni Sultan Süleyman’ın eşidir?',
      'cevaplar': ['Safiye Sultan', 'Kösem Sultan', 'Hürrem Sultan'],
      'dogrucevap': 'Hürrem Sultan'
    },
    {
      'soru': 'Hangi hayvan memeli değildir?',
      'cevaplar': ['Penguen', 'Yunus', 'Yarasa'],
      'dogrucevap': 'Penguen'
    },
    {
      'soru': 'Osmanlı’da Lale devri hangi padişah döneminde yaşamıştır?',
      'cevaplar': ['III. Ahmet', 'IV. Murat', 'III. Selim'],
      'dogrucevap': 'III. Ahmet'
    },
  ];

  Stopwatch _sayac;
  Timer _timer;

  //fonksiyonlar
  void kontrolEt() {
    if (mevcutcevap == sorular[mevcutsoru]['dogrucevap']) {
      puan = puan + 10;
      mevcutsoru++;
      kullanilansure = kullanilansure + _sayac.elapsedMilliseconds;
      _sayac.reset();
    } else {
      puan -= 10;
      mevcutsoru++;
      kullanilansure = kullanilansure + _sayac.elapsedMilliseconds;
      _sayac.reset();
    }
    if (mevcutsoru > 9) {
      mevcutsoru = 0;
      _timer.cancel();
      BitireYolla();
    }
  }

  void BitireYolla() {
    var data = [];
    data.add(adSoyad);
    data.add(ogrNo);
    data.add(puan.toString());
    data.add(zamaniFormatla(kullanilansure));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Bitir(),
        settings: RouteSettings(
          arguments: data,
        ),
      ),
    );
  }

  Widget soru(int sira) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            mevcutcevap = cevaplistesi[sira].toString();
          });
          kontrolEt();
        },
        child: Text(
          cevaplistesi[sira].toString(),
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  String zamaniFormatla(int milisaniye) {
    var saniye = milisaniye ~/ 1000; // tam sayı bölme işlemi
    var dakika = ((saniye % 3600) ~/ 60).toString().padLeft(2, '0');
    var saniyeler = (saniye % 60).toString().padLeft(2, '0');
    return "$dakika:$saniyeler";
  }

  @override
  void initState() {
    super.initState();
    _sayac = Stopwatch();
    _timer = new Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void dipose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //değişkenler
    var data = [];

    data = ModalRoute.of(context).settings.arguments;
    adSoyad = data[0];
    ogrNo = data[1];
    cevaplistesi = sorular[mevcutsoru]["cevaplar"];

    _sayac.start();
    if (_sayac.elapsedMilliseconds > 9999 && mevcutsoru < 9) {
      kullanilansure = kullanilansure + _sayac.elapsedMilliseconds;
      _sayac.reset(); //her 10 saniyede diğer soru
      mevcutsoru++;
    }
    if (mevcutsoru == 9 && _sayac.elapsedMilliseconds > 9999) {
      Future.delayed(Duration.zero, () async {
        _sayac.reset();
        _sayac.stop();
        _timer.cancel();
        mevcutsoru = 0;
        BitireYolla();
      });
    }

    // tanımlamalar
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sorular"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              "e-Sınav",
              style: TextStyle(fontSize: 40),
            ),
            Text(
              "Ad- Soyad: " + adSoyad,
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              "Öğrenci No: " + ogrNo,
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              "Mevcut Soru / Toplam Soru\n",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              mevcutsoru.toString() + "/" + sorular.length.toString(),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              sorular[mevcutsoru]["soru"].toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            soru(0),
            soru(1),
            soru(2),
            Text(
              zamaniFormatla(_sayac.elapsedMilliseconds),
              style: TextStyle(fontSize: 24.0),
            ),
            Text(
              "Kullanılan Süre: " + zamaniFormatla(kullanilansure),
              style: TextStyle(fontSize: 18.0),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Bitir()),
                  );
                });
              },
              child: Text("Bitir"),
            ),
          ],
        ),
      ),
    );
  }
}
