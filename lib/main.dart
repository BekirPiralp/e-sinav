import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hafta_6/bitir.dart';
import 'package:hafta_6/hakkinda.dart';
import 'package:hafta_6/sorular.dart';
import 'package:hafta_6/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: true,
      title: '18 Nisan 2021',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/main': (context) => MyHomePage(),
        '/sorular': (context) => Sorular(),
        '/bitir': (context) => Bitir(),
        '/hakkinda': (contex) => Hakkinda(),
      },
      home: MyHomePage(title: 'e - S ı n a v\t Bekir PİRALP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //değişkenler
  String adSoyad = '';
  String ogrNo = '';

  // fonksiyonlar
  void kontrol() {
    if ((adSoyad.length > 7) && (ogrNo.length == 9)) {
      var data = [];
      data.add(adSoyad);
      data.add(ogrNo);
      //Navigator.pushNamed(context, '/sorular');
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=> Sorular(),
        settings: RouteSettings(
          arguments: data,
        ),
      ),
      );
    } else {
      Navigator.pushNamed(context, '/hata');
    }
  }

  void _adSoyadKaydet(String text) {
    setState(() {
      adSoyad = text;
    });
  }

  void _ogrNoKaydet(String text) {
    setState(() {
      ogrNo = text;
    });
  }

  //tanımlar
  @override
  Widget build(BuildContext context) {
    bool butonpasif = true;
    if ((adSoyad.length > 7) && (ogrNo.length == 9)) {
      butonpasif = false;
    } else {
      butonpasif = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Adınız ve Soyadınız:"),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Adınız ve soyadınız",
                  hintText: "Lütfen giriş işlemini yapınız",
                  hintMaxLines: 1,

                ),
                maxLines: 1,
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter
                ],
                onChanged: (text){
                 _adSoyadKaydet(text);
                },
              ),
            ),
            Text("Öğrenci Numaranız:"),
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Öğrenci numaranız:",
                  hintText: "Lütfen giriniz",
                ),
                maxLength: 9,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (text){
                  _ogrNoKaydet(text);
                },
              ),
            ),
            ElevatedButton(
              //onPressed: () {},
              onPressed: butonpasif ? null : kontrol,
              child: Text(
                "Sınava Başla",
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Hakkinda()),
                  );
                },
                child: Text("Hakkında"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
