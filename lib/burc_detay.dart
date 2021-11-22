import 'package:flutter/material.dart';
import 'package:flutter_burc_rehberi/burc_liste.dart';
import 'package:palette_generator/palette_generator.dart';

import 'models/burc.dart';

class BurcDetay extends StatefulWidget {

  int gelenIndex;

  BurcDetay(this.gelenIndex);

  @override
  _BurcDetayState createState() => _BurcDetayState();
}

class _BurcDetayState extends State<BurcDetay> {
  Burc secilenBurc;
  Color baskinRenk;
  Color yaziRenk;
  PaletteGenerator paletteGenerator;
  @override
  void initState() {
    super.initState();
    secilenBurc=BurcListesi.tumBurclar[widget.gelenIndex];
    baskinRengiBul();
    yaziRenginiBul();
  }
  void baskinRengiBul(){
    Future<PaletteGenerator> fPaletGenerator= PaletteGenerator.fromImageProvider(AssetImage("images/"+secilenBurc.burcBuyukResim));

    fPaletGenerator.then((value){
      paletteGenerator=value;
      setState(() {
        baskinRenk=paletteGenerator.darkMutedColor.color;
        yaziRenk=paletteGenerator.lightVibrantColor.color;
      });
    });
  }
  void yaziRenginiBul(){
    Future<PaletteGenerator> fPaletGenerator= PaletteGenerator.fromImageProvider(AssetImage("images/"+secilenBurc.burcBuyukResim));

    fPaletGenerator.then((value){
      paletteGenerator=value;
      setState(() {
        yaziRenk=paletteGenerator.lightVibrantColor.color;
        if(yaziRenk==null)
          yaziRenk=paletteGenerator.vibrantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        color: baskinRenk!= null ? baskinRenk:Colors.pink,
        child: CustomScrollView(
          primary: false,
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              primary: true,
              backgroundColor: baskinRenk!= null ? baskinRenk:Colors.pink,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset("images/"+secilenBurc.burcBuyukResim,fit: BoxFit.cover,),
                centerTitle: true,
                title: Text(secilenBurc.burcAdi+" Burcu ve Özellikleri"),
              ),

            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(secilenBurc.burcDetay,style: TextStyle(fontSize: 18, color: yaziRenk!= null ? yaziRenk:Colors.black),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
