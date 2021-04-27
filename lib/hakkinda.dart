import 'package:flutter/material.dart';

class Hakkinda extends StatefulWidget {
  @override
  _HakkindaState createState() => _HakkindaState();
}

class _HakkindaState extends State<Hakkinda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text("!!! << = Hakkında = >> !!!"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget> [
              Text("Bu uygulama Bekir PİRALP tarafından \nSelçuk Üniversitesi Mobil programlama dersi \nkapsamında yapılmıştır "
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:16.0),
                    child: ElevatedButton(onPressed: (){
                      Navigator.pushNamed(context, '/');
                    },
                      child: Text("Anasayfaya Dön"
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
