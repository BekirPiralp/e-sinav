import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bitir extends StatefulWidget {
  @override
  _BitirState createState() => _BitirState();
}

class _BitirState extends State<Bitir> {
  //değişkenler
  var data=[];
  //fonksiyonlar
  void onAnasayfa (){
    Navigator.pushNamed(context, "/");
  }
  //tanımlamalar
  @override
  Widget build(BuildContext context) {
    data=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(" S O N U Ç L A R"
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Text("e-Sınav", style: TextStyle(fontSize: 60) ,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text(
                  "Ad soyad: "+data[0].toString(),
                ),
                Text(
                  "Öğrenci no: "+data[1].toString(),
                ),
                Text(
                  "Puanınız: "+data[2].toString(),
                ),
                Text(
                  "Kullanılan toplam süre: "+data[3].toString(),
                ),

              ],
            ),

            ElevatedButton(
              // onPressed: (){
              //   Navigator.pushNamed(context, "/");
              // } ,
              onPressed: onAnasayfa,
                child:Text ("Anasayfaya Dön"),
            ),
          ],
        ),
      ),
    );
  }
}
