import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sqflite/sqflite.dart';
import 'ad_helper.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'dart:math';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:countup/countup.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import "package:flutter/services.dart";

List<Widget> splashlist = [];
bool rbool = false;
bool kilitforearn = false;
int rcount = 3;

bool infoon = false;
double infotop = 0;
double infoleft = 0;
double infowidth = 0;
double infoheight = 0;

const double azalmiktar = 1.3;
const double maxlength = 140;
const double pi = 3.1415926535897932;

const double anglepay = 20;

const double offscreen = -500;
const String leftbrickimage = "images/walls/dwf.png";
const String rightbrickimage = "images/walls/dwf.png";
const String leftbrickimagesec = "images/walls/dwf.png";

const String basicenemyimage = "images/characters/enemyone.png";

const int telepsec = 500;
const rocketmovespeed = 4;

//

//

const int ballmovesec = 3;
const int brickfallmovesec = 20;
const int enemeymovesec = 30;
const int pickupmovesec = 30;
const int shootermovesec = 50;
const int rocketsec = 30;

const Color levelfour = Color(0xff1B262C);
const Color levelthree = Color(0xff444F5A);
const Color leveltwo = Color(0xffBBE1FA);
const Color levelone = Color(0xffBBE1FA);

const Color healtbarcolorfour = Colors.green;
const Color healtbarcolorthree = Colors.green;
const Color healtbarcolortwo = Colors.green;
const Color healtbarcolorone = Colors.green;

const double leftbrickleft = 0;
const double plantaleft = 0;

double screenwidth = 0;
double screenheight = 0;
double mainareawidth = 0;
double wallwidth = 0;

double charmaxwidth = 0;
double maincharwithsize = 0;

double shooterheight = charmaxwidth * 3;
double shooterwidth = charmaxwidth * 3;
double pickuponewidth = charmaxwidth / 2;
double pickuponeheight = charmaxwidth / 2;
double powerheight = charmaxwidth / 2;
double powerwidth = charmaxwidth / 2;
double enemyonewidth = charmaxwidth;
double enemyoneheight = charmaxwidth;
double laserwidth = charmaxwidth;
double rocketwidth = charmaxwidth;
double healthbarheight = charmaxwidth;
double telepwidth = charmaxwidth * 3;
double betheight = charmaxwidth * 3;
double bethheight = charmaxwidth * 3;
double beoheight = charmaxwidth * 3;
double beowidth = charmaxwidth * 3;
double bethwidth = charmaxwidth * 3;
double betwidth = charmaxwidth * 3;
double cewidth = charmaxwidth * 3;
double ceheight = charmaxwidth * 3;
double dropmoneywidth = charmaxwidth / 2;
double dropmoneyheight = charmaxwidth / 2;
double ijheight = charmaxwidth * 2;
double ijwidth = charmaxwidth * 2;
double imheight = charmaxwidth * 3;
double imwidth = charmaxwidth * 3;
double arrowsize = charmaxwidth;
double shieldheight = charmaxwidth * 2;
double shieldwidth = charmaxwidth * 2;
double lfwidth = charmaxwidth * 6;
double lwidth = charmaxwidth * 6;
double aimheightone = charmaxwidth * 2;
double aimheighttwo = charmaxwidth * 2;
double aimheightthree = charmaxwidth * 2;
double exphighttwo = charmaxwidth * 4;
double expwidthtwo = charmaxwidth * 4;
double expwidththree = charmaxwidth * 4;
double exphightthree = charmaxwidth * 4;
double expwidthone = charmaxwidth * 4;
double exphightone = charmaxwidth * 4;
double rightbrickheight = charmaxwidth * 2;
double leftbrickheight = charmaxwidth * 2;
double leftbrickheightsec = charmaxwidth * 2;
double snhsize = (charmaxwidth * 10) / 10;
double moneytop = charmaxwidth * 1 / 3;
double animatedshooterheight = charmaxwidth * 3;

const double anirot = -1 * (pi / 6);

Future<void> main() async {
  FlutterView? flutterView = PlatformDispatcher.instance.views.firstOrNull;
  if (flutterView == null || flutterView.physicalSize.isEmpty) {
    PlatformDispatcher.instance.onMetricsChanged = () {
      flutterView = PlatformDispatcher.instance.views.firstOrNull;
      if (flutterView != null && !flutterView!.physicalSize.isEmpty) {
        PlatformDispatcher.instance.onMetricsChanged = null;
        runApp(MyApp(view: flutterView));
      }
    };
  } else {
    runApp(MyApp(view: flutterView));
  }
}
//void main() {
//  runApp(const MyApp());
//}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.view,
  }) : super(key: key);

  final FlutterView? view;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(view: view),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.view,
  }) : super(key: key);

  final FlutterView? view;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  late Database database;

  asyncFunc() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + "/finaldata.db";

    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Head(id INTEGER PRIMARY KEY, name TEXT, value INTEGER)');
      await db.execute(
          'CREATE TABLE DYH(id INTEGER PRIMARY KEY, name TEXT, value INTEGER)');
      await db.execute(
          'CREATE TABLE LH(id INTEGER PRIMARY KEY, name TEXT, bir TEXT, iki TEXT, uc TEXT, dort TEXT, bes TEXT, alti TEXT, yedi TEXT, sekiz TEXT, dokuz TEXT, ten TEXT)');
      await db.execute(
          'CREATE TABLE HighScores(id INTEGER PRIMARY KEY, name TEXT, bir INTEGER, iki INTEGER, uc INTEGER, dort INTEGER, bes INTEGER, alti INTEGER, yedi INTEGER, sekiz INTEGER, dokuz INTEGER, ten INTEGER)');

      await db.transaction((txn) async {
        int id1 = await txn
            .rawInsert('INSERT INTO Head(name,value) VALUES("Coin",0)');
        int id2 = await txn
            .rawInsert('INSERT INTO Head(name,value) VALUES("Emerald",0)');
        int id3 = await txn.rawInsert(
            'INSERT INTO LH(name,bir,iki,uc,dort,bes,alti,yedi,sekiz,dokuz,ten) VALUES("flags","images/flags/withouteyes/china.png","images/flags/withouteyes/india.png","images/flags/withouteyes/usa.png", "images/flags/withouteyes/egypt.png", "images/flags/withouteyes/kanada.png", "images/flags/withouteyes/spain.png", "images/flags/withouteyes/japon.png", "images/flags/withouteyes/mexico.png" , "images/flags/small/off.png", "images/flags/withouteyes/arab.png")');
        int id4 = await txn.rawInsert(
            'INSERT INTO LH(name,bir,iki,uc,dort,bes,alti,yedi,sekiz,dokuz,ten) VALUES("names", "CHAMPION", "KING", "MASTER", "Pro" , "Captain", "Soldier", "rookie", "noob", "your record", "kitten")');
        int id5 = await txn.rawInsert(
            'INSERT INTO HighScores(name,bir,iki,uc,dort,bes,alti,yedi,sekiz,dokuz,ten) VALUES("scores", 1000, 500, 250, 100 , 50, 20, 10, 5, 0, 0)');
        int b1 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhskillone",0)');
        int b2 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhskilltwo",0)');
        int b3 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhskillthree",0)');
        int b4 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhskillfour",0)');
        int b5 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhmc",1)');
        int b6 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhmedic",0)');
        int b7 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyharmor",0)');
        int b8 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyheng",0)');
        int b9 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhmage",0)');
        int b10 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhpirate",0)');
        int b11 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhfinal",0)');
        int b12 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhattack",0)');
        int b13 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhcenter",0)');
        int b14 = await txn.rawInsert(
            'INSERT INTO DYH(name,value) VALUES("dyhelectrickattack",0)');
        int b15 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhexp",0)');
        int b16 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhfireattack",0)');
        int b17 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhhealth",0)');
        int b18 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhshield",0)');
        int b19 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhjump",0)');
        int b20 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhtime",0)');
        int b21 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhwallbreak",0)');
        int b22 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhof",1)');
        int b23 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhafr",0)');
        int b24 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyharb",0)');
        int b25 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyharg",0)');
        int b26 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhaus",0)');
        int b27 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhban",0)');
        int b28 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhbre",0)');
        int b29 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhcan",0)');
        int b30 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhchn",0)');
        int b31 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhegy",0)');
        int b32 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhend",0)');
        int b33 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhing",0)');
        int b34 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyheur",0)');
        int b35 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhfre",0)');
        int b36 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhger",0)');
        int b37 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhind",0)');
        int b38 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhitl",0)');
        int b39 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhjpn",0)');
        int b40 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhkor",0)');
        int b41 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhmex",0)');
        int b42 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhpak",0)');
        int b43 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhrus",0)');
        int b44 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhspa",0)');
        int b45 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhtur",0)');
        int b46 = await txn
            .rawInsert('INSERT INTO DYH(name,value) VALUES("dyhusa",0)');
      });
    });

    List<Map> list = await database.rawQuery('SELECT * FROM Head');
    List<Map> listiki = await database.rawQuery('SELECT * FROM LH');
    List<Map> listuc = await database.rawQuery('SELECT * FROM HighScores');
    List<Map> listdort = await database.rawQuery('SELECT * FROM DYH');

    c(xd) {
      if (xd == 1) {
        return true;
      } else {
        return false;
      }
    }

    setState(() {
      doyouhaveskillone = c(listdort[0]["value"]);
      doyouhaveskilltwo = c(listdort[1]["value"]);
      doyouhaveskillthree = c(listdort[2]["value"]);
      doyouhaveskillfour = c(listdort[3]["value"]);

      doyouhavemc = c(listdort[4]["value"]);
      doyouhavemedic = c(listdort[5]["value"]);
      doyouhavearmor = c(listdort[6]["value"]);
      doyouhaveeng = c(listdort[7]["value"]);
      doyouhavemage = c(listdort[8]["value"]);
      doyouhavepirate = c(listdort[9]["value"]);
      doyouhavefinal = c(listdort[10]["value"]);

      doyouhaveattack = c(listdort[11]["value"]);
      doyouhavecenter = c(listdort[12]["value"]);
      doyouhaveelectrickattack = c(listdort[13]["value"]);
      doyouhaveexp = c(listdort[14]["value"]);
      doyouhavefireattack = c(listdort[15]["value"]);
      doyouhavehealth = c(listdort[16]["value"]);
      doyouhaveshield = c(listdort[17]["value"]);
      doyouhavejump = c(listdort[18]["value"]);
      doyouhavetime = c(listdort[19]["value"]);
      doyouhavewallbreak = c(listdort[20]["value"]);

      doyouhaveof = c(listdort[21]["value"]);
      doyouhaveafr = c(listdort[22]["value"]);
      doyouhavearb = c(listdort[23]["value"]);
      doyouhavearg = c(listdort[24]["value"]);
      doyouhaveaus = c(listdort[25]["value"]);
      doyouhaveban = c(listdort[26]["value"]);
      doyouhavebre = c(listdort[27]["value"]);
      doyouhavecan = c(listdort[28]["value"]);
      doyouhavechn = c(listdort[29]["value"]);
      doyouhaveegy = c(listdort[30]["value"]);
      doyouhaveend = c(listdort[31]["value"]);
      doyouhaveing = c(listdort[32]["value"]);
      doyouhaveeur = c(listdort[33]["value"]);
      doyouhavefre = c(listdort[34]["value"]);
      doyouhaveger = c(listdort[35]["value"]);
      doyouhaveind = c(listdort[36]["value"]);
      doyouhaveitl = c(listdort[37]["value"]);
      doyouhavejpn = c(listdort[38]["value"]);
      doyouhavekor = c(listdort[39]["value"]);
      doyouhavemex = c(listdort[40]["value"]);
      doyouhavepak = c(listdort[41]["value"]);
      doyouhaverus = c(listdort[42]["value"]);
      doyouhavespa = c(listdort[43]["value"]);
      doyouhavetur = c(listdort[44]["value"]);
      doyouhaveusa = c(listdort[45]["value"]);

      money = list[0]["value"];
      emerald = list[1]["value"];

      highscores = [
        listuc[0]["bir"],
        listuc[0]["iki"],
        listuc[0]["uc"],
        listuc[0]["dort"],
        listuc[0]["bes"],
        listuc[0]["alti"],
        listuc[0]["yedi"],
        listuc[0]["sekiz"],
        listuc[0]["dokuz"],
        listuc[0]["ten"], // 9
      ];

      highscoreflags = [
        listiki[0]["bir"],
        listiki[0]["iki"],
        listiki[0]["uc"],
        listiki[0]["dort"],
        listiki[0]["bes"],
        listiki[0]["alti"],
        listiki[0]["yedi"],
        listiki[0]["sekiz"],
        listiki[0]["dokuz"],
        listiki[0]["ten"],
      ];

      highscorenames = [
        listiki[1]["bir"],
        listiki[1]["iki"],
        listiki[1]["uc"],
        listiki[1]["dort"],
        listiki[1]["bes"],
        listiki[1]["alti"],
        listiki[1]["yedi"],
        listiki[1]["sekiz"],
        listiki[1]["dokuz"],
        listiki[1]["ten"],
      ];
    });
    setState(() {
      topscorefunc();
      playerscorefunc();
    });
  }

  void initState() {
    // TODO: implement initState
    screenheight =
        (widget.view!.physicalSize / widget.view!.devicePixelRatio).height;
    screenwidth =
        (widget.view!.physicalSize / widget.view!.devicePixelRatio).width;
    mainareawidth = ((screenwidth / 10) * 7);
    wallwidth = ((screenwidth / 10) * 1.5);
    charmaxwidth = screenwidth / 9;
    maincharwithsize = charmaxwidth;

    shooterheight = charmaxwidth * 3;
    shooterwidth = charmaxwidth * 3;
    pickuponewidth = charmaxwidth / 2;
    pickuponeheight = charmaxwidth / 2;
    powerheight = charmaxwidth / 2;
    powerwidth = charmaxwidth / 2;
    enemyonewidth = charmaxwidth;
    enemyoneheight = charmaxwidth;
    laserwidth = charmaxwidth;
    rocketwidth = charmaxwidth;
    healthbarheight = charmaxwidth;
    telepwidth = charmaxwidth * 3;
    betheight = charmaxwidth * 3;
    bethheight = charmaxwidth * 3;
    beoheight = charmaxwidth * 3;
    beowidth = charmaxwidth * 3;
    bethwidth = charmaxwidth * 3;
    betwidth = charmaxwidth * 3;
    cewidth = charmaxwidth * 3;
    ceheight = charmaxwidth * 3;
    dropmoneywidth = charmaxwidth / 2;
    dropmoneyheight = charmaxwidth / 2;
    ijheight = charmaxwidth * 2;
    ijwidth = charmaxwidth * 2;
    imheight = charmaxwidth * 3;
    imwidth = charmaxwidth * 3;
    arrowsize = charmaxwidth;
    shieldheight = charmaxwidth * 2;
    shieldwidth = charmaxwidth * 2;
    lfwidth = charmaxwidth * 6;
    lwidth = charmaxwidth * 6;
    aimheightone = charmaxwidth * 2;
    aimheighttwo = charmaxwidth * 2;
    aimheightthree = charmaxwidth * 2;
    exphighttwo = charmaxwidth * 4;
    expwidthtwo = charmaxwidth * 4;
    expwidththree = charmaxwidth * 4;
    exphightthree = charmaxwidth * 4;
    expwidthone = charmaxwidth * 4;
    exphightone = charmaxwidth * 4;
    rightbrickheight = charmaxwidth * 2;
    leftbrickheight = charmaxwidth * 2;
    leftbrickheightsec = charmaxwidth * 2;
    snhsize = (charmaxwidth * 10) / 10;
    moneytop = charmaxwidth * 1 / 3;
    animatedshooterheight = charmaxwidth * 3;

    snhheight = 0;
    aimwidthone = 0;
    aimwidthtwo = 0;
    aimwidththree = 0;

    asyncFunc();

    backwalltop = 0;
    backwalltopsec = -1 * screenheight;
    sidewallbackuptwotop = -1 * (wallwidth * 4000 / 479);
    sidewallbackuptop = -1 * (wallwidth * 2000 / 479);
    sidewallonetop = 0;
    sidewalltwotop = wallwidth * 2000 / 479;
    sidewallthreetop = wallwidth * 4000 / 479;
    startbuttonwidth = mainareawidth;
    startbuttonheight = screenheight;
    startbuttonleft = mainareawidth / 2 - startbuttonwidth / 2;
    shopwidth = (mainareawidth * 8) / 10;
    shopleft = (mainareawidth / 2) - (shopwidth / 2);
    snhleft = mainareawidth / 10;
    snhtop = (screenheight / 4) + (mainareawidth * 9 / 10) + (charmaxwidth);
    snhwidth = mainareawidth * 8 / 10;
    healthbarleft = (mainareawidth / 2) - (healthbarheight * 2);
    frametopleft = -(mainareawidth);
    framebottomleft = mainareawidth;
    snwidth = (mainareawidth * 6) / 10;
    snleft = (mainareawidth / 2) - (snwidth / 2);
    leftleft = -wallwidth;
    shooterleft = mainareawidth / 2 - shooterwidth / 2;
    animatedshootertop = screenheight * 3 / 2;
    frameoneleft = -((screenheight * 250 / 2000) + 100);
    rightleft = wallwidth;
    frametwoleft = mainareawidth + 100;
    sntop = screenheight / 4;

    rwidth = mainareawidth * 8 / 10;
    rheight = mainareawidth * 8 / 10;
    rleft = mainareawidth / 2 - rwidth / 2;
    rtop = screenheight / 2 - rheight / 2;

    enemyoneleft = mainareawidth / 2 - enemyonewidth / 2;
    rightbrickwidth = (mainareawidth / 6);
    leftbrickwidth = (mainareawidth / 6);
    newleftbrickwidth = (mainareawidth / 6);
    leftbrickheightsec = newleftbrickwidth * 76 / 140;
    leftbrickwidthsec = newleftbrickwidth;
    leftbrickleftsec = (mainareawidth / 2) - (newleftbrickwidth / 2);

    rightbrickheight = rightbrickwidth * 76 / 140;
    leftbrickheightsec = leftbrickwidthsec * 76 / 140;
    leftbrickheight = leftbrickwidth * 76 / 140;
    rightbrickleft = mainareawidth - rightbrickwidth;
    brickformations(Random().nextInt(3) + 1);

    bossheight = charmaxwidth * 3;
    bosswidth = charmaxwidth * 3;
    bossleft = (mainareawidth / 2) - (bosswidth / 2);

    handwidth = charmaxwidth;
    handheight = charmaxwidth;
    handleft = mainareawidth / 2 - handwidth / 2;
    handtop = -200;

    gfwidth = charmaxwidth;
    gfheight = charmaxwidth;
    gfleft = -800;
    gftop = (screenheight / 2) - charmaxwidth / 2;

    infoheight = screenheight * 7 / 10;
    infowidth = screenwidth * 8 / 10;
    infotop = screenheight / 2 - infoheight / 2;
    infoleft = screenwidth / 2 - infowidth / 2;

    //
    zort += 1;
    mcanitop = screenheight + 100;

    super.initState();
    FlameAudio.audioCache.loadAll([
      'birak.wav',
      'cek.mp3',
      'damage.mp3',
      'dokunma.wav',
      'mage.wav',
      'unlock.wav',
      'use.wav'
    ]);
    FlameAudio.bgm.play('DRIVE.mp3', volume: .25);

    try {
      WidgetsBinding.instance.addPostFrameCallback((x) {
        getcurrentpos();
      });
      // ignore: empty_catches
    } catch (e) {}
    _initGoogleMobileAds();
    _loadInterstitialAd();
    _loadRewardedAd();
  }

  bool ismusicon = true;

  RewardedAd? _rewardedAd;
  InterstitialAd? _interstitialAd;
  @override
  void dispose() {
    FlameAudio.bgm.dispose();
    _rewardedAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  // TODO: Add _rewardedAd

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
            },
          );

          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          //print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  // TODO: Implement _loadRewardedAd()
  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              setState(() {
                ad.dispose();
                _rewardedAd = null;
              });
              _loadRewardedAd();
            },
          );

          setState(() {
            _rewardedAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          //print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  bool candamage = true;

  int xad = 0;

  double deathcount = 0;

  bool rbool = false;
  double rwidth = 0;
  double rheight = 0;
  double rtop = 0;
  double rleft = -500;

  bool aimbool = false;

  //
  bool isgameshakeon = false;

  List<bool> isSelected = <bool>[true, false];

  Offset laseroffset = const Offset(0, 0);
  late Offset scorepos;
  Offset arrowsecoffset = const Offset(15, 0);
  //late Offset whitepos;
  late Offset movestartpos;
  Offset currentpos = const Offset(0, 0);
  //
  late Timer mover;
  late Timer brick;
  late Timer looker;
  late Timer walldroper;
  late Timer shootertimer;
  late Timer arrowtimer;
  //
  //GlobalKey startposkey = GlobalKey();
  //GlobalKey key = GlobalKey();
  GlobalKey dragablekey = GlobalKey();
  //

  bool ismcinuse = true;
  bool ismedicinuse = false;
  bool isenginuse = false;
  bool isarmorinuse = false;
  bool ismageinuse = false;
  bool ispirateinuse = false;
  bool isfinalinuse = false;
//
  int emerald = 0;
  int money = 0;
  String mcflag = "images/flags/small/off.png";

//

//
//

  String choosenvariat = "";

  String usedskincopy = "";
  String usedskinbigcopy = "";

  String choosenskin = "images/characters/skins/skinnormal/mc.png";
  String choosenskinbig = "images/characters/skins/skinbig/mccb.png";

  String usedskin = "images/characters/skins/skinnormal/mc.png";
  String usedskinbig = "images/characters/skins/skinbig/mccb.png";

  String usedflag = "images/flags/small/off.png";
  String usedflagwe = "images/flags/small/off.png";
  String usedflagbig = "images/characters/skins/skinbig/mccb.png";

//
  String skillone = "images/buttons/holder.png";
  String skilltwo = "images/buttons/holder.png";
  String skillthree = "images/buttons/holder.png";
  String skillfour = "images/buttons/holder.png";
//

  double minsinir = 1;
  double sinir = 1;

  bool doyouhaveskillone = false;
  bool doyouhaveskilltwo = false;
  bool doyouhaveskillthree = false;
  bool doyouhaveskillfour = false;

  bool doyouhavemc = true;
  bool doyouhavemedic = false;
  bool doyouhavearmor = false;
  bool doyouhaveeng = false;
  bool doyouhavemage = false;
  bool doyouhavepirate = false;
  bool doyouhavefinal = false;

  bool doyouhaveattack = false;
  bool doyouhavecenter = false;
  bool doyouhaveelectrickattack = false;
  bool doyouhaveexp = false;
  bool doyouhavefireattack = false;
  bool doyouhavehealth = false;
  bool doyouhaveshield = false;
  bool doyouhavejump = false;
  bool doyouhavetime = false;
  bool doyouhavewallbreak = false;

  bool doyouhaveof = true;
  bool doyouhaveafr = false;
  bool doyouhavearb = false;
  bool doyouhavearg = false;
  bool doyouhaveaus = false;
  bool doyouhaveban = false;
  bool doyouhavebre = false;
  bool doyouhavecan = false;
  bool doyouhavechn = false;
  bool doyouhaveegy = false;
  bool doyouhaveend = false;
  bool doyouhaveing = false;
  bool doyouhaveeur = false;
  bool doyouhavefre = false;
  bool doyouhaveger = false;
  bool doyouhaveind = false;
  bool doyouhaveitl = false;
  bool doyouhavejpn = false;
  bool doyouhavekor = false;
  bool doyouhavemex = false;
  bool doyouhavepak = false;
  bool doyouhaverus = false;
  bool doyouhavespa = false;
  bool doyouhavetur = false;
  bool doyouhaveusa = false;

  bool firstcol = false;

  bool isofinuse = true;
  bool isafrinuse = false;
  bool isarbinuse = false;
  bool isarginuse = false;
  bool isausinuse = false;
  bool isbaninuse = false;
  bool isbreinuse = false;
  bool iscaninuse = false;
  bool ischninuse = false;
  bool isegyinuse = false;
  bool isendinuse = false;
  bool isinginuse = false;
  bool iseurinuse = false;
  bool isfrainuse = false;
  bool isgerinuse = false;
  bool isindinuse = false;
  bool isitlinuse = false;
  bool isjpninuse = false;
  bool iskorinuse = false;
  bool ismexinuse = false;
  bool ispakinuse = false;
  bool isrussinuse = false;
  bool isspasinuse = false;
  bool isusainuse = false;
  bool isturinuse = false;

  void emeraldup() {
    setState(() {
      emerald += Random().nextInt(3) + 1;
      updateemerald(emerald);
    });
  }

  double sidewallbackuptwotop = 0;
  double sidewallbackuptop = 0;
  double sidewallonetop = 0;
  double sidewalltwotop = 0;
  double sidewallthreetop = 0;

  double shoptop = 0;
  double shopleft = 0;
  double shopwidth = 0;
  double shopheight = 0;

  double azalmiktar = 1.3;
  double confetitop = 0;
  double mesafe = 0;
  double throwangle = 0;
  double mainbodytopson = 0;
  double mainbodytopilk = 0;
  double mainbodytop = -100;
  double mainbodyleft = -100;
  double normalspeed = 1;
  double pickupmovespeed = 1;
  double shootermovespeed = 0.01;
  double yercekimietkisi = 0;
  double mainbodyleftafterrelase = 0;

  double coinexpwidth = 0;

  double healthbarwidth = 0;

  double scoreleft = -500;
  double scoretop = -500;
  double healthbartop = -500;
  double healthbarleft = 0;

  double newleftbrickwidth = 0;
  double leftshift = 0;
  double newrightbrickwidth = 0;
  double shift = 0;
  double sincount = 0;
  double coscount = 0;
  double charangle = 0;

  double frameoneleft = 0;
  double frametwoleft = 0;
  double frametopleft = 0;
  double framebottomleft = 0;
  double ponecollisionx = 0;
  double ponecollisiony = 0;
  double collisionx = 0;
  double collisiony = 0;
  double cornerDistancesq = 0;
  double hitpointx = 0;
  double hitpointy = 0;
  double circleDistancex = 0;
  double circleDistancey = 0;
  double startbuttontop = 0;
  double startbuttonleft = 0;
  double startbuttonwidth = 0;
  double startbuttonheight = 0;
  double buttonwidth = 0;

  double snwidth = 0;
  double snheight = 0;
  double snleft = 0;
  double sntop = -500;
  double snhwidth = 0;
  double snhheight = 0;
  double snhleft = 0;
  double snhtop = -500;
  double previousscore = 0;
  double animimageop = 0.0;
  double splashfinalwidth = 2000;
  double splashfinalwidthsec = 200;
  double splashtop = -500;

  bool jumpsplash = true;
  double jumpslashtop = -500;
  double jumpslashleft = 0;
  double jumpslashwidth = 0;
  double jumpslashheight = 0;
  double jumpslashfinalwidth = 0;

  double splashleft = -500;
  double medealm = 0;
  double congm = -500;
  double maincharrot = 0;

  double leftleft = 0;
  double rightleft = 0;

  double spbwidth = 0;
  double spbheight = 0;
  double backwalltop = 0;
  double backwalltopsec = 0;
  double shinetop = 0;
  double powercoscount = 0;
  double powercollisiony = 0;
  double powercollisionx = 0;
  double powerrot = 0;
  double healthrot = 0;
  double snhop = 0;

  int m = 500;
  bool oneatshot = false;
  bool twoatshot = false;
  bool threeatshot = false;

  double containeroneheight = 0;
  double containertwoheight = 0;
  //
  String ballstuckpos = "";
  String shooterimage = "images/shooterfolder/ss4.png";
  String startbuttontext = "▶";

  String centerbuttonimage = "images/buttons/on/centeron.png";
  String attackbuttonimage = "images/buttons/on/attackon.png";
  String wallbreakbuttonimage = "images/buttons/on/wallbreakon.png";
  String jumpbuttonimage = "images/buttons/on/jumpon.png";
  String timebuttonimage = "images/buttons/on/timeon.png";
  String shieldbuttonimage = "images/buttons/on/shieldon.png";
  String healthbuttonimage = "images/buttons/on/healthon.png";
  String electrickattackbuttonimage = "images/buttons/on/electricattackon.png";
  String fireattackbuttonimage = "images/buttons/on/fireattackon.png";
  String expbuttonimage = "images/buttons/on/expon.png";

  String highscoreann = "3";
  //
  int snend = 0;
  int maxdrag = 2;
  int howmanydragged = 0;

  bool lasershake = false;

  int sira = 0;
  int scoresira = 0;
  int zort = 0;
  int rightspawnpoint = 0;
  int score = 0;
  int bounce = 1;
  int rand = 0;
  bool btbool = false;
  bool jumpbool = false;
  int manueltimer = 0;
  int moneynew = 0;
  int custommesafe = 0;
  int timestopcount = 0;
  int r = 0;
  int healthcount = 4;
  int walldropcount = 0;
  int shootloadcount = 0;

  //
  bool animatefinishln = false;
  bool telepanimate = false;
  bool telepbool = true;
  bool canmainbutton = true;
  bool starbool = true;
  bool wallopen = false;
  bool ingamestart = true;
  bool spbanim = true;
  bool doespowerhit = false;
  bool rocketcanspawn = true;
  bool firstkilit = true;
  bool secondkilit = true;
  bool thirdkilit = true;
  bool isondrop = false;
  bool firstbar = true;
  bool secondbar = true;
  bool thirdbar = true;
  bool fourthbar = true;
  bool canshake = false;
  bool canjump = true;
  bool cancenter = true;
  bool canattack = true;
  bool canelecattack = true;
  bool canfireattack = true;
  bool canexp = true;
  bool canhealth = true;
  bool canshield = true;
  bool cantime = true;
  bool canwallbreak = true;
  bool cong = false;
  bool canann = true;
  bool canpowerspawn = true;
  bool startkilit = true;
  bool coutc = false;
  bool kilit = false;
  bool enemycanspawn = true;
  bool pickupcanspawn = true;
  bool ispickuphit = false;
  bool ishit = false;
  bool islasershot = false;
  bool freemove = true;
  bool opening = false;
  bool highanncontrolle = true;
  bool candoit = true;
  bool isanimationfinished = true;
  bool splash = true;
  bool canclick = false;
  bool loadzero = true;
  bool loadone = true;
  bool loadtwo = true;
  bool loadthree = true;
  bool loadfour = true;
  bool loadfive = true;
  bool coinexplode = false;
  bool canmove = true;
  bool ismoving = false;
  bool isonwall = false;
  bool isleftstarted = true;
  bool onbottom = false;
  bool isleftstartedsec = true;
  bool rightstarted = true;
  bool leftbrickcangivepoint = true;
  bool leftbrickcangivepointsec = true;
  bool rightbrickcangivepoint = true;
  bool doeswallcolide = false;
  bool onskills = false;
  bool onitem = false;
  bool onskins = true;
  bool onmarket = true;
  bool isplantaon = false;
  bool isplantbon = false;
  bool isplantcon = false;
  int maxdragmin = 2;
  bool cansshoot = true;

  late List<String> highscoreflags = [];

  double zorluk = 0;

  List<String> highscorenames = [];
  List<int> highscores = [];

  Color shopcolor = const Color(0xff22008e);
  Color buttonone = const Color(0xff22008e);
  Color buttononetext = Colors.white;
  Color buttontwo = Colors.white;
  Color buttontwotext = Colors.black;
  Color ballcolor = Colors.white;
  Color buttonthree = Colors.white;
  Color buttonthreetext = Colors.black;

  List<Widget> playerscorewidgetlist = [];
  List<Widget> scorewidgetlist = [];
  late Widget test;

  String cskillone = "images/buttons/holder.png";
  String cskilltwo = "images/buttons/holder.png";
  String cskillthree = "images/buttons/holder.png";
  String cskillfour = "images/buttons/holder.png";

  double sideplantleftleft = 0;
  double sideplantlefttop = -200;
  double sideplantleftheight = 0;
  double sideplantleftwidth = 0;

  double sideplantrightleft = 0;
  double sideplantrighttop = -200;
  double sideplantrightheight = 0;
  double sideplantrightwidth = 0;

  double bosstop = -500;
  double bossleft = 0;
  double bosswidth = 0;
  double bossheight = 0;
  double bossop = 0;

  double gftop = 0;
  double gfleft = -800;
  double gfwidth = 0;
  double gfheight = 0;
  double gfop = 0;

  double handtop = -200;
  double handleft = 0;
  double handwidth = 0;
  double handheight = 0;
  double handbossop = 0;

  double shooterrot = 0;
  double finalshooterrot = 0;
  double laserheight = 0;
  double laserleft = 0;
  double lasertop = -500;
  double laserrot = 0;

  double shooterleft = -500;
  double shootertop = -500;
  double animatedshootertop = -500;

  double teleptop = -500;
  double telepleft = 0;
  double teleprot = 0;

  double rockettop = -500;
  double rocketleft = 0;

  double enemyonerot = 0;
  double enemyonetop = -500;
  double enemyoneleft = -500;

  bool isdropmoneyon = false;
  double dropmoneytop = -500;
  double dropmoneyleft = 0;

  bool ceanim = false;
  double cetop = -500;
  double celeft = 0;

  double rightbricktop = -100;
  double rightbrickleft = 0;
  double rightbrickwidth = 100;

  double leftbricktop = -100;
  double leftbrickwidth = 100;

  double leftbricktopsec = -200;
  double leftbrickleftsec = 0;
  double leftbrickwidthsec = 100;

  double beotop = -500;
  double beoleft = 0;
  bool beoanim = false;
  double beop = 1;

  bool isgamestartedreally = false;

  double bettop = -500;
  double betleft = 0;
  bool betanim = false;
  double btop = 1;

  double bthop = 1;
  double bethtop = -500;
  double bethleft = 0;
  bool bethanim = false;

  double plantbwidth = 0;
  double plantbheight = 0;
  double plantbtop = -500;
  double plantbleft = 0;

  double plantawidth = 0;
  double plantaheight = 0;
  double plantatop = -500;

  double plantcwidth = 0;
  double plantcheight = 0;
  double plantctop = -500;
  double plantcleft = 0;

  double arrowtop = 0;
  double arrowleft = 0;
  double arrowop = 1;
  double rotation = 3.1415926535897932 / 2;
  double arrowheight = 0;
  double arrowopsec = 1;
  double arrowsectop = 0;
  double arrowsecleft = 0;
  double rotationsec = 0;

  double shieldtop = -500;
  double shieldleft = 0;
  bool shieldanim = false;

  double ijtop = -500;
  double ijleft = 0;
  bool ijanim = false;

  double imtop = -500;
  double imleft = 0;
  bool imanim = false;

  bool animate = false;
  double lftop = -500;
  double lfleft = 0;

  double ltop = -500;
  double lleft = 0;

  double damageop = 1;
  double damagewidth = 0;

  int prob = 10;

  double exptopone = -500;
  double expleftone = 0;
  bool expboolone = false;

  double exptoptwo = -500;
  double explefttwo = 0;
  bool expbooltwo = false;

  double exptopthree = -500;
  double expleftthree = 0;
  bool expboolthree = false;

  double aimwidthone = 0;
  double aimtopone = -500;
  double aimleftone = 0;
  bool aimanimone = false;

  double aimwidthtwo = 0;
  double aimtoptwo = -500;
  double aimlefttwo = 0;
  bool aimanimtwo = false;

  double aimwidththree = 0;
  double aimtopthree = -500;
  double aimleftthree = 0;
  bool aimanimthree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(color: Color(0xff321E63)),
      child: Stack(
        children: [
          BackWallWidget(
              width: screenwidth, top: backwalltop, height: screenheight + 5),
          BackWallWidget(
              width: screenwidth,
              top: backwalltopsec,
              height: screenheight + 5),
          SideWallWidget(
            l: 0,
            wallwidth: wallwidth,
            screenheight: screenheight,
            left: leftleft,
            wb: "images/walls/wlnl.jpg",
            canshake: canshake,
            buttonwidth: buttonwidth,
            buttononeimage: cskillone,
            buttontwoimage: cskillthree,
            buttononefunc: funconelist[0],
            buttontwofunc: functhreelist[0],
            wallimage: "images/walls/wl3.png",
            sidewallbackuptwotop: sidewallbackuptwotop,
            sidewallbackuptop: sidewallbackuptop,
            sidewallonetop: sidewallonetop,
            sidewalltwotop: sidewalltwotop,
            sidewallthreetop: sidewallthreetop,
          ),
          Positioned(
            left: wallwidth,
            child: SizedBox(
              width: mainareawidth,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ScoreWidget(
                      top: scoretop,
                      left: scoreleft,
                      canshake: canshake,
                      score: score),
                  AnimLnWidget(
                      top: telepbool
                          ? ((screenheight / 2) + (charmaxwidth / 2))
                          : teleptop,
                      left: telepbool ? (mainareawidth / 2) : telepleft,
                      width: telepbool ? 0 : telepwidth,
                      anim: telepanimate),

                  SplashWidget(
                      top: splashtop - 1000,
                      left: splashleft - 1000,
                      width: 2000,
                      height: 2000,
                      splash: splash,
                      finalwidth: splashfinalwidth,
                      func: () {
                        splashtop = -4000;
                        splashleft = -4000;
                        splash = true;
                      }),
                  SplashWidget(
                      top: splashtop - 50,
                      left: splashleft - 50,
                      width: 100,
                      height: 100,
                      splash: splash,
                      finalwidth: splashfinalwidthsec,
                      func: () {}),

                  McAniWidget(
                      t: mcanitop,
                      st: choosenskinbig,
                      m: mainareawidth,
                      s: screenheight,
                      op: animimageop,
                      func: () {
                        if (mcanitop < screenheight) {
                          setState(() {
                            scoreleft = mainareawidth / 2;
                            scoretop = screenheight * 1 / 5;
                            animimageop = 0.0;
                            mainbodytop = screenheight * 3 / 5;
                            mainbodyleft = mainareawidth / 2 - charmaxwidth / 2;
                            isanimationfinished = !isanimationfinished;
                            mcanitop = screenheight + 200;
                          });
                        }
                      },
                      b: isanimationfinished),
                  FrameWidget(
                      top: 0,
                      left: frametopleft,
                      height: (screenheight * 90) / 2000,
                      img: "images/walls/frametop.png"),
                  FrameWidget(
                      top: (screenheight - ((screenheight * 120) / 2000)),
                      left: framebottomleft,
                      height: (screenheight * 120) / 2000,
                      img: "images/walls/framebottom.png"),
                  FrameWidget(
                      top: 0,
                      left: frameoneleft,
                      height: screenheight,
                      img: "images/walls/camframe1f.png"),
                  FrameWidget(
                      top: 0,
                      left: frametwoleft,
                      height: screenheight,
                      img: "images/walls/camframe2f.png"),
                  HBackWidget(
                      left: healthbarleft,
                      width: healthbarwidth,
                      top: healthbartop,
                      height: healthbarheight),
                  HBWidget(
                      width: healthbarwidth,
                      top: healthbartop,
                      m: mainareawidth,
                      height: healthbarheight,
                      firstbar: firstbar,
                      secondbar: secondbar,
                      thirdbar: thirdbar,
                      fourthbar: fourthbar),
                  SBWidget(
                      isgamereallystarted: isgamestartedreally,
                      startbuttonfunc: startbuttonfunc,
                      startbuttontext: startbuttontext,
                      wallwidth: wallwidth,
                      startbuttontop: startbuttontop,
                      startbuttonleft: startbuttonleft,
                      startbuttonwidth: startbuttonwidth,
                      startbuttonheight: startbuttonheight,
                      scorewidgetlist: scorewidgetlist,
                      playerscorewidgetlist: playerscorewidgetlist),
                  BLWidget(
                      isgamestartedreally: isgamestartedreally,
                      top: shinetop,
                      height: 0,
                      left: 0,
                      width: mainareawidth,
                      boolx: starbool,
                      img: "images/effects/shines/shinebig.json"),
                  SIWidget(
                      f: emeraldup,
                      r: _rewardedAd,
                      isgamestartedreally: isgamestartedreally,
                      emerald: emerald,
                      money: money,
                      mainareawidth: mainareawidth,
                      wallwidth: wallwidth,
                      moneytop: moneytop,
                      enven: enven,
                      shop: shop),
                  CEWidget(
                      isgamereallystarted: isgamestartedreally,
                      coinexpwidth: coinexpwidth,
                      coinexplode: coinexplode),
                  MEWidget(
                      b: kilitforearn,
                      isgamestartedreally: isgamestartedreally,
                      snend: snend,
                      score: score,
                      sntop: sntop,
                      snleft: snleft,
                      snheight: snheight,
                      snwidth: snwidth,
                      moneyfunc: moneyfunc),

                  CWidget(
                      congm: congm,
                      confetitop: confetitop,
                      cong: cong,
                      isgamestartedreally: isgamestartedreally),
                  HSWidget(
                      isgamestartedreally: isgamestartedreally,
                      snhleft: snhleft,
                      snhwidth: snhwidth,
                      snhtop: snhtop,
                      snhheight: snhheight,
                      highscoreann: highscoreann,
                      snhsize: snhsize,
                      snhop: snhop,
                      highscorefunc: highscorefunc,
                      highscoreendfunc: highscoreendfunc),

                  ShooterClassWidget(
                      top: lasertop,
                      left: laserleft,
                      origin: laseroffset,
                      rot: laserrot,
                      height: laserheight,
                      width: laserwidth,
                      image: Image.asset(
                        "images/shooterfolder/laser.png",
                        repeat: ImageRepeat.repeat,
                      )),
                  ShooterClassWidget(
                    top: shootertop,
                    left: shooterleft,
                    origin: Offset(shooterwidth / 2, shooterheight),
                    rot: shooterrot,
                    height: shooterheight,
                    width: shooterwidth,
                    image: Image.asset(shooterimage),
                  ),
                  AnimatedPositioned(
                      left: shooterleft,
                      top: animatedshootertop,
                      duration: const Duration(seconds: 1),
                      child: SizedBox(
                        width: shooterwidth,
                        height: animatedshooterheight,
                        child: Image.asset("images/shooterfolder/ss4.png"),
                      )),
                  RocketWidget(
                      width: rocketwidth, top: rockettop, left: rocketleft),
                  EnemyWidget(
                      top: enemyonetop, left: enemyoneleft, rot: enemyonerot),
                  PickupMonyWidget(
                      b: isdropmoneyon,
                      t: dropmoneytop,
                      l: dropmoneyleft,
                      h: dropmoneyheight,
                      w: dropmoneywidth),
                  FLWidget(
                      shieldanim: shieldanim,
                      ijanim: ijanim,
                      imanim: imanim,
                      ceanim: ceanim,
                      expboolone: expboolone,
                      expbooltwo: expbooltwo,
                      expboolthree: expboolthree,
                      h: ceheight,
                      w: cewidth,
                      t: cetop,
                      l: celeft,
                      s: "images/effects/money/coinsmallexp.json",
                      b: ceanim),
                  BrickClassWidget(
                      top: leftbricktopsec,
                      left: leftbrickleftsec,
                      height: leftbrickheightsec,
                      width: leftbrickwidthsec,
                      image: leftbrickimagesec),
                  BrickClassWidget(
                      top: leftbricktop,
                      left: leftbrickleft,
                      height: leftbrickheight,
                      width: leftbrickwidth,
                      image: leftbrickimage),
                  BrickClassWidget(
                      top: rightbricktop,
                      left: rightbrickleft,
                      height: rightbrickheight,
                      width: rightbrickwidth,
                      image: rightbrickimage),
                  BTWidget(
                      btbool: btbool,
                      h: beoheight,
                      w: beowidth,
                      t: beotop,
                      l: beoleft,
                      o: beop,
                      b: beoanim),
                  BTWidget(
                      btbool: btbool,
                      h: betheight,
                      w: betwidth,
                      t: bettop,
                      l: betleft,
                      o: btop,
                      b: betanim),
                  BTWidget(
                      btbool: btbool,
                      h: bethheight,
                      w: bethwidth,
                      t: bethtop,
                      l: bethleft,
                      o: bthop,
                      b: bethanim),
                  PlantWidget(
                      isgameshakeon: isgameshakeon,
                      width: plantawidth,
                      top: plantatop,
                      left: plantaleft,
                      height: plantaheight,
                      c: charmaxwidth),
                  PlantWidget(
                      isgameshakeon: isgameshakeon,
                      width: plantbwidth,
                      top: plantbtop,
                      left: plantbleft,
                      height: plantbheight,
                      c: charmaxwidth),
                  PlantWidget(
                      isgameshakeon: isgameshakeon,
                      width: plantcwidth,
                      top: plantctop,
                      left: plantcleft,
                      height: plantcheight,
                      c: charmaxwidth),
                  ArrowClassFileWidget(
                      top: arrowtop,
                      left: arrowleft,
                      offset: Offset(charmaxwidth / 2, 0),
                      rot: rotation,
                      op: arrowop,
                      height: arrowheight,
                      size: arrowsize),
                  ArrowClassFileWidget(
                      top: arrowsectop,
                      left: arrowsecleft,
                      offset: arrowsecoffset,
                      rot: rotationsec,
                      op: arrowopsec,
                      height: arrowheight,
                      size: arrowsize),

                  FLWidget(
                    shieldanim: shieldanim,
                    ijanim: ijanim,
                    imanim: imanim,
                    ceanim: ceanim,
                    expboolone: expboolone,
                    expbooltwo: expbooltwo,
                    expboolthree: expboolthree,
                    h: shieldheight,
                    w: shieldwidth,
                    t: shieldtop,
                    l: shieldleft,
                    s: "images/effects/skills/shield.json",
                    b: shieldanim,
                  ),
                  FLWidget(
                    shieldanim: shieldanim,
                    ijanim: ijanim,
                    imanim: imanim,
                    ceanim: ceanim,
                    expboolone: expboolone,
                    expbooltwo: expbooltwo,
                    expboolthree: expboolthree,
                    h: ijheight,
                    w: ijwidth,
                    t: ijtop,
                    l: ijleft,
                    s: "images/effects/skills/infinity.json",
                    b: ijanim,
                  ),
                  FLWidget(
                    shieldanim: shieldanim,
                    ijanim: ijanim,
                    imanim: imanim,
                    ceanim: ceanim,
                    expboolone: expboolone,
                    expbooltwo: expbooltwo,
                    expboolthree: expboolthree,
                    h: imheight,
                    w: imwidth,
                    t: imtop,
                    l: imleft,
                    s: "images/effects/skills/immor.json",
                    b: imanim,
                  ),

                  //splashlist
                  SplashListWidget(
                      screenheight: screenheight, mainareawidth: mainareawidth),

                  MBWidget(
                    mainbodyleft: mainbodyleft,
                    mainbodytop: mainbodytop,
                    maxdrag: maxdrag,
                    dragablekey: dragablekey,
                    maincharrot: maincharrot,
                    choosenskin: choosenskin,
                    choosenskinbig: choosenskinbig,
                    ballcolor: ballcolor,
                    dragstartfunc: dragstartfunc,
                    mainthrowfunc: mainthrowfunc,
                  ),
                  //ballWidget(),
                  AniWidget(
                      jumpbool: jumpbool,
                      top: lftop,
                      left: lfleft,
                      width: lfwidth,
                      anim: animate,
                      rot: 0,
                      route: "images/effects/skills/lnalanpurp.json",
                      off: const Offset(0, 0)),
                  AniWidget(
                    jumpbool: jumpbool,
                    top: ltop,
                    left: lleft,
                    width: lwidth,
                    anim: animate,
                    rot: anirot,
                    route: "images/effects/skills/lnpurpfast.json",
                    off: Offset((lwidth / 2), 0),
                  ),

                  NpcAniWidget(
                    firstcol: firstcol,
                    st: "images/effects/gf.png",
                    func: () {
                      if (gftop < 0 && gfleft > 0) {
                        setState(() {
                          gftop = (screenheight / 2) - charmaxwidth / 2;
                          gfleft = -800;
                        });
                      }
                    },
                    top: gftop,
                    left: gfleft,
                    w: gfwidth,
                    h: gfheight,
                  ),

                  NpcAniWidget(
                    firstcol: firstcol,
                    st: "images/effects/boss.png",
                    func: () {},
                    top: bosstop,
                    left: bossleft,
                    w: bosswidth,
                    h: bossheight,
                  ),

                  NpcAniWidget(
                    firstcol: firstcol,
                    st: "images/effects/claw.png",
                    func: () {},
                    top: handtop,
                    left: handleft,
                    w: handwidth,
                    h: handheight,
                  ),

                  RWidget(
                    f: () {
                      _rewardedAd?.show(onUserEarnedReward: (_, rew) {
                        multiply = 2;
                      });
                    },
                    m: mainareawidth,
                    b: rbool,
                    w: rwidth,
                    h: rheight,
                    t: rtop,
                    l: rleft,
                  ),

                  DRWidget(
                      h: screenheight,
                      w: damagewidth,
                      o: damageop,
                      f: () {
                        setState(() {
                          damagewidth = 0;

                          damageop = 1;
                        });
                      }),
                ],
              ),
            ),
          ),
          ShopMainWidget(
            isgamereallystarted: isgamestartedreally,
            shopwidth: shopwidth,
            screenheight: screenheight,
            shopleft: shopleft,
            shopheight: shopheight,
            shopcolor: shopcolor,
            buttontwotext: buttontwotext,
            buttontwo: buttontwo,
            buttononetext: buttononetext,
            buttonone: buttonone,
            buttonthreetext: buttonthreetext,
            buttonthree: buttonthree,
            containertwoheight: containertwoheight,
            containeroneheight: containeroneheight,
            onmarket: onmarket,
            onskills: onskills,
            onitem: onitem,
            skillone: skillone,
            doyouhaveskillone: doyouhaveskillone,
            skilltwo: skilltwo,
            doyouhaveskilltwo: doyouhaveskilltwo,
            skillthree: skillthree,
            doyouhaveskillthree: doyouhaveskillthree,
            skillfour: skillfour,
            doyouhaveskillfour: doyouhaveskillfour,
            onskins: onskins,
            choosenskin: choosenskin,
            flagcostume: flagcostume,
            usedflag: usedflag,
            ismcinuse: ismcinuse,
            ismedicinuse: ismedicinuse,
            isenginuse: isenginuse,
            isarmorinuse: isarmorinuse,
            ismageinuse: ismageinuse,
            ispirateinuse: ispirateinuse,
            isfinalinuse: isfinalinuse,
            isofinuse: isofinuse,
            isafrinuse: isafrinuse,
            isarbinuse: isarbinuse,
            isarginuse: isarginuse,
            isausinuse: isausinuse,
            isbaninuse: isbaninuse,
            isbreinuse: isbreinuse,
            iscaninuse: iscaninuse,
            ischninuse: ischninuse,
            isegyinuse: isegyinuse,
            isendinuse: isendinuse,
            isinginuse: isinginuse,
            iseurinuse: iseurinuse,
            isfrainuse: isfrainuse,
            isgerinuse: isgerinuse,
            isindinuse: isindinuse,
            isitlinuse: isitlinuse,
            isjpninuse: isjpninuse,
            iskorinuse: iskorinuse,
            ismexinuse: ismexinuse,
            ispakinuse: ispakinuse,
            isrussinuse: isrussinuse,
            isspasinuse: isspasinuse,
            isusainuse: isusainuse,
            isturinuse: isturinuse,
            doyouhavemc: doyouhavemc,
            doyouhavemedic: doyouhavemedic,
            doyouhavearmor: doyouhavearmor,
            doyouhaveeng: doyouhaveeng,
            doyouhavemage: doyouhavemage,
            doyouhavepirate: doyouhavepirate,
            doyouhavefinal: doyouhavefinal,
            doyouhaveattack: doyouhaveattack,
            doyouhavecenter: doyouhavecenter,
            doyouhaveelectrickattack: doyouhaveelectrickattack,
            doyouhaveexp: doyouhaveexp,
            doyouhavefireattack: doyouhavefireattack,
            doyouhavehealth: doyouhavehealth,
            doyouhaveshield: doyouhaveshield,
            doyouhavejump: doyouhavejump,
            doyouhavetime: doyouhavetime,
            doyouhavewallbreak: doyouhavewallbreak,
            doyouhaveof: doyouhaveof,
            doyouhaveafr: doyouhaveafr,
            doyouhavearb: doyouhavearb,
            doyouhavearg: doyouhavearg,
            doyouhaveaus: doyouhaveaus,
            doyouhaveban: doyouhaveban,
            doyouhavebre: doyouhavebre,
            doyouhavecan: doyouhavecan,
            doyouhavechn: doyouhavechn,
            doyouhaveegy: doyouhaveegy,
            doyouhaveend: doyouhaveend,
            doyouhaveing: doyouhaveing,
            doyouhaveeur: doyouhaveeur,
            doyouhavefre: doyouhavefre,
            doyouhaveger: doyouhaveger,
            doyouhaveind: doyouhaveind,
            doyouhaveitl: doyouhaveitl,
            doyouhavejpn: doyouhavejpn,
            doyouhavekor: doyouhavekor,
            doyouhavemex: doyouhavemex,
            doyouhavepak: doyouhavepak,
            doyouhaverus: doyouhaverus,
            doyouhavespa: doyouhavespa,
            doyouhavetur: doyouhavetur,
            doyouhaveusa: doyouhaveusa,
            sonefunc: () {
              if (money >= 0) {
                setState(() {
                  money -= 0;
                  updatedyh("dyhskillone");
                  doyouhaveskillone = true;
                });
              }
            },
            stwofunc: () {
              if (money >= 100) {
                setState(() {
                  money -= 100;
                  updatemoney(money);
                  updatedyh("dyhskilltwo");
                  doyouhaveskilltwo = true;
                });
              }
            },
            sthreefunc: () {
              if (money >= 500) {
                setState(() {
                  money -= 500;
                  updatemoney(money);

                  updatedyh("dyhskillthree");
                  doyouhaveskillthree = true;
                });
              }
            },
            sfourfunc: () {
              if (money >= 1500) {
                setState(() {
                  money -= 1500;
                  updatemoney(money);

                  updatedyh("dyhskillfour");
                  doyouhaveskillfour = true;
                });
              }
            },
            switchfunc: (xd) {
              setState(() {
                flagcostume = xd;
              });
            },
            ftwo: () {
              setState(() {
                shopcolor = const Color(0xff90007d);
                buttonone = Colors.white;
                buttontwo = const Color(0xff90007d);
                buttonthree = Colors.white;
                buttononetext = Colors.black;
                buttontwotext = Colors.white;
                buttonthreetext = Colors.black;
                onskills = true;
                onskins = false;
                onitem = false;
              });
            },
            fone: () {
              setState(() {
                shopcolor = const Color(0xff22008e);
                buttonone = const Color(0xff22008e);
                buttontwo = Colors.white;
                buttonthree = Colors.white;
                buttononetext = Colors.white;
                buttontwotext = Colors.black;
                buttonthreetext = Colors.black;
                onskills = false;
                onskins = true;
                onitem = false;
              });
            },
            fthree: () {
              setState(() {
                shopcolor = const Color(0xff00696a);
                buttonone = Colors.white;
                buttontwo = Colors.white;
                buttonthree = const Color(0xff00696a);
                buttononetext = Colors.black;
                buttontwotext = Colors.black;
                buttonthreetext = Colors.white;
                onskills = false;
                onskins = false;
                onitem = true;
              });
            },
            jumpfunccoin: () {
              setState(() {
                if (money >= 0) {
                  money -= 0;
                  updatedyh("dyhjump");
                  doyouhavejump = true;
                }
              });
            },
            jumpfuncemerald: () {
              setState(() {
                if (emerald >= 0) {
                  emerald -= 0;
                  updatedyh("dyhjump");
                  doyouhavejump = true;
                }
              });
            },
            centerfunccoin: () {
              setState(() {
                if (money >= 10) {
                  money -= 10;
                  updatedyh("dyhcenter");
                  updatemoney(money);

                  doyouhavecenter = true;
                }
              });
            },
            centerfuncemerald: () {
              setState(() {
                if (emerald >= 1) {
                  emerald -= 1;
                  updatedyh("dyhcenter");
                  updateemerald(emerald);
                  doyouhavecenter = true;
                }
              });
            },
            shieldfunccoin: () {
              setState(() {
                if (money >= 200) {
                  money -= 200;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhshield");
                  doyouhaveshield = true;
                }
              });
            },
            shieldfuncemerald: () {
              setState(() {
                if (emerald >= 10) {
                  emerald -= 10;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhshield");
                  doyouhaveshield = true;
                }
              });
            },
            healthfunccoin: () {
              setState(() {
                if (money >= 200) {
                  money -= 200;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhhealth");
                  doyouhavehealth = true;
                }
              });
            },
            healthfuncemerald: () {
              setState(() {
                if (emerald >= 10) {
                  emerald -= 10;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhhealth");
                  doyouhavehealth = true;
                }
              });
            },
            timefunccoin: () {
              setState(() {
                if (money >= 200) {
                  money -= 200;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhtime");
                  doyouhavetime = true;
                }
              });
            },
            timefuncemerald: () {
              setState(() {
                if (emerald >= 10) {
                  emerald -= 10;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhtime");
                  doyouhavetime = true;
                }
              });
            },
            attackfunccoin: () {
              setState(() {
                if (money >= 100) {
                  money -= 100;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhattack");
                  doyouhaveattack = true;
                }
              });
            },
            attackfuncemerald: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhattack");
                  doyouhaveattack = true;
                }
              });
            },
            elecattackcoin: () {
              setState(() {
                if (money >= 100) {
                  money -= 100;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhelectrickattack");
                  doyouhaveelectrickattack = true;
                }
              });
            },
            elecattackemerald: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhelectrickattack");
                  doyouhaveelectrickattack = true;
                }
              });
            },
            wallbreakcoin: () {
              setState(() {
                if (money >= 500) {
                  money -= 500;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhwallbreak");
                  doyouhavewallbreak = true;
                }
              });
            },
            wallbreakemerald: () {
              setState(() {
                if (emerald >= 20) {
                  emerald -= 20;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhwallbreak");
                  doyouhavewallbreak = true;
                }
              });
            },
            fireattackcoin: () {
              setState(() {
                if (money >= 100) {
                  money -= 100;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhfireattack");
                  doyouhavefireattack = true;
                }
              });
            },
            fireattackemerald: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhfireattack");
                  doyouhavefireattack = true;
                }
              });
            },
            expcoin: () {
              setState(() {
                if (money >= 500) {
                  money -= 500;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhexp");
                  doyouhaveexp = true;
                }
              });
            },
            expemerald: () {
              setState(() {
                if (emerald >= 20) {
                  emerald -= 20;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhexp");
                  doyouhaveexp = true;
                }
              });
            },
            afrc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhafr");
                  doyouhaveafr = true;
                }
              });
            },
            afre: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhafr");
                  doyouhaveafr = true;
                }
              });
            },
            arbc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyharb");
                  doyouhavearb = true;
                }
              });
            },
            arbe: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyharb");
                  doyouhavearb = true;
                }
              });
            },
            argc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyharg");
                  doyouhavearg = true;
                }
              });
            },
            arge: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyharg");
                  doyouhavearg = true;
                }
              });
            },
            ausc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhaus");
                  doyouhaveaus = true;
                }
              });
            },
            ause: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhaus");
                  doyouhaveaus = true;
                }
              });
            },
            banc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhban");
                  doyouhaveban = true;
                }
              });
            },
            bane: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhban");
                  doyouhaveban = true;
                }
              });
            },
            brec: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhbre");
                  doyouhavebre = true;
                }
              });
            },
            bree: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhbre");
                  doyouhavebre = true;
                }
              });
            },
            canc: () {
              setState(() {
                if (money >= 400) {
                  updatedyh("dyhcan");
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  doyouhavecan = true;
                }
              });
            },
            cane: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhcan");
                  doyouhavecan = true;
                }
              });
            },
            chnc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhchn");
                  doyouhavechn = true;
                }
              });
            },
            chne: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhchn");
                  doyouhavechn = true;
                }
              });
            },
            egyc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhegy");
                  doyouhaveegy = true;
                }
              });
            },
            egye: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhegy");
                  doyouhaveegy = true;
                }
              });
            },
            endc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhend");
                  doyouhaveend = true;
                }
              });
            },
            ende: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhend");
                  doyouhaveend = true;
                }
              });
            },
            inge: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhing");
                  doyouhaveing = true;
                }
              });
            },
            ingc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhing");
                  doyouhaveing = true;
                }
              });
            },
            eurc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyheur");
                  doyouhaveeur = true;
                }
              });
            },
            eure: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyheur");
                  doyouhaveeur = true;
                }
              });
            },
            frec: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhfre");
                  doyouhavefre = true;
                }
              });
            },
            free: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhfre");
                  doyouhavefre = true;
                }
              });
            },
            gerc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhger");
                  doyouhaveger = true;
                }
              });
            },
            gere: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhger");
                  doyouhaveger = true;
                }
              });
            },
            indc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhind");
                  doyouhaveind = true;
                }
              });
            },
            inde: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhind");
                  doyouhaveind = true;
                }
              });
            },
            itlc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhitl");
                  doyouhaveitl = true;
                }
              });
            },
            itle: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhitl");
                  doyouhaveitl = true;
                }
              });
            },
            jpnc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhjpn");
                  doyouhavejpn = true;
                }
              });
            },
            jpne: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhjpn");
                  doyouhavejpn = true;
                }
              });
            },
            korc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhkor");
                  doyouhavekor = true;
                }
              });
            },
            kore: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhkor");
                  doyouhavekor = true;
                }
              });
            },
            mexc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhmex");
                  doyouhavemex = true;
                }
              });
            },
            mexe: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhmex");
                  doyouhavemex = true;
                }
              });
            },
            pakc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhpak");
                  doyouhavepak = true;
                }
              });
            },
            pake: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhpak");
                  doyouhavepak = true;
                }
              });
            },
            rusc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhrus");
                  doyouhaverus = true;
                }
              });
            },
            ruse: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhrus");
                  doyouhaverus = true;
                }
              });
            },
            spac: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhspa");
                  doyouhavespa = true;
                }
              });
            },
            spae: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhspa");
                  doyouhavespa = true;
                }
              });
            },
            turc: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhtur");
                  doyouhavetur = true;
                }
              });
            },
            ture: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhtur");
                  doyouhavetur = true;
                }
              });
            },
            usac: () {
              setState(() {
                if (money >= 400) {
                  money -= 400;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhusa");
                  doyouhaveusa = true;
                }
              });
            },
            usae: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhusa");
                  doyouhaveusa = true;
                }
              });
            },
            medicc: () {
              setState(() {
                if (money >= 100) {
                  money -= 100;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhmedic");
                  doyouhavemedic = true;
                }
              });
            },
            medice: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhmedic");
                  doyouhavemedic = true;
                }
              });
            },
            armorc: () {
              setState(() {
                if (money >= 100) {
                  money -= 100;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyharmor");
                  doyouhavearmor = true;
                }
              });
            },
            armore: () {
              setState(() {
                if (emerald >= 5) {
                  emerald -= 5;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyharmor");
                  doyouhavearmor = true;
                }
              });
            },
            enginc: () {
              setState(() {
                if (money >= 1000) {
                  money -= 1000;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyheng");
                  doyouhaveeng = true;
                }
              });
            },
            engine: () {
              setState(() {
                if (emerald >= 30) {
                  emerald -= 30;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyheng");
                  doyouhaveeng = true;
                }
              });
            },
            piratec: () {
              setState(() {
                if (money >= 500) {
                  money -= 500;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhpirate");
                  doyouhavepirate = true;
                }
              });
            },
            piratee: () {
              setState(() {
                if (emerald >= 20) {
                  emerald -= 20;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhpirate");
                  doyouhavepirate = true;
                }
              });
            },
            magec: () {
              setState(() {
                if (money >= 500) {
                  money -= 500;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhmage");
                  doyouhavemage = true;
                }
              });
            },
            magee: () {
              setState(() {
                if (emerald >= 20) {
                  emerald -= 20;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhmage");
                  doyouhavemage = true;
                }
              });
            },
            finalc: () {
              setState(() {
                if (money >= 5000) {
                  money -= 5000;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhfinal");
                  doyouhavefinal = true;
                }
              });
            },
            finale: () {
              setState(() {
                if (emerald >= 50) {
                  emerald -= 50;
                  updatemoney(money);
                  updateemerald(emerald);
                  updatedyh("dyhfinal");
                  doyouhavefinal = true;
                }
              });
            },
            chone: (x) {
              setState(() {
                changer(x, "images/buttons/on/jumpon.png");
              });
            },
            chtwo: (x) {
              setState(() {
                changer(x, "images/buttons/on/centeron.png");
              });
            },
            chthree: (x) {
              setState(() {
                changer(x, "images/buttons/on/healthon.png");
              });
            },
            chfour: (x) {
              setState(() {
                changer(x, "images/buttons/on/electricattackon.png");
              });
            },
            cfive: (x) {
              setState(() {
                changer(x, "images/buttons/on/fireattackon.png");
              });
            },
            csix: (x) {
              setState(() {
                changer(x, "images/buttons/on/attackon.png");
              });
            },
            cseven: (x) {
              setState(() {
                changer(x, "images/buttons/on/expon.png");
              });
            },
            ceight: (x) {
              setState(() {
                changer(x, "images/buttons/on/timeon.png");
              });
            },
            cnine: (x) {
              setState(() {
                changer(x, "images/buttons/on/wallbreakon.png");
              });
            },
            cten: (x) {
              setState(() {
                changer(x, "images/buttons/on/shieldon.png");
              });
            },
            offuse: () {
              setState(() {
                usedflag = "images/flags/small/off.png";
                usedflagbig = "images/flags/small/off.png";
                mcflag = usedflag;
                isofinuse = true;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            afruse: () {
              setState(() {
                usedflag = "images/flags/small/afrsmall.png";
                usedflagbig = "images/flags/big/afrbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = true;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            arbuse: () {
              setState(() {
                usedflag = "images/flags/small/arbsmall.png";
                usedflagbig = "images/flags/big/arbbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = true;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            arguse: () {
              setState(() {
                usedflag = "images/flags/small/argsmall.png";
                usedflagbig = "images/flags/big/argbi.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = true;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            aususe: () {
              setState(() {
                usedflag = "images/flags/small/aussmall.png";
                usedflagbig = "images/flags/big/aus big.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = true;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            banuse: () {
              setState(() {
                usedflag = "images/flags/small/bansmall.png";
                usedflagbig = "images/flags/big/banbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = true;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            breuse: () {
              setState(() {
                usedflag = "images/flags/small/bresmall.png";
                usedflagbig = "images/flags/big/brebig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = true;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            canuse: () {
              setState(() {
                usedflag = "images/flags/small/cansmall.png";
                usedflagbig = "images/flags/big/canbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = true;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            chnuse: () {
              setState(() {
                usedflag = "images/flags/small/chnsmall.png";
                mcflag = usedflag;

                usedflagbig = "images/flags/big/chnbig.png";
                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = true;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            egyuse: () {
              setState(() {
                usedflag = "images/flags/small/egysmall.png";
                usedflagbig = "images/flags/big/egybig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = true;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            enduse: () {
              setState(() {
                usedflag = "images/flags/small/endsmall.png";
                usedflagbig = "images/flags/big/endbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = true;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            inguse: () {
              setState(() {
                usedflag = "images/flags/small/engsmall.png";
                usedflagbig = "images/flags/big/engbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = true;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            euruse: () {
              setState(() {
                usedflag = "images/flags/small/eursmall.png";
                usedflagbig = "images/flags/big/eurbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = true;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            freuse: () {
              setState(() {
                usedflag = "images/flags/small/frasmall.png";
                usedflagbig = "images/flags/big/frebig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = true;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            geruse: () {
              setState(() {
                usedflag = "images/flags/small/gersmall.png";
                usedflagbig = "images/flags/big/gerbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = true;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            induse: () {
              setState(() {
                usedflag = "images/flags/small/indsmall.png";
                usedflagbig = "images/flags/big/indbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = true;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            itluse: () {
              setState(() {
                usedflag = "images/flags/small/itlsmall.png";
                usedflagbig = "images/flags/big/itlbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = true;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            jpnuse: () {
              setState(() {
                usedflag = "images/flags/small/japsmal.png";
                usedflagbig = "images/flags/big/jpnbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = true;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            koruse: () {
              setState(() {
                usedflag = "images/flags/small/korsmall.png";
                usedflagbig = "images/flags/big/korbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = true;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            mexuse: () {
              setState(() {
                usedflag = "images/flags/small/mexsmal.png";
                usedflagbig = "images/flags/big/mexbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = true;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            pakuse: () {
              setState(() {
                usedflag = "images/flags/small/paksmall.png";
                usedflagbig = "images/flags/big/pakbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = true;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            rususe: () {
              setState(() {
                usedflag = "images/flags/small/russmall.png";
                usedflagbig = "images/flags/big/rusbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = true;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = false;
              });
            },
            spause: () {
              setState(() {
                usedflag = "images/flags/small/spasmall.png";
                usedflagbig = "images/flags/big/spabig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = true;
                isusainuse = false;
                isturinuse = false;
              });
            },
            turuse: () {
              setState(() {
                usedflag = "images/flags/small/tursmall.png";
                usedflagbig = "images/flags/big/turbig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = false;
                isturinuse = true;
              });
            },
            usause: () {
              setState(() {
                usedflag = "images/flags/small/usasmall.png";
                usedflagbig = "images/flags/big/usabig.png";
                mcflag = usedflag;

                isofinuse = false;
                isafrinuse = false;
                isarbinuse = false;
                isarginuse = false;
                isausinuse = false;
                isbaninuse = false;
                isbreinuse = false;
                iscaninuse = false;
                ischninuse = false;
                isegyinuse = false;
                isendinuse = false;
                isinginuse = false;
                iseurinuse = false;
                isfrainuse = false;
                isgerinuse = false;
                isindinuse = false;
                isitlinuse = false;
                isjpninuse = false;
                iskorinuse = false;
                ismexinuse = false;
                ispakinuse = false;
                isrussinuse = false;
                isspasinuse = false;
                isusainuse = true;
                isturinuse = false;
              });
            },
            medicuse: () {
              setState(() {
                usedskin = "images/characters/skins/skinnormal/medic.png";
                usedskinbig = "images/characters/skins/skinbig/medicbig.png";
                choosenvariat = "medic";
                choosenskin = usedskin;
                choosenskinbig = usedskinbig;

                ismcinuse = false;
                isenginuse = false;
                ismageinuse = false;
                ismedicinuse = true;
                isarmorinuse = false;
                ispirateinuse = false;
                isfinalinuse = false;
              });
            },
            armoruse: () {
              setState(() {
                choosenvariat = "armor";

                usedskin = "images/characters/skins/skinnormal/armor.png";
                usedskinbig = "images/characters/skins/skinbig/armorbig.png";
                choosenskin = usedskin;
                choosenskinbig = usedskinbig;

                ismcinuse = false;
                isenginuse = false;
                ismageinuse = false;
                ismedicinuse = false;
                isarmorinuse = true;
                ispirateinuse = false;
                isfinalinuse = false;
              });
            },
            finaluse: () {
              setState(() {
                choosenvariat = "final";

                usedskinbig = "images/characters/skins/skinbig/finalbig.png";
                usedskin = "images/characters/skins/skinnormal/final.png";
                choosenskin = usedskin;
                choosenskinbig = usedskinbig;
                ismcinuse = false;
                isenginuse = false;
                ismageinuse = false;
                ismedicinuse = false;
                isarmorinuse = false;
                ispirateinuse = false;
                isfinalinuse = true;
              });
            },
            mageuse: () {
              setState(() {
                usedskin = "images/characters/skins/skinnormal/mage.png";
                usedskinbig = "images/characters/skins/skinbig/magebig.png";
                choosenvariat = "mage";
                choosenskin = usedskin;
                choosenskinbig = usedskinbig;
                ismcinuse = false;
                isenginuse = false;
                ismageinuse = true;
                ismedicinuse = false;
                isarmorinuse = false;
                ispirateinuse = false;
                isfinalinuse = false;
              });
            },
            pirateuse: () {
              setState(() {
                choosenvariat = "pirate";

                usedskin = "images/characters/skins/skinnormal/pirate.png";
                usedskinbig = "images/characters/skins/skinbig/piratebig.png";
                choosenskin = usedskin;
                choosenskinbig = usedskinbig;

                ismcinuse = false;
                isenginuse = false;
                ismageinuse = false;
                ismedicinuse = false;
                isarmorinuse = false;
                ispirateinuse = true;
                isfinalinuse = false;
              });
            },
            enginuse: () {
              setState(() {
                usedskin = "images/characters/skins/skinnormal/eng.png";
                usedskinbig = "images/characters/skins/skinbig/engbig.png";
                choosenvariat = "eng";
                choosenskin = usedskin;
                choosenskinbig = usedskinbig;
                ismcinuse = false;
                isenginuse = true;
                ismageinuse = false;
                ismedicinuse = false;
                isarmorinuse = false;
                ispirateinuse = false;
                isfinalinuse = false;
              });
            },
            normaluse: () {
              setState(() {
                usedskin = "images/characters/skins/skinnormal/mc.png";
                usedskinbig = "images/characters/skins/skinbig/mccb.png";
                choosenskin = usedskin;
                choosenskinbig = usedskinbig;
                ismcinuse = true;
                isenginuse = false;
                ismageinuse = false;
                ismedicinuse = false;
                isarmorinuse = false;
                ispirateinuse = false;
                isfinalinuse = false;
              });
            },
          ),
          SideWallWidget(
            l: (wallwidth + mainareawidth),
            wallwidth: wallwidth,
            screenheight: screenheight,
            left: rightleft,
            wb: "images/walls/wrnl.jpg",
            canshake: canshake,
            buttonwidth: buttonwidth,
            buttononeimage: cskilltwo,
            buttontwoimage: cskillfour,
            buttononefunc: functwolist[0],
            buttontwofunc: funcfourlist[0],
            wallimage: "images/walls/wr3.png",
            sidewallbackuptwotop: sidewallbackuptwotop,
            sidewallbackuptop: sidewallbackuptop,
            sidewallonetop: sidewallonetop,
            sidewalltwotop: sidewalltwotop,
            sidewallthreetop: sidewallthreetop,
          ),
          IWidget(w: infowidth, h: infoheight, t: infotop, l: infoleft),
          SidePlantWidget(
              isgameshakeon: isgameshakeon,
              top: sideplantlefttop,
              left: sideplantleftleft,
              height: sideplantleftheight,
              width: sideplantleftwidth,
              image: "images/characters/fireplant.png"),
          SidePlantWidget(
              isgameshakeon: isgameshakeon,
              top: sideplantrighttop,
              left: sideplantrightleft,
              height: sideplantrightheight,
              width: sideplantrightwidth,
              image: "images/characters/fireplantr.png"),
          FLAWidget(
              aimbool: aimbool,
              h: aimheightone,
              w: aimwidthone,
              t: aimtopone,
              l: aimleftone,
              b: aimanimone,
              m: m,
              s: "images/effects/skills/aim.json"),
          FLAWidget(
              aimbool: aimbool,
              h: aimheighttwo,
              w: aimwidthtwo,
              t: aimtoptwo,
              l: aimlefttwo,
              b: aimanimtwo,
              m: m,
              s: "images/effects/skills/aim.json"),
          FLAWidget(
              aimbool: aimbool,
              h: aimheightthree,
              w: aimwidththree,
              t: aimtopthree,
              l: aimleftthree,
              b: aimanimthree,
              m: m,
              s: "images/effects/skills/aim.json"),
          FLWidget(
              shieldanim: shieldanim,
              ijanim: ijanim,
              imanim: imanim,
              ceanim: ceanim,
              expboolone: expboolone,
              expbooltwo: expbooltwo,
              expboolthree: expboolthree,
              h: exphightone,
              w: expwidthone,
              t: exptopone,
              l: expleftone,
              b: expboolone,
              s: "images/effects/skills/expblue.json"),
          FLWidget(
              shieldanim: shieldanim,
              ijanim: ijanim,
              imanim: imanim,
              ceanim: ceanim,
              expboolone: expboolone,
              expbooltwo: expbooltwo,
              expboolthree: expboolthree,
              h: exphighttwo,
              w: exphighttwo,
              t: exptoptwo,
              l: explefttwo,
              b: expbooltwo,
              s: "images/effects/skills/expblue.json"),
          FLWidget(
              shieldanim: shieldanim,
              ijanim: ijanim,
              imanim: imanim,
              ceanim: ceanim,
              expboolone: expboolone,
              expbooltwo: expbooltwo,
              expboolthree: expboolthree,
              h: exphightthree,
              w: expwidththree,
              t: exptopthree,
              l: expleftthree,
              b: expboolthree,
              s: "images/effects/skills/expblue.json"),
          //sidewid
          SideWidget(
              l: 0,
              wallwidth: wallwidth,
              i: CupertinoIcons.double_music_note,
              fone: () {
                if (ismusicon == true) {
                  ismusicon = false;
                  FlameAudio.bgm.stop();
                } else {
                  ismusicon = true;
                  FlameAudio.bgm.play('DRIVE.mp3', volume: .25);
                }
              },
              s: "? ©",
              ftwo: () {
                setState(() {
                  if (infoon == true) {
                    infoon = false;
                  } else {
                    infoon = true;
                  }
                });
              }),
        ],
      ),
    ));
  }

  //
  //
  //

  bool flagcostume = false;

  double skilcolx = 0;
  double skilcoly = 0;

  skillcolideout(x) {
    if (true) {
      if ((x.offset.dy + (((shopwidth / 3) * 8 / 10)) / 2) >
          ((screenheight / 2) -
              (shopheight / 2) +
              (shopwidth / 4) +
              (charmaxwidth / 2) +
              (containertwoheight / 2))) {
        if (x.offset.dx + (((shopwidth / 3) * 8 / 10) / 2) > screenwidth / 2) {
          if (skillcolide(
              x,
              ((screenheight / 2) -
                  (shopheight / 2) +
                  (shopwidth / 4) +
                  (charmaxwidth / 2) +
                  (containertwoheight * 3 / 4)),
              wallwidth +
                  (shopwidth / 3 / 3) +
                  (shopwidth * 4 / 12) +
                  (shopwidth / 3 / 3) +
                  (shopwidth * 2 / 12))) {
            return "sağ alt";
          }
        } else {
          if (skillcolide(
              x,
              ((screenheight / 2) -
                  (shopheight / 2) +
                  (shopwidth / 4) +
                  (charmaxwidth / 2) +
                  (containertwoheight * 3 / 4)),
              wallwidth + (shopwidth / 3 / 3) + (shopwidth * 2 / 12))) {
            return "sol alt";
          }
        }
      } else {
        if (x.offset.dx + (((shopwidth / 3) * 8 / 10) / 2) > screenwidth / 2) {
          if (skillcolide(
              x,
              ((screenheight / 2) -
                  (shopheight / 2) +
                  (shopwidth / 4) +
                  (charmaxwidth / 2) +
                  (containertwoheight / 4)),
              wallwidth +
                  (shopwidth / 3 / 3) +
                  (shopwidth * 4 / 12) +
                  (shopwidth / 3 / 3) +
                  (shopwidth * 2 / 12))) {
            return "sağ üst";
          }
        } else {
          if (skillcolide(
              x,
              ((screenheight / 2) -
                  (shopheight / 2) +
                  (shopwidth / 4) +
                  (charmaxwidth / 2) +
                  (containertwoheight / 4)),
              wallwidth + (shopwidth / 3 / 3) + (shopwidth * 2 / 12))) {
            return "sol üst";
          }
        }
      }
    }
  }

  bool skillcolide(x, placetop, placeleft) {
    skilcolx = ((x.offset.dy + (((shopwidth / 3) * 8 / 10) / 2))) - (placetop);
    skilcoly = ((x.offset.dx + (((shopwidth / 3) * 8 / 10) / 2))) - (placeleft);

    if (sqrt(((skilcolx * skilcolx).abs() + (skilcoly * skilcoly).abs())) <=
        ((((shopwidth / 3) * 8 / 10) / 2) + ((shopwidth * 4 / 12) / 2))) {
      return true;
    } else {
      return false;
    }
  }

  List<Function> funconelist = [() {}];
  List<Function> functwolist = [() {}];
  List<Function> functhreelist = [() {}];
  List<Function> funcfourlist = [() {}];

  changer(x, string) {
    if (skillcolideout(x) == "sol üst" && doyouhaveskillone) {
      if (string == "images/buttons/on/jumpon.png") {
        jumpbool = true;

        funconelist.clear();
        funconelist.add(jumpbuttonfunc);
      }
      if (string == "images/buttons/on/attackon.png") {
        funconelist.clear();
        aimbool = true;
        funconelist.add(attackbuttonfunc);
      }
      if (string == "images/buttons/on/centeron.png") {
        funconelist.clear();
        funconelist.add(centerbuttonfunc);
      }
      if (string == "images/buttons/on/expon.png") {
        funconelist.clear();
        funconelist.add(expbuttonfunc);
      }
      if (string == "images/buttons/on/electricattackon.png") {
        aimbool = true;
        funconelist.clear();
        funconelist.add(electricattackbuttonfunc);
      }
      if (string == "images/buttons/on/fireattackon.png") {
        funconelist.clear();
        funconelist.add(infinitejumpbuttonfunc);
      }
      if (string == "images/buttons/on/healthon.png") {
        funconelist.clear();
        funconelist.add(healthbuttonfunc);
      }
      if (string == "images/buttons/on/shieldon.png") {
        funconelist.clear();
        funconelist.add(shieldbuttonfunc);
      }
      if (string == "images/buttons/on/timeon.png") {
        funconelist.clear();
        funconelist.add(timebuttonfunc);
      }
      if (string == "images/buttons/on/wallbreakon.png") {
        funconelist.clear();
        funconelist.add(wallbreakbuttonfunc);
      }
      skillone = string;
      cskillone = string;
      if (skilltwo == string) {
        skilltwo = "images/buttons/holder.png";
      }
      if (skillthree == string) {
        skillthree = "images/buttons/holder.png";
      }
      if (skillfour == string) {
        skillfour = "images/buttons/holder.png";
      }
    }
    if (skillcolideout(x) == "sağ üst" && doyouhaveskilltwo) {
      if (string == "images/buttons/on/jumpon.png") {
        jumpbool = true;

        functwolist.clear();
        functwolist.add(jumpbuttonfunc);
      }
      if (string == "images/buttons/on/attackon.png") {
        functwolist.clear();
        aimbool = true;

        functwolist.add(attackbuttonfunc);
      }
      if (string == "images/buttons/on/centeron.png") {
        functwolist.clear();
        functwolist.add(centerbuttonfunc);
      }
      if (string == "images/buttons/on/expon.png") {
        functwolist.clear();
        functwolist.add(expbuttonfunc);
      }
      if (string == "images/buttons/on/electricattackon.png") {
        aimbool = true;

        functwolist.clear();
        functwolist.add(electricattackbuttonfunc);
      }
      if (string == "images/buttons/on/fireattackon.png") {
        functwolist.clear();
        functwolist.add(infinitejumpbuttonfunc);
      }
      if (string == "images/buttons/on/healthon.png") {
        functwolist.clear();
        functwolist.add(healthbuttonfunc);
      }
      if (string == "images/buttons/on/shieldon.png") {
        functwolist.clear();
        functwolist.add(shieldbuttonfunc);
      }
      if (string == "images/buttons/on/timeon.png") {
        functwolist.clear();
        functwolist.add(timebuttonfunc);
      }
      if (string == "images/buttons/on/wallbreakon.png") {
        functwolist.clear();
        functwolist.add(wallbreakbuttonfunc);
      }
      if (skillone == string) {
        skillone = "images/buttons/holder.png";
      }
      cskilltwo = string;
      skilltwo = string;

      if (skillthree == string) {
        skillthree = "images/buttons/holder.png";
      }
      if (skillfour == string) {
        skillfour = "images/buttons/holder.png";
      }
    }
    if (skillcolideout(x) == "sol alt" && doyouhaveskillthree) {
      if (string == "images/buttons/on/jumpon.png") {
        jumpbool = true;

        functhreelist.clear();
        functhreelist.add(jumpbuttonfunc);
      }
      if (string == "images/buttons/on/attackon.png") {
        functhreelist.clear();
        aimbool = true;
        functhreelist.add(attackbuttonfunc);
      }
      if (string == "images/buttons/on/centeron.png") {
        functhreelist.clear();
        functhreelist.add(centerbuttonfunc);
      }
      if (string == "images/buttons/on/expon.png") {
        functhreelist.clear();
        functhreelist.add(expbuttonfunc);
      }
      if (string == "images/buttons/on/electricattackon.png") {
        aimbool = true;

        functhreelist.clear();
        functhreelist.add(electricattackbuttonfunc);
      }
      if (string == "images/buttons/on/fireattackon.png") {
        functhreelist.clear();
        functhreelist.add(infinitejumpbuttonfunc);
      }
      if (string == "images/buttons/on/healthon.png") {
        functhreelist.clear();
        functhreelist.add(healthbuttonfunc);
      }
      if (string == "images/buttons/on/shieldon.png") {
        functhreelist.clear();
        functhreelist.add(shieldbuttonfunc);
      }
      if (string == "images/buttons/on/timeon.png") {
        functhreelist.clear();
        functhreelist.add(timebuttonfunc);
      }
      if (string == "images/buttons/on/wallbreakon.png") {
        functhreelist.clear();
        functhreelist.add(wallbreakbuttonfunc);
      }
      if (skillone == string) {
        skillone = "images/buttons/holder.png";
      }
      if (skilltwo == string) {
        skilltwo = "images/buttons/holder.png";
      }
      skillthree = string;
      cskillthree = string;

      if (skillfour == string) {
        skillfour = "images/buttons/holder.png";
      }
    }
    if (skillcolideout(x) == "sağ alt" && doyouhaveskillfour) {
      if (string == "images/buttons/on/jumpon.png") {
        funcfourlist.clear();
        jumpbool = true;

        funcfourlist.add(jumpbuttonfunc);
      }
      if (string == "images/buttons/on/attackon.png") {
        funcfourlist.clear();
        aimbool = true;

        funcfourlist.add(attackbuttonfunc);
      }
      if (string == "images/buttons/on/centeron.png") {
        funcfourlist.clear();
        funcfourlist.add(centerbuttonfunc);
      }
      if (string == "images/buttons/on/expon.png") {
        funcfourlist.clear();
        funcfourlist.add(expbuttonfunc);
      }
      if (string == "images/buttons/on/electricattackon.png") {
        funcfourlist.clear();
        aimbool = true;

        funcfourlist.add(electricattackbuttonfunc);
      }
      if (string == "images/buttons/on/fireattackon.png") {
        funcfourlist.clear();
        funcfourlist.add(infinitejumpbuttonfunc);
      }
      if (string == "images/buttons/on/healthon.png") {
        funcfourlist.clear();
        funcfourlist.add(healthbuttonfunc);
      }
      if (string == "images/buttons/on/shieldon.png") {
        funcfourlist.clear();
        funcfourlist.add(shieldbuttonfunc);
      }
      if (string == "images/buttons/on/timeon.png") {
        funcfourlist.clear();
        funcfourlist.add(timebuttonfunc);
      }
      if (string == "images/buttons/on/wallbreakon.png") {
        funcfourlist.clear();
        funcfourlist.add(wallbreakbuttonfunc);
      }

      if (skillone == string) {
        skillone = "images/buttons/holder.png";
      }
      if (skilltwo == string) {
        skilltwo = "images/buttons/holder.png";
      }
      if (skillthree == string) {
        skillthree = "images/buttons/holder.png";
      }
      skillfour = string;
      cskillfour = string;
    }
  }

  scoresegment(o, oran, resim, fontoran, yazirenk, op, l) {
    return Opacity(
      opacity: op,
      child: Stack(
        children: [
          Positioned(
              child: Container(
            width: startbuttonwidth * oran,
            height: charmaxwidth * oran,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withAlpha(60),
                    blurRadius: 6.0,
                    spreadRadius: charmaxwidth / 8,
                    offset: const Offset(
                      0.0,
                      3.0,
                    ),
                  ),
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                    width: 2,
                    color: const Color(0xffDC23D4),
                    style: BorderStyle.solid)),
            margin: EdgeInsets.all(charmaxwidth * 5 / 46),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                    left: (startbuttonwidth * oran) -
                        (charmaxwidth * fontoran * 2),
                    child: SizedBox(
                      height: charmaxwidth * fontoran * 5 / 3,
                      child: Image.asset(highscoreflags[o]),
                    )),
                Positioned(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GradientText(
                      "${highscorenames[o]}   ",
                      colors: [yazirenk, Colors.deepPurple],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: (charmaxwidth * fontoran),
                      ),
                    ),
                    GradientText(
                      "${highscores[o]}",
                      colors: [yazirenk, Colors.deepPurple],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: (charmaxwidth * fontoran),
                      ),
                    )
                  ],
                ))
              ],
            ),
          )),
          Positioned(
            child: Container(
              width: charmaxwidth * oran * l,
              height: charmaxwidth * oran * l,
              //resim
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(resim)),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  int multiply = 1;

  void updatedyh(xd) async {
    int count = await database.rawUpdate(
        'UPDATE DYH SET name = ?, value = ? WHERE name = ?', [xd, 1, xd]);
  }

  void updatemoney(xd) async {
    int count = await database.rawUpdate(
        'UPDATE Head SET name = ?, value = ? WHERE name = ?',
        ['Coin', xd, 'Coin']);
  }

  void updateemerald(xd) async {
    int count = await database.rawUpdate(
        'UPDATE Head SET name = ?, value = ? WHERE name = ?',
        ['Emerald', xd, 'Emerald']);
  }

  void moneyfunc() {
    setState(() {
      FlameAudio.play("highscore.wav");
      coinexpwidth = charmaxwidth * 3;
      coinexplode = true;
      Timer(const Duration(seconds: 1), () {
        setState(() {
          coinexpwidth = 0;
          coinexplode = false;
        });
      });

      money += (score.toInt()) * multiply;
      updatemoney(money);
      multiply = 1;
      secondkilit = true;
      snheight = 0;
    });
  }

  void enven() {
    setState(() {
      containertwoheight =
          (screenheight * 6 / 10 - (shopwidth / 4) - (charmaxwidth)) * 5 / 8;
      containeroneheight =
          (screenheight * 6 / 10 - (shopwidth / 4) - (charmaxwidth)) * 3 / 8;

      onmarket = false;
      if (shopheight == 0) {
        shopleft = (screenwidth / 2) - (shopwidth / 2);

        shopheight = screenheight * 6 / 10;
      } else {
        shopheight = 0;
        shopleft = -5000;
      }
    });
  }

  void shop() {
    setState(() {
      containertwoheight = 0;
      containeroneheight =
          screenheight * 6 / 10 - (shopwidth / 4) - (charmaxwidth);

      onmarket = true;
      if (shopheight == 0) {
        shopleft = (screenwidth / 2) - (shopwidth / 2);

        shopheight = screenheight * 6 / 10;
      } else {
        shopheight = 0;
        shopleft = -5000;
      }
    });
  }

  void highscoreendfunc() {
    setState(() {
      if (opening) {
        congm = startbuttonwidth;
        cong = true;
        Timer(const Duration(seconds: 3), () {
          setState(() {
            cong = false;
            congm = 0;
          });
        });
        snhop = 0;
        snhleft = mainareawidth / 10;
        snhtop = (screenheight / 4) + (mainareawidth * 9 / 10) + (charmaxwidth);
        snhsize = (charmaxwidth * 10) / 10;
        snhwidth = mainareawidth * 8 / 10;
        snhheight = 0;
      }
    });
  }

  gfendfunc() {
    setState(() {
      gftop = -200;
    });
  }

  handendfunc() {
    setState(() {
      handtop = -200;
    });
  }

  bossendfunc() {
    setState(() {
      if (bosstop > 0) {
        bosstop = -500;
      }
    });
  }

  void highscorefunc() {
    if (snhop == 1) {
      firstkilit = true;
      if (highscorenames[0] == "your record") {
        setState(() {
          confetitop = 0;
          opening = true;
          snhwidth = (startbuttonwidth * 9) / 10;
          snhheight = (charmaxwidth * 9) / 10;

          snhsize = (charmaxwidth * 6) / 10;

          snhtop = ((wallwidth) + (charmaxwidth * 5 / 46));

          snhleft = (startbuttonwidth) / 20;
        });
      } else if (highscorenames[1] == "your record") {
        setState(() {
          confetitop = charmaxwidth;
          opening = true;
          snhwidth = (startbuttonwidth * 8) / 10;
          snhheight = (charmaxwidth * 8) / 10;

          snhsize = (charmaxwidth * 6) / 10;

          snhtop = ((wallwidth) +
              (charmaxwidth * 5 / 46) +
              (charmaxwidth * 9 / 10) +
              (charmaxwidth * 5 / 46) +
              (charmaxwidth * 5 / 46));

          snhleft = (startbuttonwidth * 1) / 10;
        });
      } else if (highscorenames[2] == "your record") {
        setState(() {
          confetitop = charmaxwidth * 2;
          opening = true;
          snhwidth = (startbuttonwidth * 7) / 10;
          snhheight = (charmaxwidth * 7) / 10;

          snhsize = (charmaxwidth * 5) / 10;

          snhtop = ((wallwidth) +
              (charmaxwidth * 5 / 46) +
              (charmaxwidth * 9 / 10) +
              (charmaxwidth * 5 / 46) +
              (charmaxwidth * 5 / 46) +
              (charmaxwidth * 8 / 10) +
              (charmaxwidth * 5 / 46) +
              (charmaxwidth * 5 / 46));

          snhleft = (startbuttonwidth * 1.5) / 10;
        });
      } else {
        setState(() {
          opening = true;
          confetitop = (screenheight / 2) + wallwidth + charmaxwidth;
          snhwidth = (startbuttonwidth * 6) / 10;
          snhheight = (charmaxwidth * 6) / 10;

          snhsize = (charmaxwidth * 3) / 10;

          snhtop = screenheight -
              ((wallwidth) +
                  (charmaxwidth * 5 / 46) +
                  (charmaxwidth * 5 / 10) +
                  (charmaxwidth * 5 / 46) +
                  (charmaxwidth * 5 / 46) +
                  (charmaxwidth * 6 / 10) +
                  (charmaxwidth * 5 / 46) +
                  (charmaxwidth * 5 / 46));

          snhleft = (startbuttonwidth * 2) / 10;
        });
      }
    }
  }

  void replacer(xd) {
    if (cskillone == "images/buttons/off/" + xd + "off.png") {
      cskillone = "images/buttons/on/" + xd + "on.png";
    }
    if (cskilltwo == "images/buttons/off/" + xd + "off.png") {
      cskilltwo = "images/buttons/on/" + xd + "on.png";
    }
    if (cskillthree == "images/buttons/off/" + xd + "off.png") {
      cskillthree = "images/buttons/on/" + xd + "on.png";
    }
    if (cskillfour == "images/buttons/off/" + xd + "off.png") {
      cskillfour = "images/buttons/on/" + xd + "on.png";
    }
  }

  void startbuttonfunc() {
    if (deathcount == 0) {
      _interstitialAd?.show();
    }
    if (firstkilit == false) {
      firstkilit = true;
      snhop = 0;
      snhleft = mainareawidth / 10;
      snhtop = (screenheight / 4) + (mainareawidth * 9 / 10) + (charmaxwidth);
      snhsize = (charmaxwidth * 10) / 10;
      snhwidth = mainareawidth * 8 / 10;
      snhheight = 0;
    }
    if (secondkilit == false) {
      moneyfunc();
    }

    if (firstkilit &&
        secondkilit &&
        thirdkilit &&
        bosstop < 0 &&
        mcanitop > screenheight) {
      setState(() {
        if (flagcostume) {
          if (usedflag != "images/flags/small/off.png") {
            choosenskin = usedflag;
            choosenskinbig = usedflagbig;
          }
        } else {
          choosenskin = usedskin;
          choosenskinbig = usedskinbig;
        }

        if (choosenvariat == "pirate" || choosenvariat == "final") {
          minsinir = 3;
          maxdragmin = 4;
        } else {
          maxdragmin = 2;
          minsinir = 1;
        }
        sinir = minsinir;
        zorluk = 0;
        firstcol = false;
        onskills = false;
        onskins = false;
        onitem = false;
        isgamestartedreally = true;
        howmanydragged = 0;
        maxdrag = maxdragmin;
        //game start
        shinetop = -500;
        sidewallbackuptwotop = -1 * (wallwidth * 4000 / 479);
        sidewallbackuptop = -1 * (wallwidth * 2000 / 479);
        sidewallonetop = 0;
        sidewalltwotop = wallwidth * 2000 / 479;
        sidewallthreetop = wallwidth * 4000 / 479;
        starbool = false;

        shopheight = 0;
        shopleft = -5000;

        isgameshakeon = true;

        replacer("attack");
        replacer("center");
        replacer("electricattack");

        replacer("exp");
        replacer("fireattack");
        replacer("health");
        replacer("jump");

        replacer("shield");
        replacer("time");
        replacer("wallbreak");

        canjump = true;
        cancenter = true;
        canattack = true;
        canelecattack = true;
        canfireattack = true;
        canexp = true;
        canhealth = true;
        canshield = true;
        cantime = true;
        canwallbreak = true;

        //geçici
        moneytop = -500;

        wallopen = true;

        //
        healthbarwidth = charmaxwidth * 4;
        leftleft = 0;
        rightleft = 0;
        Timer(const Duration(seconds: 1), () {
          setState(() {
            Timer.periodic(const Duration(milliseconds: brickfallmovesec),
                (tiii) {
              mk += 1;
              speedcalc(8 + zorluk);
              if (mk > 40) {
                tiii.cancel();
                mk = 0;
              }
            });

            frametopleft = (screenheight * 250 / 2000);
            framebottomleft = (mainareawidth - (screenheight * 250 / 2000)) -
                (((screenheight * 100) / 2000) * 6);
            frameoneleft = 0;
            frametwoleft = mainareawidth - (screenheight * 250 / 2000);
          });
        });

        //
        mcanitop = screenheight * 3 / 5;

        bosstop = screenheight / 4;
        handtop = screenheight / 2 + charmaxwidth / 3 - charmaxwidth / 2;
        gfleft = mainareawidth / 2 - gfwidth / 2;

        animimageop = 1.0;
        isanimationfinished = !isanimationfinished;
        healthcount = 4;
        if (healthcount == 4) {
          fourthbar = true;
          thirdbar = true;
          secondbar = true;
          firstbar = true;
        }
        score = 0;
        leftbrickcangivepoint = true;
        leftbrickcangivepointsec = true;
        rightbrickcangivepoint = true;
        walldropcount = 0;

        isleftstarted = true;
        rightstarted = true;
        isleftstartedsec = true;

        healthbartop = charmaxwidth * 3 / 2;

        animatedshootertop = screenheight - shooterheight + charmaxwidth / 3;
        Timer(const Duration(seconds: 1), () {
          shootertop = screenheight - shooterheight + charmaxwidth / 3;
          animatedshooterheight = 0;
        });

        buttonwidth = wallwidth * 7 / 10;

        startbuttontop = -500;
        startbuttonleft = -500;
      });
    }
  }

  double mk = 0;

  void brickformations(sec) {
    if (sec == 1) {
      rightbricktop = -1 * (rightbrickheight * 1.5);
      leftbricktop = -1 * ((leftbrickheight * 1.5) + (screenheight * 1 / 3));
      leftbricktopsec =
          -1 * (leftbrickheightsec * 1.5 + (screenheight * 2 / 3));
    }
    if (sec == 2) {
      rightbricktop = -1 * (rightbrickheight * 1.5 + (screenheight * 1 / 3));
      leftbricktop = -1 * ((leftbrickheight * 1.5));
      leftbricktopsec =
          -1 * (leftbrickheightsec * 1.5 + (screenheight * 2 / 3));
    }
    if (sec == 3) {
      rightbricktop = -1 * (rightbrickheight * 1.5 + (screenheight * 2 / 3));
      leftbricktop = -1 * ((leftbrickheight * 1.5) + (screenheight * 1 / 3));
      leftbricktopsec = -1 * (leftbrickheightsec * 1.5);
    }
  }

  void hitanimation() {
    splashtop = mainbodytop + charmaxwidth / 2;
    splashleft = mainbodyleft + charmaxwidth / 2;
    splash = false;

    canshake = true;
    Timer(const Duration(milliseconds: 200), () {
      canshake = false;
    });
  }

  void arrowdrawer() {
    getcurrentpos();

    arrowop = 1;
    arrowopsec = 1;

    arrowtimer = Timer.periodic(const Duration(milliseconds: 50), (ta) {
      setState(() {
        getcurrentpos();

        mesafe = sqrt(pow(
                ((currentpos.dx - charmaxwidth / 2) -
                        (mainbodyleft + wallwidth - (charmaxwidth / 2)))
                    .abs(),
                2) +
            pow(
                ((currentpos.dy - charmaxwidth / 2) -
                        (mainbodytop + (charmaxwidth / 2)))
                    .abs(),
                2));
        //
        if (currentpos.dy > (mainbodytop)) {
          rotation = (2 * pi) -
              atan((currentpos.dx -
                      (charmaxwidth / 2) -
                      (mainbodyleft + wallwidth - (charmaxwidth / 2))) /
                  (currentpos.dy +
                      (charmaxwidth / 2) -
                      (mainbodytop + (charmaxwidth / 2))));
          if (mesafe < maxlength) {
            arrowheight = sqrt(pow(
                    (currentpos.dx - charmaxwidth / 2) -
                        (mainbodyleft + wallwidth - (charmaxwidth / 2)),
                    2) +
                pow(
                    (currentpos.dy - charmaxwidth / 2) -
                        (mainbodytop + (charmaxwidth / 2)),
                    2));
          } else {
            arrowheight = maxlength;
          }

          //change
          arrowtop = mainbodytop + (charmaxwidth / 2);
          arrowleft = mainbodyleft;
          //

          arrowsectop = arrowtop - arrowheight;
          arrowsecleft = arrowleft;
          arrowsecoffset = Offset(charmaxwidth / 2, arrowheight);
          rotationsec = rotation;
          //
          //
        } else {
          rotation = pi +
              atan(((currentpos.dx - charmaxwidth / 2) -
                      (mainbodyleft + wallwidth - (charmaxwidth / 2))) /
                  ((mainbodytop - (charmaxwidth / 2)) -
                      (currentpos.dy - charmaxwidth / 2)));
          if (mesafe < maxlength) {
            arrowheight = sqrt(pow(
                    (currentpos.dx - charmaxwidth / 2) -
                        (mainbodyleft + wallwidth - (charmaxwidth / 2)),
                    2) +
                pow(
                    (mainbodytop + (charmaxwidth / 2)) -
                        (currentpos.dy - charmaxwidth / 2),
                    2));
          } else {
            arrowheight = maxlength;
          }
          //change
          arrowtop = mainbodytop + (charmaxwidth / 2);
          arrowleft = mainbodyleft;
          //
          arrowsectop = arrowtop - arrowheight;
          arrowsecleft = arrowleft;
          arrowsecoffset = Offset(charmaxwidth / 2, arrowheight);

          rotationsec = rotation;
        }
      });
    });
  }

  getcurrentpos() {
    try {
      RenderBox boxx =
          dragablekey.currentContext?.findRenderObject() as RenderBox;
      currentpos = boxx.localToGlobal(Offset.zero);
      // ignore: empty_catches
    } catch (e) {}
  }

  playerscorefunc() {
    setState(() {
      for (int p = 0; p < highscorenames.length; p++) {
        if (highscorenames[p] == "your record") {
          sira = p;
          try {
            test = scoresegment(sira - 1, 5 / 10,
                "images/medals/bronzmedal.png", 5 / 20, Colors.black, 0.4, 0);
            playerscorewidgetlist.add(test);
            // ignore: empty_catches
          } catch (e) {}

          test = scoresegment(sira, 6 / 10, "images/medals/bronzmedal.png",
              6 / 20, Colors.black, 1.0, 0);
          playerscorewidgetlist.add(test);

          test = scoresegment(sira + 1, 5 / 10, "images/medals/bronzmedal.png",
              5 / 20, Colors.black, 0.4, 0);
          playerscorewidgetlist.add(test);
          break;
        }
      }
    });
  }

  topscorefunc() {
    for (int o = 0; o < highscores.length; o++) {
      if (o == 0) {
        test = scoresegment(o, 9 / 10, "images/medals/goldmedal.png", 9 / 24,
            Colors.orange, 1.0, 1);
        scorewidgetlist.add(test);
      } else if (o == 1) {
        test = scoresegment(o, 8 / 10, "images/medals/silvermedal.png", 8 / 24,
            Colors.purple, 1.0, 1);
        scorewidgetlist.add(test);
      } else if (o == 2) {
        test = scoresegment(o, 7 / 10, "images/medals/bronzmedal.png", 7 / 24,
            Colors.blue, 1.0, 1);
        scorewidgetlist.add(test);
      }
    }
  }

  void shooterfunc() {
    if (choosenvariat == "eng" || choosenvariat == "final") {
    } else {
      kilit = false;
      freemove = true;
      shootloadcount = 0;

      shootertimer =
          Timer.periodic(const Duration(milliseconds: shootermovesec), (st) {
        loadzero = true;
        loadone = true;
        loadtwo = true;
        loadthree = true;
        loadfour = true;
        loadfive = true;
        if (walldropcount % 6 == 0 && walldropcount > 0) {
          freemove = false;
        }
        if (freemove) {
          shootloadcount = 0;
          setState(() {
            if (!kilit) {
              shooterrot += shootermovespeed;
            } else {
              shooterrot -= shootermovespeed;
            }
          });
          if (shooterrot > pi / 4) {
            kilit = true;
          }
          if (shooterrot < -1 * (pi / 4)) {
            kilit = false;
          }
        } else {
          if (loadthree) {
            setState(() {
              shooterimage = "images/shooterfolder/ss3.png";
            });
            loadthree = false;
          }
          shootloadcount += 1;
          if (shootloadcount > 0 && shootloadcount <= 69) {
            setState(() {
              if (((shooterleft + (shooterwidth / 2)) -
                          (mainbodyleft + (charmaxwidth / 2)))
                      .abs() <
                  5) {
              } else if ((shooterleft + (shooterwidth / 2)) >
                  (mainbodyleft + (charmaxwidth / 2))) {
                shooterrot = -1 *
                    (pi / 2 -
                        atan(((shootertop + (shooterheight)) -
                                (mainbodytop + (charmaxwidth / 2))) /
                            ((shooterleft + (shooterwidth / 2)) -
                                (mainbodyleft + (charmaxwidth / 2)))));
              } else {
                shooterrot = 1 *
                    (pi / 2 -
                        atan(((shootertop + (shooterheight)) -
                                (mainbodytop + (charmaxwidth / 2))) /
                            ((mainbodyleft + (charmaxwidth / 2)) -
                                (shooterleft + (shooterwidth / 2)))));
              }
              finalshooterrot = shooterrot;
              hitpointx = mainbodyleft;
              hitpointy = mainbodytop;
            });
          } else if (shootloadcount > 69 && shootloadcount <= 99) {
            if (loadtwo) {
              setState(() {
                shooterimage = "images/shooterfolder/ss2.png";
              });
              loadtwo = false;
            }
          } else if (shootloadcount > 99 && shootloadcount <= 130) {
            if (loadfour) {
              setState(() {
                shooterimage = "images/shooterfolder/ss1.png";
              });
              loadfour = false;
            }
          } else if (shootloadcount > 130 && shootloadcount <= 200) {
            FlameAudio.play("lasershot.mp3");
            lasershake = true;
            if (loadone) {
              setState(() {
                shooterimage = "images/shooterfolder/ss1.png";
                laserheight = (shootertop - hitpointy) * 5;
                lasertop = (shootertop + shooterheight) - laserheight;
                laserleft = mainareawidth / 2 - laserwidth / 2;
                laseroffset = Offset(laserwidth / 2, laserheight);
                loadone = false;
              });
            }

            laserrot = finalshooterrot;
            charangle = atan(
                (mainbodyleft + (charmaxwidth / 2) - mainareawidth / 2) /
                    (screenheight - mainbodytop + (charmaxwidth / 2)));

            if (laserrot > 0) {
              if (charangle > laserrot) {
                if (charangle - laserrot < (pi / 2) / anglepay) {
                  islasershot = true;
                }
              } else {
                if (laserrot - charangle < (pi / 2) / anglepay) {
                  islasershot = true;
                }
              }
            }

            if (laserrot < 0) {
              if (charangle < laserrot) {
                if ((charangle * -1) - (laserrot * -1) < (pi / 2) / anglepay) {
                  islasershot = true;
                }
              } else {
                if ((laserrot * -1) - (charangle * -1) < (pi / 2) / anglepay) {
                  islasershot = true;
                }
              }
            }

            if (islasershot && candamage) {
              shootloadcount = 310;
              walldropcount += 1;
              FlameAudio.play("damage.mp3");

              if (shieldanim) {
                shieldanim = false;
                shieldtop = -500;
              } else {
                healthcount -= 1;
              }
              damagewidth = screenwidth;
              damageop = 0;
              splashtop = mainbodytop + charmaxwidth / 2;
              splashleft = mainbodyleft + charmaxwidth / 2;
              splash = false;
              islasershot = false;
            }
            //
          } else if (shootloadcount > 200) {
            lasershake = false;
            if (loadzero) {
              setState(() {
                shooterimage = "images/shooterfolder/ss4.png";
              });
              loadzero = false;
            }
            setState(() {
              laserheight = 0;
            });
            freemove = true;
          }
        }
      });
    }
  }

  bool isrocketon = false;

  void rocketenemyfunc() {
    isrocketon = true;
    setState(() {
      rockettop = -100;
      rocketleft = Random()
              .nextInt((mainareawidth - (charmaxwidth * 2)).toInt())
              .toDouble() +
          charmaxwidth;
    });
  }

  bool isenemyon = false;

  bool enemyonecollision() {
    collisiony = (mainbodytop + (charmaxwidth / 2)) -
        (enemyonetop + (enemyoneheight / 2));
    collisionx = (mainbodyleft + (charmaxwidth / 2)) -
        (enemyoneleft + (enemyonewidth / 2));

    if (sqrt(((collisionx * collisionx).abs() +
            (collisiony * collisiony).abs())) <=
        ((charmaxwidth / 2) + (enemyoneheight) / 2)) {
      return true;
    } else {
      return false;
    }
  }

  int ed = 0;
  void topenemyfunc(w) {
    ed = w;
    isenemyon = true;
    setState(() {
      enemyoneleft = mainareawidth / 2 - enemyonewidth / 2;
      enemyonetop = -200;
    });
    sincount = 0;
  }

  double gettoppos = 0;
  double getleftpos = 0;

  bool isgamestarted = false;
  double splashsayi = 0;
  late JumpSplash xd;

  double firstthrow = 0;

  void mainthrowfunc(details) {
    FlameAudio.play("birak.wav", volume: 6);
    gettoppos = mainbodytop;
    getleftpos = mainbodyleft;

    if (firstthrow == 0) {
      gfendfunc();
      bossendfunc();
      handendfunc();
    }
    firstthrow += 1;

    xd = JumpSplash(
      width: charmaxwidth * 3,
      height: charmaxwidth * 3,
      top: mainbodytop - charmaxwidth * 1,
      left: mainbodyleft - charmaxwidth * 1,
    );

    setState(() {
      splashlist.add(xd);
    });
    if (splashlist.length == 6) {
      Timer(const Duration(seconds: 1), () {
        setState(() {
          splashlist = [];
        });
      });
    }

    isgamestarted = true;
    stm = 1;
    if (ismoving) {
      mover.cancel();
      canmove = false;
      ismoving = false;
    }
    azalmiktar = 7 * (arrowheight / 1400) + (0.6);

    if (howmanydragged > sinir) {
      maxdrag = 0;
    }

    mainbodyleftafterrelase = mainbodyleft;
    arrowtimer.cancel();
    looker.cancel();

    bounce = 1;
    onbottom = false;

    doeswallcolide = false;

    arrowheight = 0;

    isonwall = false;
    canmove = true;
    ismoving = true;
    arrowop = 0;
    arrowopsec = 0;
    yercekimietkisi = 0;
    anglemaker(details);
    manueltimer = 0;
    custommesafe = mesafe.round() * 50;
    //
    if (isleftstarted) {
      setState(() {
        brickfallfunc();
        //topenemyfunc(1);
        shooterfunc();
        isleftstarted = false;
      });
    }

    mover = Timer.periodic(const Duration(milliseconds: ballmovesec), (timer) {
      maincharrot += 0.005;

      if (mainbodytop < screenheight * 2 / 8) {
        mainbodytop -= normalspeed;
      }

      manueltimer += 1;
      if (details.offset.dx < movestartpos.dx) {
        if (details.offset.dy < movestartpos.dy) {
          walldropforthrow(7 * azalmiktar);
          if (-1 * (throwangle * 2) > pi / 2) {
            throwfunc(-1, -1);
          } else {
            throwfunc(1, 1);
          }
        } else {
          walldropforthrow(20 * throwangle * azalmiktar);
          throwfunc(1, 1);
        }
      } else {
        if (details.offset.dy < movestartpos.dy) {
          walldropforthrow(7 * azalmiktar);
          if (-1 * (throwangle * 2) > pi / 2) {
            throwfunc(1, -1);
          } else {
            throwfunc(-1, 1);
          }
        } else {
          walldropforthrow(20 * throwangle * azalmiktar);
          throwfunc(-1, 1);
        }
      }
      //

      if (ijanim) {
        ijtop = (mainbodytop + charmaxwidth / 2) - ijwidth / 2;
        ijleft = (mainbodyleft + charmaxwidth / 2) - ijwidth / 2;
      }
      if (imanim) {
        imtop = (mainbodytop + charmaxwidth / 2) - imwidth / 2;
        imleft = (mainbodyleft + charmaxwidth / 2) - imwidth / 2;
      }

      if (shieldanim) {
        shieldtop = (mainbodytop + charmaxwidth / 2) - shieldwidth / 2;
        shieldleft = (mainbodyleft + charmaxwidth / 2) - shieldwidth / 2;
      }

      if (manueltimer == custommesafe) {
        timer.cancel();
      }
    });
  }

  double stm = 1;

  void walldropforthrow(art) {
    setState(() {
      if (isonwall == false) {
        speedcalc((art * stm / 20) + zorluk);
      }
      if (art > 8 && mainbodytop < ((screenheight * 5) / 12)) {
        mainbodytop +=
            normalspeed * ((((screenheight * 6) / 12) - mainbodytop) / 140);
      }
    });
  }

  void walldrop() {
    setState(() {
      if (healthcount <= 0 || mainbodytop > (screenheight)) {
        setState(() {
          if (healthcount <= 0) {
            kilitforearn = true;
            rbool = true;
            Timer(const Duration(seconds: 1), () {
              setState(() {
                rcount = 2;
              });
            });
            Timer(const Duration(seconds: 2), () {
              setState(() {
                rcount = 1;
              });
            });
            Timer(const Duration(seconds: 3), () {
              setState(() {
                rcount = 0;
                kilitforearn = false;
                rbool = false;
              });
            });
          }

          deathcount += 1;
          if (deathcount % 3 == 0 || deathcount % 4 == 0) {
            _interstitialAd?.show();
          }

          isgameshakeon = false;

          splashlist = [];

          firstthrow = 0;
          isgamestartedreally = false;
          isgamestarted = false;
          sinir = minsinir;
          candamage = true;

          onskills = false;
          onskins = true;
          onitem = false;
          if (true) {
            try {
              looker.cancel();
              // ignore: empty_catches
            } catch (e) {}
            try {
              mover.cancel();
              // ignore: empty_catches
            } catch (e) {}
            try {
              walldroper.cancel();
              // ignore: empty_catches
            } catch (e) {}
            try {
              brick.cancel();
              // ignore: empty_catches
            } catch (e) {}

            try {
              shootertimer.cancel();
              // ignore: empty_catches
            } catch (e) {}
          }
          lasershake = false;

          firstcol = false;
          btbool = false;
          jumpbool = false;
          aimbool = false;
          //game screen close
          FlameAudio.play("damage.mp3");

          healthbartop = -500;

          if (true) {
            frametopleft = -(mainareawidth);
            framebottomleft = mainareawidth;
            frameoneleft = -((screenheight * 250 / 2000) + 100);
            frametwoleft = mainareawidth + 100;
            startbuttontext = "↻";
            //

            isdropmoneyon = false;
            dropmoneytop = -500;

            ijanim = false;
            ijtop = -500;

            imanim = false;
            imtop = -500;

            bethanim = false;
            bethtop = -500;

            betanim = false;
            bettop = -500;

            beoanim = false;
            beotop = -500;
            shooterimage = "images/shooterfolder/ss4.png";
            healthbarwidth = 0;
            starbool = true;
            scoreleft = -100;
            scoretop = -100;
            mainbodytop = -500;
            mainbodyleft = -500;

            laserleft = -1000;
            backwalltop = 0;
            backwalltopsec = -1 * screenheight;
            //
            shinetop = 0;
            thirdkilit = false;
            Timer(const Duration(milliseconds: 2000), () {
              setState(() {
                thirdkilit = true;
              });
            });
            buttonwidth = 0;
            Timer(const Duration(milliseconds: 500), () {
              setState(() {
                leftleft = -wallwidth;
                rightleft = wallwidth;
              });
            });
          }
          candoit = true;
          isondrop = false;

          backwalltop = 0;
          backwalltopsec = -1 * screenheight;

          aimanimone = false;
          aimwidthone = 0;
          aimanimtwo = false;
          aimwidthtwo = 0;
          aimanimthree = false;
          aimwidththree = 0;

          oneatshot = false;
          twoatshot = false;
          threeatshot = false;

          cansshoot = true;

          moneytop = charmaxwidth * 1 / 3;

          shooterrot = 0;
          shootertop = -500;
          animatedshooterheight = charmaxwidth * 3;
          animatedshootertop = screenheight * 3 / 2;

          shieldanim = false;
          shieldtop = -500;

          aimanimone = false;
          aimanimtwo = false;

          plantatop = -500;
          plantbtop = -500;
          plantctop = -500;
          isplantaon = false;
          isplantbon = false;
          isplantcon = false;

          isleftsideon = false;
          isrightsideon = false;
          sideplantlefttop = -500;
          sideplantrighttop = -500;

          enemyonetop = -500;
          rockettop = -500;

          brickformations(Random().nextInt(3) + 1);

          if (score > 0) {
            FlameAudio.play("moneyearn.wav");
            secondkilit = false;
            snheight = mainareawidth * 6 / 10;
            snend = score;
          }
          highscoremaker();
          startbuttonwidth = mainareawidth;
          startbuttonheight = screenheight;
          startbuttontop = 0;
          startbuttonleft = mainareawidth / 2 - startbuttonwidth / 2;
        });
        //burası
      }

      isondrop = true;
      walldroper =
          Timer.periodic(const Duration(milliseconds: brickfallmovesec), (dt) {
        if (mainbodytop < (screenheight * 8) / 12) {
          mainbodytop +=
              (normalspeed * (((screenheight * 8 / 12) - mainbodytop) / 90)) +
                  zorluk;
          speedcalc((((screenheight * 8 / 12) - mainbodytop) / 90) + zorluk);
        }

        mainbodytop += (normalspeed * 4 / 20) + zorluk;
        speedcalc((4 / 20) + zorluk);

        if (ijanim) {
          ijtop = (mainbodytop + charmaxwidth / 2) - ijwidth / 2;
          ijleft = (mainbodyleft + charmaxwidth / 2) - ijwidth / 2;
        }
        if (imanim) {
          imtop = (mainbodytop + charmaxwidth / 2) - imwidth / 2;
          imleft = (mainbodyleft + charmaxwidth / 2) - imwidth / 2;
        }

        if (shieldanim) {
          shieldtop = (mainbodytop + charmaxwidth / 2) - shieldwidth / 2;
          shieldleft = (mainbodyleft + charmaxwidth / 2) - shieldwidth / 2;
        }
      });
    });
  }

  void throwfunc(int x, int y) {
    if (canmove) {
      setState(() {
        if ((throwangle * 2).abs() > 0 && (throwangle * 2).abs() <= pi / 2) {
          mainbodyleft = mainbodyleft + (azalmiktar * x * bounce);

          if (!doeswallcolide) {
            mainbodytop = mainbodytop - (y * ((azalmiktar * tan(throwangle))));
          }
        } else if ((throwangle * 2).abs() > pi / 2 &&
            (throwangle * 2).abs() <= pi) {
          if (!doeswallcolide) {
            mainbodytop = mainbodytop - (y * (azalmiktar));
          }
          mainbodyleft = mainbodyleft +
              (bounce * azalmiktar * x * pow(tan(throwangle), -1));
        }
        //
        //
        if (manueltimer > ((mesafe.round() / 30) * 30)) {
          //burası
          yercekimietkisi += 1;

          mainbodytop = mainbodytop + (yercekimietkisi / 100);
        }

        if (mainbodyleft < -3 ||
            mainbodyleft > 3 + (mainareawidth.round() - ((charmaxwidth)))) {
          firstcol = true;
          gftop = (screenheight / 2) - charmaxwidth / 2;
          gfleft = -800;
          FlameAudio.play("dokunma.wav");
          howmanydragged = 0;
          maxdrag = maxdragmin;
          manueltimer = custommesafe;
          ismoving = false;
          walldrop();

          canshake = true;
          Timer(const Duration(milliseconds: 200), () {
            canshake = false;
          });
          if (mainbodyleft < 0) {
            mainbodyleft = 0;
          } else {
            mainbodyleft = mainareawidth - charmaxwidth;
          }
        }
      });
    }
  }

  void dragstartfunc() {
    FlameAudio.play("cek.mp3");
    //RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
    movestartpos = Offset(
        mainbodyleft + (charmaxwidth / 2), mainbodytop + (charmaxwidth / 2));
    howmanydragged += 1;

    arrowdrawer();
    looker =
        Timer.periodic(const Duration(milliseconds: brickfallmovesec), (l) {
      setState(() {
        mainbodytop += (normalspeed * 2 / 25);
        speedcalc(2 / 15);
      });
    });

    if (isondrop) {
      walldroper.cancel();
      isondrop = false;
    }
    isonwall = false;
    arrowheight = 0;
    if (ismoving) {
      manueltimer = -100000;
      stm = 1 / 10;
      azalmiktar = azalmiktar / 10;
    }
  }

  void anglemaker(details) {
    mesafe = sqrt(
        pow((details.offset.dx - (mainbodyleft + wallwidth)).abs(), 2) +
            pow(
                (details.offset.dy -
                        (mainbodytop +
                            (charmaxwidth / 2) -
                            MediaQuery.of(context).padding.top))
                    .abs(),
                2));
    if (mesafe > maxlength) {
      mesafe = maxlength;
    }

    if ((details.offset.dx - (mainbodyleft + wallwidth)) < 0) {
      throwangle = atan((details.offset.dy -
              (mainbodytop +
                  (charmaxwidth / 2) -
                  MediaQuery.of(context).padding.top)) /
          ((mainbodyleft + wallwidth) - details.offset.dx));
    } else {
      throwangle = atan((details.offset.dy -
              (mainbodytop +
                  (charmaxwidth / 2) -
                  MediaQuery.of(context).padding.top)) /
          (details.offset.dx - (mainbodyleft + wallwidth)));
    }
  }

  bool intersects(
      brickwidth, brickheight, brickleft, bricktop, angleone, angletwo) {
    circleDistancex = ((((mainbodyleft * angleone) + (charmaxwidth / 2)) -
            (brickleft + (brickwidth / 2)))
        .abs());
    circleDistancey = ((((mainbodytop * angletwo) + (charmaxwidth / 2)) -
            (bricktop + (brickheight / 2)))
        .abs());

    if (circleDistancex > (brickwidth / 2 + (charmaxwidth / 2))) {
      return false;
    }
    if (circleDistancey > (brickheight / 2 + (charmaxwidth / 2))) {
      return false;
    }

    if (circleDistancex <= (brickwidth / 2)) {
      return true;
    }
    if (circleDistancey <= (brickheight / 2)) {
      return true;
    }

    cornerDistancesq = pow((circleDistancex - brickwidth / 2), 2) +
        pow((circleDistancey - brickheight / 2), 2) as double;

    return (cornerDistancesq <= ((charmaxwidth / 2) * (charmaxwidth / 2)));
  }

  void hupdater(xd, cd, pd) async {
    int countb = await database.rawUpdate(
        'UPDATE LH SET name = ?, bir = ?, iki = ?, uc = ?, dort = ?, bes = ?, alti = ?, yedi = ?, sekiz = ?, dokuz = ?, ten = ? WHERE name = ?',
        [
          'flags',
          xd[0],
          xd[1],
          xd[2],
          xd[3],
          xd[4],
          xd[5],
          xd[6],
          xd[7],
          xd[8],
          xd[9],
          'flags'
        ]);
    int countc = await database.rawUpdate(
        'UPDATE LH SET name = ?, bir = ?, iki = ?, uc = ?, dort = ?, bes = ?, alti = ?, yedi = ?, sekiz = ?, dokuz = ?, ten = ? WHERE name = ?',
        [
          'names',
          cd[0],
          cd[1],
          cd[2],
          cd[3],
          cd[4],
          cd[5],
          cd[6],
          cd[7],
          cd[8],
          cd[9],
          'names'
        ]);
    int countd = await database.rawUpdate(
        'UPDATE HighScores SET name = ?, bir = ?, iki = ?, uc = ?, dort = ?, bes = ?, alti = ?, yedi = ?, sekiz = ?, dokuz = ?, ten = ? WHERE name = ?',
        [
          'scores',
          pd[0],
          pd[1],
          pd[2],
          pd[3],
          pd[4],
          pd[5],
          pd[6],
          pd[7],
          pd[8],
          pd[9],
          'scores'
        ]);
  }

  void highscoremaker() {
    for (int z = 0; z < highscores.length; z++) {
      if (highscorenames[z] == "your record") {
        scoresira = z;
        break;
      }
    }

    for (int q = 0; q < scoresira + 1; q++) {
      if (highscores[q] < score) {
        setState(() {
          opening = false;
          //
          firstkilit = false;
          snhheight = mainareawidth * 3 / 10;
          if (score > 99) {
            snhsize = (charmaxwidth * 8) / 10;
          }
          if (score > 999) {
            snhsize = (charmaxwidth * 7) / 10;
          }
          highscoreann = "$score";
          snhop = 1;
        });

        highscorenames.remove("your record");
        highscores.removeAt(scoresira);

        highscoreflags.remove(mcflag);
        highscoreflags.insert(q, mcflag);

        highscorenames.insert(q, "your record");
        highscores.insert(q, score);

        //nnhere
        hupdater(highscoreflags, highscorenames, highscores);

        playerscorewidgetlist = [];
        scorewidgetlist = [];

        playerscorefunc();
        topscorefunc();

        break;
      }
    }
  }

  void speedcalc(p) {
    if (isgamestartedreally == true) {
      setState(() {
        backwalltop += normalspeed * p / 2.5;
        backwalltopsec += normalspeed * p / 2.5;

        sidewallonetop += (normalspeed * p);
        sidewalltwotop += (normalspeed * p);
        sidewallthreetop += (normalspeed * p);
        sidewallbackuptop += (normalspeed * p);
        sidewallbackuptwotop += (normalspeed * p);

        leftbricktop += (normalspeed * p);
      });

      if (isrocketon) {
        setState(() {
          rockettop += (normalspeed * 3 * p);
        });
      }

      if (isenemyon) {
        setState(() {
          enemyonerot += 0.005;
          sincount += 0.1;
          enemyonetop += normalspeed * 1 * p;
          enemyoneleft = enemyoneleft = mainareawidth / 2 - enemyonewidth / 2;
          enemyoneleft += (mainareawidth / 2 - enemyonewidth * 2) *
              ((3 * (charmaxwidth / 10) / 6) *
                  ed *
                  sin(sincount / (charmaxwidth * 20 / 30)));
        });
      }

      if (isdropmoneyon) {
        setState(() {
          dropmoneytop += (normalspeed * p);
        });
      }

      if (rightstarted) {
        setState(() {
          rightbricktop += (normalspeed * p);
        });
      }
      if (isleftstartedsec) {
        setState(() {
          leftbricktopsec += (normalspeed * p);
        });
      }
      if (isplantbon) {
        setState(() {
          plantbtop += (normalspeed * p);
        });
      }
      if (isplantaon) {
        setState(() {
          plantatop += (normalspeed * p);
        });
      }
      if (isplantcon) {
        setState(() {
          plantctop += (normalspeed * p);
        });
      }
      if (aimanimone) {
        if (secim == 1) {
          setState(() {
            aimtopone = (sideplantlefttop + (sideplantleftheight / 2)) -
                (aimheightone / 2);
          });
        }
        if (secim == 2) {
          setState(() {
            aimtopone = (plantatop + (plantaheight / 2)) - (aimheightone / 2);
          });
        }
      }
      if (aimanimtwo) {
        if (secim == 1) {
          setState(() {
            aimtoptwo = (sideplantrighttop + (sideplantrightheight / 2)) -
                (aimheighttwo / 2);
          });
        }
        if (secim == 2) {
          setState(() {
            aimtoptwo = (plantbtop + (plantbheight / 2)) - (aimheighttwo / 2);
          });
        }
      }
      if (aimanimthree) {
        if (secim == 2) {
          setState(() {
            aimtopthree =
                (plantctop + (plantcheight / 2)) - (aimheightthree / 2);
          });
        }
      }

      if (isleftsideon) {
        setState(() {
          sideplantlefttop += (normalspeed * p);
        });
      }
      if (isrightsideon) {
        setState(() {
          sideplantrighttop += (normalspeed * p);
        });
      }
    }
  }

  bool isleftsideon = false;
  bool isrightsideon = false;

  void sideplantleftfunc() {
    isleftsideon = true;
    sideplantleftheight = wallwidth * 2000 / 479;
    sideplantleftwidth = sideplantleftheight * 485 / 1879;
    sideplantlefttop = sidewallonetop;
    sideplantleftleft = wallwidth - (sideplantleftwidth / 2);
  }

  void sideplantrightfunc() {
    isrightsideon = true;
    sideplantrightheight = wallwidth * 2000 / 479;
    sideplantrightwidth = sideplantrightheight * 485 / 1879;
    sideplantrighttop = sidewallthreetop;
    sideplantrightleft = wallwidth + mainareawidth - (sideplantrightwidth / 2);
  }

  void plantafunc() {
    isplantaon = true;
    plantawidth = leftbrickwidth;
    plantaheight = plantawidth * (856) / (900);
    plantatop = leftbricktop - (plantaheight * 16 / 20);
  }

  void plantbfunc() {
    isplantbon = true;
    plantbwidth = rightbrickwidth;
    plantbheight = plantbwidth * (856) / (900);
    plantbtop = rightbricktop - (plantbheight * 16 / 20);
    plantbleft = rightbrickleft;
  }

  void plantcfunc() {
    isplantcon = true;
    plantcwidth = leftbrickwidthsec;
    plantcheight = plantcwidth * (856) / (900);
    plantctop = leftbricktopsec - (plantcheight * 16 / 20);
    plantcleft = leftbrickleftsec;
  }

  int secim = 0;

  int artan = 1;

  void brickfallfunc() {
    brick = Timer.periodic(const Duration(milliseconds: brickfallmovesec),
        (walltimer) {
      setState(() {
        if (true) {
          if (healthcount > 4) {
            setState(() {
              healthcount = 4;
            });
          }

          //damAGE TRACK

          if (healthcount == 4) {
            setState(() {
              fourthbar = true;
              thirdbar = true;
              secondbar = true;
              firstbar = true;
            });
          } else if (healthcount == 3) {
            setState(() {
              fourthbar = false;
              thirdbar = true;
              secondbar = true;
              firstbar = true;
            });
          } else if (healthcount == 2) {
            setState(() {
              fourthbar = false;
              thirdbar = false;
              secondbar = true;
              firstbar = true;
            });
          } else if (healthcount == 1) {
            setState(() {
              fourthbar = false;
              thirdbar = false;
              secondbar = false;
              firstbar = true;
            });
          } else if (healthcount == 0) {
            setState(() {
              fourthbar = false;
              thirdbar = false;
              secondbar = false;
              firstbar = false;
            });
          }
        }
      });

      if (laserheight < 0) {
        laserheight = 0;
      }

      if (oneatshot == false) {
        setState(() {
          aimleftone = (mainbodyleft + charmaxwidth / 2) +
              wallwidth -
              (aimheightone / 2);
          aimtopone = (mainbodytop + charmaxwidth / 2) - (aimheightone / 2);
        });
      }

      if (twoatshot == false) {
        setState(() {
          aimlefttwo = (mainbodyleft + charmaxwidth / 2) +
              wallwidth -
              (aimheighttwo / 2);
          aimtoptwo = (mainbodytop + charmaxwidth / 2) - (aimheighttwo / 2);
        });
      }

      if (threeatshot == false) {
        setState(() {
          aimleftthree = (mainbodyleft + charmaxwidth / 2) +
              wallwidth -
              (aimheightthree / 2);
          aimtopthree = (mainbodytop + charmaxwidth / 2) - (aimheightthree / 2);
        });
      }

      if (leftbricktop > mainbodytop && leftbrickcangivepoint) {
        setState(() {
          score += 1 * artan;
          leftbrickcangivepoint = false;
        });
      }
      if (leftbricktopsec > mainbodytop && leftbrickcangivepointsec) {
        setState(() {
          score += 1 * artan;
          leftbrickcangivepointsec = false;
        });
      }
      if (rightbricktop > mainbodytop && rightbrickcangivepoint) {
        setState(() {
          score += 1 * artan;
          rightbrickcangivepoint = false;
        });
      }

      if (healthcount <= 0 || mainbodytop > (screenheight)) {
        setState(() {
          rbool = true;
          Timer(const Duration(seconds: 1), () {
            setState(() {
              rcount = 2;
            });
          });
          Timer(const Duration(seconds: 2), () {
            setState(() {
              rcount = 1;
            });
          });
          Timer(const Duration(seconds: 3), () {
            setState(() {
              rcount = 0;
              rbool = false;
            });
          });

          deathcount += 1;
          if (deathcount % 3 == 0 || deathcount % 4 == 0) {
            _interstitialAd?.show();
          }

          isgameshakeon = false;

          splashlist = [];

          lasershake = false;

          firstthrow = 0;
          isgamestartedreally = false;
          isgamestarted = false;
          sinir = minsinir;
          candamage = true;

          onskills = false;
          onskins = true;
          onitem = false;
          if (true) {
            try {
              looker.cancel();
              // ignore: empty_catches
            } catch (e) {}
            try {
              mover.cancel();
              // ignore: empty_catches
            } catch (e) {}
            try {
              walldroper.cancel();
              // ignore: empty_catches
            } catch (e) {}
            try {
              brick.cancel();
              // ignore: empty_catches
            } catch (e) {}

            try {
              shootertimer.cancel();
              // ignore: empty_catches
            } catch (e) {}
          }
          firstcol = false;
          btbool = false;
          jumpbool = false;
          aimbool = false;

          //game screen close
          FlameAudio.play("damage.mp3");
          healthbartop = -500;

          if (true) {
            frametopleft = -(mainareawidth);
            framebottomleft = mainareawidth;
            frameoneleft = -((screenheight * 250 / 2000) + 100);
            frametwoleft = mainareawidth + 100;
            startbuttontext = "↻";
            //

            isdropmoneyon = false;
            dropmoneytop = -500;

            ijanim = false;
            ijtop = -500;

            imanim = false;
            imtop = -500;

            bethanim = false;
            bethtop = -500;

            betanim = false;
            bettop = -500;

            beoanim = false;
            beotop = -500;
            shooterimage = "images/shooterfolder/ss4.png";
            healthbarwidth = 0;
            starbool = true;
            scoreleft = -100;
            scoretop = -100;
            mainbodytop = -500;
            mainbodyleft = -500;

            laserleft = -1000;
            backwalltop = 0;
            backwalltopsec = -1 * screenheight;
            //
            shinetop = 0;
            thirdkilit = false;
            Timer(const Duration(milliseconds: 2000), () {
              setState(() {
                thirdkilit = true;
              });
            });
            buttonwidth = 0;
            Timer(const Duration(milliseconds: 500), () {
              setState(() {
                leftleft = -wallwidth;
                rightleft = wallwidth;
              });
            });
          }
          candoit = true;
          isondrop = false;

          aimanimone = false;
          aimwidthone = 0;
          aimanimtwo = false;
          aimwidthtwo = 0;
          aimanimthree = false;
          aimwidththree = 0;

          backwalltop = 0;
          backwalltopsec = -1 * screenheight;

          oneatshot = false;
          twoatshot = false;
          threeatshot = false;

          cansshoot = true;

          moneytop = charmaxwidth * 1 / 3;

          shooterrot = 0;
          shootertop = -500;
          animatedshooterheight = charmaxwidth * 3;
          animatedshootertop = screenheight * 3 / 2;

          shieldanim = false;
          shieldtop = -500;

          aimanimone = false;
          aimanimtwo = false;

          plantatop = -500;
          plantbtop = -500;
          plantctop = -500;
          isplantaon = false;
          isplantbon = false;
          isplantcon = false;

          isleftsideon = false;
          isrightsideon = false;
          sideplantlefttop = -500;
          sideplantrighttop = -500;

          enemyonetop = -500;
          rockettop = -500;

          brickformations(Random().nextInt(3) + 1);

          if (score > 0) {
            secondkilit = false;
            snheight = mainareawidth * 6 / 10;
            snend = score;
          }
          highscoremaker();
          startbuttonwidth = mainareawidth;
          startbuttonheight = screenheight;
          startbuttontop = 0;
          startbuttonleft = mainareawidth / 2 - startbuttonwidth / 2;
        });
        //burası
      }

      if (sqrt(((((mainbodyleft + (charmaxwidth / 2)) -
                          (dropmoneyleft + (dropmoneywidth / 2))) *
                      ((mainbodyleft + (charmaxwidth / 2)) -
                          (dropmoneyleft + (dropmoneywidth / 2))))
                  .abs() +
              (((mainbodytop + (charmaxwidth / 2)) -
                          (dropmoneytop + (dropmoneywidth / 2))) *
                      ((mainbodytop + (charmaxwidth / 2)) -
                          (dropmoneytop + (dropmoneywidth / 2))))
                  .abs())) <=
          ((charmaxwidth / 2) + (dropmoneywidth / 2))) {
        setState(() {
          cetop = (dropmoneytop + (dropmoneywidth / 2)) - cewidth / 2;
          celeft = (dropmoneyleft + (dropmoneywidth / 2)) - cewidth / 2;

          ceanim = true;
          Timer(const Duration(seconds: 1), () {
            setState(() {
              ceanim = false;
              cetop = -500;
            });
          });

          score += 4;
          dropmoneytop = -100;
          dropmoneyleft = Random()
                  .nextInt((mainareawidth - (charmaxwidth * 2)).toInt())
                  .toDouble() +
              charmaxwidth;
        });
      }
      //
      //
      if (intersects(
          leftbrickwidth, leftbrickheight, leftbrickleft, leftbricktop, 1, 1)) {
        setState(() {
          howmanydragged = 0;
          maxdrag = maxdragmin;

          if (mainbodyleft + (charmaxwidth / 2) >
                  leftbrickleft + leftbrickwidth &&
              !onbottom &&
              mainbodyleftafterrelase > mainareawidth / 2) {
            bounce = -1;
            onbottom = false;
          } else {
            onbottom = true;
            if (mainbodytop < leftbricktop) {
              manueltimer = custommesafe;
              canmove = false;
              isonwall = true;
              ballstuckpos = "ilksolduvarust";
            } else {
              manueltimer = custommesafe;
              canmove = false;
              isonwall = true;

              ballstuckpos = "ilksolduvaraltı";
              //mainbodytop += 1;
              //doeswallcolide = true;
            }
          }
        });
      }
      if (intersects(rightbrickwidth, rightbrickheight, rightbrickleft,
          rightbricktop, 1, 1)) {
        setState(() {
          howmanydragged = 0;
          maxdrag = maxdragmin;

          if (rightbrickleft > mainbodyleft + charmaxwidth / 2 &&
              !onbottom &&
              mainbodyleftafterrelase < mainareawidth / 2) {
            bounce = -1;
            onbottom = false;
          } else {
            onbottom = true;
            if (mainbodytop < rightbricktop) {
              manueltimer = custommesafe;
              canmove = false;
              isonwall = true;
              ballstuckpos = "ilksagduvarust";
            } else {
              manueltimer = custommesafe;
              canmove = false;
              isonwall = true;

              ballstuckpos = "ilksagduvaraltı";

              //mainbodytop += 1;
              //doeswallcolide = true;
            }
          }
        });
      }
      if (intersects(leftbrickwidthsec, leftbrickheightsec, leftbrickleftsec,
          leftbricktopsec, 1, 1)) {
        setState(() {
          howmanydragged = 0;
          maxdrag = maxdragmin;

          if (!onbottom &&
              mainbodyleft + charmaxwidth / 2 < leftbrickleftsec &&
              mainbodyleftafterrelase < mainareawidth / 2) {
            bounce = -1;
            onbottom = false;
          } else if (!onbottom &&
              mainbodyleft + charmaxwidth / 2 >
                  leftbrickleftsec + leftbrickwidthsec &&
              mainbodyleftafterrelase > mainareawidth / 2) {
            bounce = -1;
            onbottom = false;
          } else {
            onbottom = true;
            if (mainbodytop < leftbricktopsec) {
              manueltimer = custommesafe;
              canmove = false;
              isonwall = true;
              ballstuckpos = "ucuncuduvar";
            } else {
              manueltimer = custommesafe;

              canmove = false;
              isonwall = true;
              ballstuckpos = "ortaduvaraltı";
              //mainbodytop += 1;
              //doeswallcolide = true;
            }
          }
        });
      }

      if (isenemyon) {
        if (enemyonecollision() && candamage) {
          setState(() {
            enemyonetop = -200;
            isenemyon = false;

            //damage yedi
            walldropcount += 1;
            FlameAudio.play("damage.mp3");
            if (shieldanim) {
              shieldanim = false;
              shieldtop = -500;
            } else {
              healthcount -= 1;
            }
            damagewidth = screenwidth;
            damageop = 0;

            hitanimation();

            ishit = false;
            enemycanspawn = true;
          });
        }

        if (enemyonetop > screenheight) {
          setState(() {
            enemyonetop = -200;
            isenemyon = false;
            enemycanspawn = true;
          });
        }
      }

      if (isrocketon) {
        if (intersects(
                rocketwidth, rocketwidth * 2, rocketleft, rockettop, 1, 1) &&
            candamage) {
          setState(() {
            rockettop = -500;
            walldropcount += 1;
            FlameAudio.play("damage.mp3");

            if (shieldanim) {
              shieldanim = false;
              shieldtop = -500;
            } else {
              healthcount -= 1;
            }
            damagewidth = screenwidth;
            damageop = 0;
            rocketcanspawn = true;
            hitanimation();
            isrocketon = false;
          });
        }

        if (rockettop > screenheight) {
          setState(() {
            rockettop = -500;
            rocketcanspawn = true;
            isrocketon = false;
          });
        }
      }

      if (isonwall) {
        if (mainbodytop < (screenheight * 8) / 12) {
          setState(() {
            speedcalc((((screenheight * 8 / 12) - mainbodytop) / 90) + zorluk);
          });
        }
        setState(() {
          speedcalc((4 / 20) + zorluk);

          if (ballstuckpos == "ilksagduvaraltı") {
            mainbodytop = rightbricktop + rightbrickheight + 3;
          }
          if (ballstuckpos == "ilksolduvaraltı") {
            mainbodytop = leftbricktop + leftbrickheight + 3;
          }
          if (ballstuckpos == "ortaduvaraltı") {
            mainbodytop = leftbricktopsec + leftbrickheightsec + 3;
          }
          if (ballstuckpos == "ilksagduvarust") {
            mainbodytop = rightbricktop - charmaxwidth;
          }
          if (ballstuckpos == "ucuncuduvar") {
            mainbodytop = leftbricktopsec - charmaxwidth;
          }
          if (ballstuckpos == "ilksolduvarust") {
            mainbodytop = leftbricktop - charmaxwidth;
          }
          if (ballstuckpos == "asd") {
            mainbodytop += normalspeed * 6 / 10;
          }
        });
      }

      if (isleftsideon &&
          intersects(
              sideplantleftwidth - (sideplantleftwidth * 1 / 10),
              sideplantleftheight - (sideplantleftwidth * 1 / 10),
              sideplantleftleft - wallwidth,
              sideplantlefttop + (sideplantleftwidth * 0.5 / 10),
              1,
              1) &&
          candamage) {
        setState(() {
          sideplantlefttop = -500;
          isleftsideon = false;
          FlameAudio.play("damage.mp3");

          if (shieldanim) {
            shieldanim = false;
            shieldtop = -500;
          } else {
            healthcount -= 1;
          }
          damagewidth = screenwidth;
          damageop = 0;
          hitanimation();
        });
      }

      if (isrightsideon &&
          intersects(
              sideplantrightwidth - (sideplantrightwidth * 1 / 10),
              sideplantrightheight - (sideplantrightwidth * 1 / 10),
              sideplantrightleft - wallwidth + (sideplantrightwidth * 1 / 10),
              sideplantrighttop + (sideplantrightwidth * 0.5 / 10),
              1,
              1) &&
          candamage) {
        setState(() {
          sideplantrighttop = -500;
          isrightsideon = false;
          FlameAudio.play("damage.mp3");

          if (shieldanim) {
            shieldanim = false;
            shieldtop = -500;
          } else {
            healthcount -= 1;
          }
          damagewidth = screenwidth;
          damageop = 0;
          hitanimation();
        });
      }

      if (isplantaon &&
          intersects(
              plantawidth - (plantawidth * 2 / 10),
              plantaheight,
              plantaleft + (plantawidth * 1 / 10),
              plantatop + (plantawidth * 2 / 10),
              1,
              1) &&
          candamage) {
        setState(() {
          FlameAudio.play("damage.mp3");

          plantatop = -500;
          isplantaon = false;
          if (shieldanim) {
            shieldanim = false;
            shieldtop = -500;
          } else {
            healthcount -= 1;
          }
          damagewidth = screenwidth;
          damageop = 0;
          hitanimation();
        });
      }
      if (isplantbon &&
          intersects(
              plantbwidth - (plantbwidth * 2 / 10),
              plantbheight,
              plantbleft + (plantbwidth * 1 / 10),
              plantbtop + (plantbwidth * 2 / 10),
              1,
              1) &&
          candamage) {
        setState(() {
          FlameAudio.play("damage.mp3");

          plantbtop = -500;
          isplantbon = false;
          if (shieldanim) {
            shieldanim = false;
            shieldtop = -500;
          } else {
            healthcount -= 1;
          }
          damagewidth = screenwidth;
          damageop = 0;
          hitanimation();
        });
      }
      if (isplantcon &&
          intersects(
              plantcwidth - (plantcwidth * 2 / 10),
              plantcheight,
              plantcleft + (plantcwidth * 1 / 10),
              plantctop + (plantcwidth * 2 / 10),
              1,
              1) &&
          candamage) {
        setState(() {
          plantctop = -500;
          isplantcon = false;
          if (shieldanim) {
            FlameAudio.play("damage.mp3");

            shieldanim = false;
            shieldtop = -500;
          } else {
            healthcount -= 1;
          }
          damagewidth = screenwidth;
          damageop = 0;
          hitanimation();
        });
      }

      //burasıolabilir
      if (sidewallonetop > screenheight + (wallwidth * 2000 / 479)) {
        setState(() {
          isleftsideon = false;
          sideplantlefttop = -500;

          sidewallonetop = -1 * (wallwidth * 2000 / 479);
          if (Random().nextInt(2) == 1) {
            sideplantleftfunc();
          }
        });
      }
      if (sidewalltwotop > screenheight + (wallwidth * 2000 / 479)) {
        setState(() {
          sidewalltwotop = -1 * (wallwidth * 2000 / 479);
        });
      }
      if (sidewallthreetop > screenheight + (wallwidth * 2000 / 479)) {
        setState(() {
          isrightsideon = false;
          sideplantrighttop = -500;
          sidewallthreetop = -1 * (wallwidth * 2000 / 479);
          if (Random().nextInt(2) == 1) {
            sideplantrightfunc();
          }
        });
      }
      if (sidewallbackuptop > screenheight + (wallwidth * 2000 / 479)) {
        setState(() {
          sidewallbackuptop = -1 * (wallwidth * 2000 / 479);
        });
      }
      if (sidewallbackuptwotop > screenheight + (wallwidth * 2000 / 479)) {
        setState(() {
          sidewallbackuptwotop = -1 * (wallwidth * 2000 / 479);
        });
      }

      if (backwalltop > screenheight) {
        setState(() {
          backwalltop = -1 * screenheight;
        });
      }
      if (backwalltopsec > screenheight) {
        setState(() {
          backwalltopsec = -1 * screenheight;
        });
      }

      //

      if (dropmoneytop > screenheight) {
        setState(() {
          dropmoneytop = -100;
          dropmoneyleft = Random()
                  .nextInt((mainareawidth - (charmaxwidth * 2)).toInt())
                  .toDouble() +
              charmaxwidth;
        });
      }

      if (leftbricktopsec > screenheight + plantcheight) {
        setState(() {
          plantctop = -500;
          isplantcon = false;

          ballstuckpos = "asd";
          newleftbrickwidth =
              Random().nextInt(mainareawidth ~/ 6) + (mainareawidth / 6);
          leftbrickheightsec = newleftbrickwidth * 76 / 140;
          leftbrickwidthsec = newleftbrickwidth;
          leftbrickleftsec = (mainareawidth / 2) - (newleftbrickwidth / 2);

          walldropcount += 1;
          leftbricktopsec = -1 * (leftbrickheightsec * 1.5);
          leftbrickcangivepointsec = true;
          if (Random().nextInt(prob) < 3) {
            plantcfunc();
          }
          if (Random().nextInt(prob) < 3 && enemycanspawn) {
            r = Random().nextInt(2);
            if (r > 0) {
              topenemyfunc(1);
              enemycanspawn = false;
            } else {
              topenemyfunc(-1);
              enemycanspawn = false;
            }
          }
        });
      }
      if (rightbricktop > screenheight + plantbheight) {
        setState(() {
          plantbtop = -500;
          isplantbon = false;

          ballstuckpos = "asd";

          newrightbrickwidth =
              Random().nextInt(mainareawidth ~/ 6) + (mainareawidth / 6);
          rightbrickheight = newrightbrickwidth * 76 / 140;
          shift = rightbrickwidth - newrightbrickwidth;
          rightbrickwidth = newrightbrickwidth;
          rightbrickleft += shift;
          rightbricktop = -1 * (rightbrickheight * 2);
          walldropcount += 1;
          rightbrickcangivepoint = true;
          if (Random().nextInt(prob) < 3) {
            plantbfunc();
          }
          if (Random().nextInt(prob) < 3 && rocketcanspawn) {
            rocketenemyfunc();
            rocketcanspawn = false;
          }
          if (Random().nextInt(prob) < 3 && enemycanspawn) {
            r = Random().nextInt(2);
            if (r > 0) {
              topenemyfunc(1);
              enemycanspawn = false;
            } else {
              topenemyfunc(-1);
              enemycanspawn = false;
            }
          }
        });
      }
      if (leftbricktop > screenheight + plantaheight) {
        setState(() {
          plantatop = -500;
          isplantaon = false;

          ballstuckpos = "asd";

          leftbrickwidth =
              Random().nextInt(mainareawidth ~/ 6) + (mainareawidth / 6);
          leftbrickheight = leftbrickwidth * 76 / 140;
          leftbricktop = -1 * (leftbrickheight * 2);
          walldropcount += 1;
          leftbrickcangivepoint = true;
          if (Random().nextInt(prob) < 3) {
            plantafunc();
          }
          if (Random().nextInt(prob) < 3 && rocketcanspawn) {
            rocketenemyfunc();
            rocketcanspawn = false;
          }
        });
      }

      if (walldropcount % 10 == 0 && walldropcount > 0) {
        walldropcount += 1;
        if (zorluk < 8 / 10) {
          zorluk += 1 / 20;
        }
        if (prob > 5) {
          prob -= 1;
        }
      }

      if (choosenvariat == "medic" || choosenvariat == "final") {
        if (walldropcount % 30 == 0 && walldropcount > 0) {
          setState(() {
            walldropcount += 1;
            healthcount += 1;
          });
        }
      }

      if (choosenvariat == "armor" || choosenvariat == "final") {
        if (walldropcount % 61 == 0) {
          setState(() {
            walldropcount += 1;

            shieldtop = (mainbodytop + charmaxwidth / 2) - shieldwidth / 2;
            shieldleft = (mainbodyleft + charmaxwidth / 2) - shieldwidth / 2;
            shieldanim = true;
          });
        }
      }
    });
  }

  void skillonefunc() {}
  void skilltwofunc() {}
  void skillthreefunc() {}
  void skillfourfunc() {}

  void healthbuttonfunc() {
    if (canhealth && isgamestarted) {
      setState(() {
        FlameAudio.play("mage.wav");
        if (cskillone == "images/buttons/on/healthon.png") {
          cskillone = "images/buttons/off/healthoff.png";
        }
        if (cskilltwo == "images/buttons/on/healthon.png") {
          cskilltwo = "images/buttons/off/healthoff.png";
        }
        if (cskillthree == "images/buttons/on/healthon.png") {
          cskillthree = "images/buttons/off/healthoff.png";
        }
        if (cskillfour == "images/buttons/on/healthon.png") {
          cskillfour = "images/buttons/off/healthoff.png";
        }
        canhealth = false;
        healthcount += 2;
      });
    }
  }

  void jumpbuttonfunc() {
    setState(() {
      if (canjump && isgamestarted) {
        if (mainbodytop > 150) {
          FlameAudio.play("mage.wav");

          ballstuckpos = "asd";
          manueltimer = custommesafe;
          //jumpfunc
          if (cskillone == "images/buttons/on/jumpon.png") {
            cskillone = "images/buttons/off/jumpoff.png";
          }
          if (cskilltwo == "images/buttons/on/jumpon.png") {
            cskilltwo = "images/buttons/off/jumpoff.png";
          }
          if (cskillthree == "images/buttons/on/jumpon.png") {
            cskillthree = "images/buttons/off/jumpoff.png";
          }
          if (cskillfour == "images/buttons/on/jumpon.png") {
            cskillfour = "images/buttons/off/jumpoff.png";
          }
          setState(() {
            mainbodytop -= 200;
            ltop = mainbodytop + charmaxwidth / 2;
            lleft = mainbodyleft +
                (charmaxwidth / 2) -
                (lwidth / 2) -
                charmaxwidth / 2;
            animate = true;
          });

          lftop = (mainbodytop + charmaxwidth / 2) - (lfwidth / 2);
          lfleft = (mainbodyleft + charmaxwidth / 2) - (lfwidth / 2);
          animatefinishln = true;

          Timer(const Duration(milliseconds: 666), () {
            setState(() {
              canjump = false;
              jumpbool = false;
              animatefinishln = false;
              lftop = -500;
              ltop = -500;
              Timer(const Duration(milliseconds: 1332), () {
                setState(() {
                  animate = false;
                });
              });
            });
          });
          canshake = true;
          Timer(const Duration(milliseconds: 200), () {
            canshake = false;
          });
        }
      }
    });
  }

  void centerbuttonfunc() {
    if (cancenter && isgamestarted) {
      setState(() {
        FlameAudio.play("mage.wav");

        ballstuckpos = "asd";
        manueltimer = custommesafe;

        if (cskillone == "images/buttons/on/centeron.png") {
          cskillone = "images/buttons/off/centeroff.png";
        }
        if (cskilltwo == "images/buttons/on/centeron.png") {
          cskilltwo = "images/buttons/off/centeroff.png";
        }
        if (cskillthree == "images/buttons/on/centeron.png") {
          cskillthree = "images/buttons/off/centeroff.png";
        }
        if (cskillfour == "images/buttons/on/centeron.png") {
          cskillfour = "images/buttons/off/centeroff.png";
        }
        cancenter = false;
        mainbodytop = screenheight / 2;
        mainbodyleft = mainareawidth / 2 - charmaxwidth / 2;
        //
        telepbool = false;
        telepanimate = true;
        teleptop = (mainbodytop + charmaxwidth / 2) - (telepwidth / 2);
        telepleft = (mainbodyleft + charmaxwidth / 2) - (telepwidth / 2);
        Timer(const Duration(milliseconds: telepsec), () {
          setState(() {
            telepbool = true;
            telepanimate = false;
            teleptop = -500;
          });
        });
      });
    }
  }

  void shieldbuttonfunc() {
    if (canshield && isgamestarted) {
      setState(() {
        FlameAudio.play("mage.wav");

        if (cskillone == "images/buttons/on/shieldon.png") {
          cskillone = "images/buttons/off/shieldoff.png";
        }
        if (cskilltwo == "images/buttons/on/shieldon.png") {
          cskilltwo = "images/buttons/off/shieldoff.png";
        }
        if (cskillthree == "images/buttons/on/shieldon.png") {
          cskillthree = "images/buttons/off/shieldoff.png";
        }
        if (cskillfour == "images/buttons/on/shieldon.png") {
          cskillfour = "images/buttons/off/shieldoff.png";
        }
        canshield = false;

        shieldtop = (mainbodytop + charmaxwidth / 2) - shieldwidth / 2;
        shieldleft = (mainbodyleft + charmaxwidth / 2) - shieldwidth / 2;
        shieldanim = true;
      });
    }
  }

  void electricattackbuttonfunc() {
    if (isgamestarted && canelecattack && cansshoot) {
      setState(() {
        FlameAudio.play("mage.wav");

        canelecattack = false;
        secim = 2;
        if (cskillone == "images/buttons/on/electricattackon.png") {
          cskillone = "images/buttons/off/electricattackoff.png";
        }
        if (cskilltwo == "images/buttons/on/electricattackon.png") {
          cskilltwo = "images/buttons/off/electricattackoff.png";
        }
        if (cskillthree == "images/buttons/on/electricattackon.png") {
          cskillthree = "images/buttons/off/electricattackoff.png";
        }
        if (cskillfour == "images/buttons/on/electricattackon.png") {
          cskillfour = "images/buttons/off/electricattackoff.png";
        }
        cansshoot = false;

        if (choosenvariat == "mage" || choosenvariat == "final") {
          if (isplantaon) {
            oneatshot = true;
            aimwidthone = charmaxwidth * 2;

            aimanimone = true;
            aimleftone = (plantaleft + (plantawidth / 2)) +
                wallwidth -
                (aimheightone / 2);

            aimtopone =
                (plantatop + (plantaheight * 3 / 4)) - (aimheightone / 2);
            Timer(const Duration(seconds: 2), () {
              aimbool = false;

              aimanimone = false;
              aimwidthone = 0;

              oneatshot = false;
              cansshoot = true;

              Timer(const Duration(milliseconds: 300), () {
                isplantaon = false;
                plantatop = -500;
              });

              expleftone = (aimleftone + (aimheightone / 2)) - expwidthone / 2;
              exptopone = (aimtopone + (aimheightone / 2)) - exphightone / 2;
              expboolone = true;
              Timer(const Duration(milliseconds: 1250), () {
                expboolone = false;
                exptopone = -500;
              });
            });
          }
          if (isplantbon) {
            twoatshot = true;
            aimwidthtwo = charmaxwidth * 2;

            aimanimtwo = true;
            aimlefttwo = (plantbleft + (plantbwidth / 2)) +
                wallwidth -
                (aimheighttwo / 2);

            aimtoptwo =
                (plantbtop + (plantbheight * 3 / 4)) - (aimheighttwo / 2);
            Timer(const Duration(seconds: 2), () {
              aimbool = false;

              aimanimtwo = false;
              aimwidthtwo = 0;

              twoatshot = false;
              cansshoot = true;

              Timer(const Duration(milliseconds: 300), () {
                isplantbon = false;
                plantbtop = -500;
              });

              explefttwo = (aimlefttwo + (aimheighttwo / 2)) - expwidthtwo / 2;
              exptoptwo =
                  (aimtoptwo + (aimheighttwo * 2 / 4)) - exphighttwo / 2;
              expbooltwo = true;
              Timer(const Duration(milliseconds: 1250), () {
                expbooltwo = false;
                exptoptwo = -500;
              });
            });
          }
          if (isplantcon) {
            threeatshot = true;
            aimwidththree = charmaxwidth * 2;

            aimanimthree = true;
            aimleftthree = (plantcleft + (plantcwidth / 2)) +
                wallwidth -
                (aimheightthree / 2);

            aimtopthree =
                (plantctop + (plantcheight * 3 / 4)) - (aimheightthree / 2);
            Timer(const Duration(seconds: 2), () {
              aimbool = false;

              aimanimthree = false;
              aimwidththree = 0;

              threeatshot = false;
              cansshoot = true;

              Timer(const Duration(milliseconds: 300), () {
                isplantcon = false;
                plantctop = -500;
              });

              expleftthree =
                  (aimleftthree + (aimheightthree / 2)) - expwidththree / 2;
              exptopthree =
                  (aimtopthree + (aimheightthree / 2)) - exphightthree / 2;
              expboolthree = true;
              Timer(const Duration(milliseconds: 1250), () {
                expboolthree = false;
                exptopthree = -500;
              });
            });
          }
        } else {
          if (isplantbon) {
            if (isplantbon) {
              twoatshot = true;
              aimwidthtwo = charmaxwidth * 2;

              aimanimtwo = true;
              aimlefttwo = (plantbleft + (plantbwidth / 2)) +
                  wallwidth -
                  (aimheighttwo / 2);

              aimtoptwo =
                  (plantbtop + (plantbheight * 3 / 4)) - (aimheighttwo / 2);
              Timer(const Duration(seconds: 2), () {
                aimbool = false;

                aimanimtwo = false;
                aimwidthtwo = 0;

                twoatshot = false;
                cansshoot = true;

                Timer(const Duration(milliseconds: 300), () {
                  isplantbon = false;
                  plantbtop = -500;
                });

                explefttwo =
                    (aimlefttwo + (aimheighttwo / 2)) - expwidthtwo / 2;
                exptoptwo =
                    (aimtoptwo + (aimheighttwo * 2 / 4)) - exphighttwo / 2;
                expbooltwo = true;
                Timer(const Duration(milliseconds: 1250), () {
                  expbooltwo = false;
                  exptoptwo = -500;
                });
              });
            }
          } else if (isplantcon) {
            if (isplantcon) {
              threeatshot = true;
              aimwidththree = charmaxwidth * 2;

              aimanimthree = true;
              aimleftthree = (plantcleft + (plantcwidth / 2)) +
                  wallwidth -
                  (aimheightthree / 2);

              aimtopthree =
                  (plantctop + (plantcheight * 3 / 4)) - (aimheightthree / 2);
              Timer(const Duration(seconds: 2), () {
                aimbool = false;

                aimanimthree = false;
                aimwidththree = 0;

                threeatshot = false;
                cansshoot = true;

                Timer(const Duration(milliseconds: 300), () {
                  isplantcon = false;
                  plantctop = -500;
                });

                expleftthree =
                    (aimleftthree + (aimheightthree / 2)) - expwidththree / 2;
                exptopthree =
                    (aimtopthree + (aimheightthree / 2)) - exphightthree / 2;
                expboolthree = true;
                Timer(const Duration(milliseconds: 1250), () {
                  expboolthree = false;
                  exptopthree = -500;
                });
              });
            }
          } else {
            if (isplantaon) {
              oneatshot = true;
              aimwidthone = charmaxwidth * 2;

              aimanimone = true;
              aimleftone = (plantaleft + (plantawidth / 2)) +
                  wallwidth -
                  (aimheightone / 2);

              aimtopone =
                  (plantatop + (plantaheight * 3 / 4)) - (aimheightone / 2);
              Timer(const Duration(seconds: 2), () {
                aimbool = false;

                aimanimone = false;
                aimwidthone = 0;

                oneatshot = false;
                cansshoot = true;

                Timer(const Duration(milliseconds: 300), () {
                  isplantaon = false;
                  plantatop = -500;
                });

                expleftone =
                    (aimleftone + (aimheightone / 2)) - expwidthone / 2;
                exptopone = (aimtopone + (aimheightone / 2)) - exphightone / 2;
                expboolone = true;
                Timer(const Duration(milliseconds: 1250), () {
                  expboolone = false;
                  exptopone = -500;
                });
              });
            }
          }
        }
      });
    }
  }

  void attackbuttonfunc() {
    //here
    //yan duvar ateşi
    if (isgamestarted && canattack && cansshoot) {
      setState(() {
        FlameAudio.play("mage.wav");
        canattack = false;
        secim = 1;
        if (cskillone == "images/buttons/on/attackon.png") {
          cskillone = "images/buttons/off/attackoff.png";
        }
        if (cskilltwo == "images/buttons/on/attackon.png") {
          cskilltwo = "images/buttons/off/attackoff.png";
        }
        if (cskillthree == "images/buttons/on/attackon.png") {
          cskillthree = "images/buttons/off/attackoff.png";
        }
        if (cskillfour == "images/buttons/on/attackon.png") {
          cskillfour = "images/buttons/off/attackoff.png";
        }
        cansshoot = false;

        if (choosenvariat == "mage" || choosenvariat == "final") {
          if (isleftsideon) {
            oneatshot = true;
            aimwidthone = charmaxwidth * 2;

            aimanimone = true;
            aimleftone = (sideplantleftleft + (sideplantleftwidth / 2)) -
                (aimheightone / 2);
            aimtopone = (sideplantlefttop + (sideplantleftheight * 2 / 4)) -
                (aimheightone / 2);
            Timer(const Duration(seconds: 2), () {
              aimbool = false;

              aimanimone = false;
              aimwidthone = 0;

              oneatshot = false;
              cansshoot = true;

              Timer(const Duration(milliseconds: 300), () {
                isleftsideon = false;
                sideplantlefttop = -500;
              });

              expleftone = (aimleftone + (aimheightone / 2)) - expwidthone / 2;
              exptopone = (aimtopone + (aimheightone / 2)) - exphightone / 2;
              expboolone = true;
              Timer(const Duration(milliseconds: 1250), () {
                expboolone = false;
                exptopone = -500;
              });
            });
          }

          if (isrightsideon) {
            twoatshot = true;
            aimwidthtwo = charmaxwidth * 2;

            aimanimtwo = true;
            aimlefttwo = (sideplantrightleft + (sideplantrightwidth / 2)) -
                (aimheighttwo / 2);
            aimtoptwo = (sideplantrighttop + (sideplantrightheight * 2 / 4)) -
                (aimheighttwo / 2);
            Timer(const Duration(seconds: 2), () {
              aimanimtwo = false;
              aimwidthtwo = 0;
              aimbool = false;

              twoatshot = false;
              cansshoot = true;

              explefttwo = (aimlefttwo + (aimheighttwo / 2)) - expwidthtwo / 2;
              exptoptwo = (aimtoptwo + (aimheighttwo / 2)) - exphighttwo / 2;
              expbooltwo = true;
              Timer(const Duration(milliseconds: 300), () {
                isrightsideon = false;
                sideplantrighttop = -500;
              });

              Timer(const Duration(milliseconds: 1250), () {
                expbooltwo = false;
                exptoptwo = -500;
              });
            });
          }
        } else {
          if (isleftsideon) {
            if (isleftsideon) {
              oneatshot = true;
              aimwidthone = charmaxwidth * 2;

              aimanimone = true;
              aimleftone = (sideplantleftleft + (sideplantleftwidth / 2)) -
                  (aimheightone / 2);
              aimtopone = (sideplantlefttop + (sideplantleftheight * 2 / 4)) -
                  (aimheightone / 2);
              Timer(const Duration(seconds: 2), () {
                aimanimone = false;
                aimbool = false;

                aimwidthone = 0;

                oneatshot = false;
                cansshoot = true;

                Timer(const Duration(milliseconds: 300), () {
                  isleftsideon = false;
                  sideplantlefttop = -500;
                });

                expleftone =
                    (aimleftone + (aimheightone / 2)) - expwidthone / 2;
                exptopone = (aimtopone + (aimheightone / 2)) - exphightone / 2;
                expboolone = true;
                Timer(const Duration(milliseconds: 1250), () {
                  expboolone = false;
                  exptopone = -500;
                });
              });
            }
          } else {
            if (isrightsideon) {
              twoatshot = true;
              aimwidthtwo = charmaxwidth * 2;

              aimanimtwo = true;
              aimlefttwo = (sideplantrightleft + (sideplantrightwidth / 2)) -
                  (aimheighttwo / 2);
              aimtoptwo = (sideplantrighttop + (sideplantrightheight * 2 / 4)) -
                  (aimheighttwo / 2);
              Timer(const Duration(seconds: 2), () {
                aimanimtwo = false;
                aimwidthtwo = 0;
                aimbool = false;

                twoatshot = false;
                cansshoot = true;

                explefttwo =
                    (aimlefttwo + (aimheighttwo / 2)) - expwidthtwo / 2;
                exptoptwo = (aimtoptwo + (aimheighttwo / 2)) - exphighttwo / 2;
                expbooltwo = true;
                Timer(const Duration(milliseconds: 300), () {
                  isrightsideon = false;
                  sideplantrighttop = -500;
                });

                Timer(const Duration(milliseconds: 1250), () {
                  expbooltwo = false;
                  exptoptwo = -500;
                });
              });
            }
          }
        }
      });
    }
  }

  void timebuttonfunc() {
    if (isgamestarted && cantime) {
      setState(() {
        FlameAudio.play("mage.wav");

        cantime = false;
        artan = 2;
        isdropmoneyon = true;

        dropmoneytop = -100;
        dropmoneyleft = Random()
                .nextInt((mainareawidth - (charmaxwidth * 2)).toInt())
                .toDouble() +
            charmaxwidth;
        if (cskillone == "images/buttons/on/timeon.png") {
          cskillone = "images/buttons/off/timeoff.png";
        }
        if (cskilltwo == "images/buttons/on/timeon.png") {
          cskilltwo = "images/buttons/off/timeoff.png";
        }
        if (cskillthree == "images/buttons/on/timeon.png") {
          cskillthree = "images/buttons/off/timeoff.png";
        }
        if (cskillfour == "images/buttons/on/timeon.png") {
          cskillfour = "images/buttons/off/timeoff.png";
        }
        ballcolor = Colors.amber;
        Timer(const Duration(seconds: 30), () {
          artan = 1;
          isdropmoneyon = false;
          dropmoneytop = -500;
          ballcolor = Colors.greenAccent;
        });
      });
    }
  }

  void infinitejumpbuttonfunc() {
    if (isgamestarted && canfireattack) {
      setState(() {
        FlameAudio.play("mage.wav");

        canfireattack = false;
        if (cskillone == "images/buttons/on/fireattackon.png") {
          cskillone = "images/buttons/off/fireattackoff.png";
        }
        if (cskilltwo == "images/buttons/on/fireattackon.png") {
          cskilltwo = "images/buttons/off/fireattackoff.png";
        }
        if (cskillthree == "images/buttons/on/fireattackon.png") {
          cskillthree = "images/buttons/off/fireattackoff.png";
        }
        if (cskillfour == "images/buttons/on/fireattackon.png") {
          cskillfour = "images/buttons/off/fireattackoff.png";
        }
        sinir = 1000;

        ijtop = (mainbodytop + charmaxwidth / 2) - ijwidth / 2;
        ijleft = (mainbodyleft + charmaxwidth / 2) - ijwidth / 2;
        ijanim = true;

        Timer(const Duration(seconds: 30), () {
          setState(() {
            ijanim = false;
            ijtop = -500;
            sinir = minsinir;
          });
        });
      });
    }
  }

  void expbuttonfunc() {
    if (isgamestarted && canexp) {
      setState(() {
        FlameAudio.play("mage.wav");

        canexp = false;
        if (cskillone == "images/buttons/on/expon.png") {
          cskillone = "images/buttons/off/expoff.png";
        }
        if (cskilltwo == "images/buttons/on/expon.png") {
          cskilltwo = "images/buttons/off/expoff.png";
        }
        if (cskillthree == "images/buttons/on/expon.png") {
          cskillthree = "images/buttons/off/expoff.png";
        }
        if (cskillfour == "images/buttons/on/expon.png") {
          cskillfour = "images/buttons/off/expoff.png";
        }
        candamage = false;

        imtop = (mainbodytop + charmaxwidth / 2) - imwidth / 2;
        imleft = (mainbodyleft + charmaxwidth / 2) - imwidth / 2;
        imanim = true;

        Timer(const Duration(seconds: 5), () {
          setState(() {
            imanim = false;
            imtop = -500;

            candamage = true;
          });
        });
      });
    }
  }

  void wallbreakbuttonfunc() {
    if (isgamestarted && canwallbreak) {
      setState(() {
        FlameAudio.play("mage.wav");
        btbool = true;

        canwallbreak = false;
        if (cskillone == "images/buttons/on/wallbreakon.png") {
          cskillone = "images/buttons/off/wallbreakoff.png";
        }
        if (cskilltwo == "images/buttons/on/wallbreakon.png") {
          cskilltwo = "images/buttons/off/wallbreakoff.png";
        }
        if (cskillthree == "images/buttons/on/wallbreakon.png") {
          cskillthree = "images/buttons/off/wallbreakoff.png";
        }
        if (cskillfour == "images/buttons/on/wallbreakon.png") {
          cskillfour = "images/buttons/off/wallbreakoff.png";
        }

        if (leftbricktop > -(leftbrickheight)) {
          beotop = (leftbricktop + (leftbrickheight / 2)) - beoheight / 2;
          beoleft = (leftbrickleft + (leftbrickwidth / 2)) - beowidth / 2;
          beoanim = true;
          Timer(const Duration(seconds: 1), () {
            setState(() {
              btbool = false;
              beop = 0;
              beoanim = false;
            });
          });
        }

        if (rightbricktop > -(rightbrickheight)) {
          bettop = (rightbricktop + (rightbrickheight / 2)) - betheight / 2;
          betleft = (rightbrickleft + (rightbrickwidth / 2)) - betwidth / 2;
          betanim = true;
          Timer(const Duration(seconds: 1), () {
            setState(() {
              btop = 0;
              btbool = false;

              betanim = false;
            });
          });
        }
        if (leftbricktopsec > -(leftbrickheightsec)) {
          bethtop =
              (leftbricktopsec + (leftbrickheightsec / 2)) - bethheight / 2;
          bethleft =
              (leftbrickleftsec + (leftbrickwidthsec / 2)) - bethwidth / 2;
          bethanim = true;
          Timer(const Duration(seconds: 1), () {
            setState(() {
              bthop = 0;
              btbool = false;

              bethanim = false;
            });
          });
        }

        brickformations(Random().nextInt(3) + 1);
      });
    }
  }
}

class ShopbuttonWidget extends StatelessWidget {
  const ShopbuttonWidget(
      {Key? key,
      required this.width,
      required this.c,
      required this.text,
      required this.func,
      required this.textcolor,
      required this.color})
      : super(key: key);

  final double width;
  final double c;
  final Color color;
  final String text;
  final Function func;
  final Color textcolor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        func();
      },
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      child: Container(
        decoration: BoxDecoration(
          color: color,
        ),
        height: width / 4,
        width: width / 3,
        child: Center(
          child:
              Text(text, style: TextStyle(fontSize: c / 2, color: textcolor)),
        ),
      ),
    );
  }
}

class ShopConWidget extends StatelessWidget {
  const ShopConWidget({
    Key? key,
    required this.width,
    required this.imageone,
    required this.diamond,
    required this.coin,
    required this.b,
    required this.fc,
    required this.fe,
  }) : super(key: key);

  final Function fc;
  final Function fe;

  final int diamond;
  final int coin;
  final double width;
  final String imageone;
  final bool b;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Container(
            width: width * 4 / 10,
            height: ((width * 9 / 10)),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 8.0,
                )
              ],
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: (width * 4 / 10),
                    height: (width * 4 / 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          child: Image.asset(
                            imageone,
                            width: (width * 4 / 10) * 8 / 10,
                            height: (width * 4 / 10) * 8 / 10,
                          ),
                        ),
                      ],
                    )),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    if (b == false) {
                      FlameAudio.play("unlock.wav");
                      fc();
                    }
                  },
                  child: SizedBox(
                    width: (width * 4 / 10),
                    height: (width * 5 / 10 * 2 / 10) + (width * 4 / 10) / 10,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: ((width * 5 / 10 * 2 / 10) +
                                  (width * 4 / 10) / 10) /
                              10,
                          child: Container(
                            height: ((width * 5 / 10 * 2 / 10) +
                                    (width * 4 / 10) / 10) *
                                8 /
                                10,
                            width: (width * 4 / 10),
                            color: const Color(0xff49003f),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          height: ((width * 5 / 10 * 2 / 10) +
                              (width * 4 / 10) / 10),
                          child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color(0xFF000000).withAlpha(60),
                                    blurRadius: 6.0,
                                    spreadRadius: charmaxwidth / 8,
                                    offset: const Offset(
                                      0.0,
                                      3.0,
                                    ),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                  "./images/effects/money/coin.png")),
                        ),
                        Positioned(
                          left: ((width * 5 / 10 * 2 / 10) +
                              (width * 4 / 10) * 2 / 10),
                          child: Center(
                            child: Text(
                              coin.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ((width * 4 / 10 * 2 / 10) +
                                      (width * 2 / 10) / 100)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  onPressed: () {
                    if (b == false) {
                      FlameAudio.play("unlock.wav");
                      fe();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: (width * 6 / 10) / 10),
                    width: (width * 4 / 10),
                    height: (width * 5 / 10 * 2 / 10) + (width * 4 / 10) / 10,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: ((width * 5 / 10 * 2 / 10) +
                                  (width * 4 / 10) / 10) /
                              10,
                          child: Container(
                            height: ((width * 5 / 10 * 2 / 10) +
                                    (width * 4 / 10) / 10) *
                                8 /
                                10,
                            width: (width * 4 / 10),
                            color: const Color(0xff49003f),
                          ),
                        ),
                        Positioned(
                          left: ((width * 5 / 10 * 2 / 10) +
                                  (width * 4 / 10) / 10) /
                              4,
                          height: ((width * 5 / 10 * 2 / 10) +
                              (width * 4 / 10) / 10),
                          child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color(0xFF000000).withAlpha(60),
                                    blurRadius: 6.0,
                                    spreadRadius: charmaxwidth / 25,
                                    offset: const Offset(
                                      0.0,
                                      3.0,
                                    ),
                                  ),
                                ],
                              ),
                              child: Image.asset(
                                  "./images/effects/money/emerald.png")),
                        ),
                        Positioned(
                          left: ((width * 5 / 10 * 2 / 10) +
                              (width * 4 / 10) * 2 / 10),
                          child: Center(
                            child: Text(
                              diamond.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ((width * 5 / 10 * 2 / 10) +
                                      (width * 4 / 10) / 100)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            child: Opacity(
                opacity: b ? 0.5 : 0,
                child: Container(
                  width: b ? width * 4 / 10 : 0,
                  height: ((width * 9 / 10)),
                  color: Colors.black,
                ))),
        Positioned(
            child: Icon(
          CupertinoIcons.lock,
          shadows: const [
            Shadow(
              blurRadius: 10.0, // shadow blur
              color: Colors.black, // shadow color
              offset: Offset(2.0, 2.0), // how much shadow will be shown
            )
          ],
          size: b ? width * 3 / 10 : 0,
          color: Colors.white,
        )),
      ],
    );
  }
}

class ShopRowWidget extends StatelessWidget {
  const ShopRowWidget({
    Key? key,
    required this.width,
    required this.imageone,
    required this.imagetwo,
    required this.diamondone,
    required this.coinone,
    required this.diamondtwo,
    required this.cointwo,
    required this.boolone,
    required this.booltwo,
    required this.funconee,
    required this.functwoe,
    required this.funconec,
    required this.functwoc,
  }) : super(key: key);

  final double width;
  final String imageone;
  final String imagetwo;

  final Function funconee;
  final Function functwoe;

  final Function funconec;
  final Function functwoc;

  final bool boolone;
  final bool booltwo;

  final int diamondone;
  final int diamondtwo;
  final int coinone;
  final int cointwo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ShopConWidget(
          fc: funconec,
          fe: funconee,
          b: boolone,
          width: width,
          imageone: imageone,
          diamond: diamondone,
          coin: coinone,
        ),
        ShopConWidget(
          fc: functwoc,
          fe: functwoe,
          b: booltwo,
          width: width,
          imageone: imagetwo,
          diamond: diamondtwo,
          coin: cointwo,
        ),
      ],
    );
  }
}

class CWidget extends StatelessWidget {
  const CWidget({
    Key? key,
    required this.congm,
    required this.confetitop,
    required this.cong,
    required this.isgamestartedreally,
  }) : super(key: key);

  final bool isgamestartedreally;
  final double congm;
  final double confetitop;
  final bool cong;

  @override
  Widget build(BuildContext context) {
    if (isgamestartedreally == false) {
      return Positioned(
          width: congm,
          top: confetitop,
          child: Lottie.asset("images/effects/shines/confeti.json.json",
              animate: cong));
    } else {
      return Positioned(child: Container());
    }
  }
}

class FLWidget extends StatelessWidget {
  const FLWidget({
    Key? key,
    required this.h,
    required this.w,
    required this.t,
    required this.l,
    required this.s,
    required this.b,
    required this.shieldanim,
    required this.ijanim,
    required this.imanim,
    required this.ceanim,
    required this.expboolone,
    required this.expbooltwo,
    required this.expboolthree,
  }) : super(key: key);

  final double w;
  final double h;
  final double t;
  final double l;
  final String s;

  final bool shieldanim;
  final bool ijanim;
  final bool imanim;
  final bool ceanim;
  final bool expboolone;
  final bool expbooltwo;
  final bool expboolthree;

  final bool b;

  @override
  Widget build(BuildContext context) {
    if (shieldanim ||
        ijanim ||
        imanim ||
        ceanim ||
        expboolone ||
        expbooltwo ||
        expboolthree) {
      return Positioned(
          left: l,
          top: t,
          child: SizedBox(
              width: w, height: h, child: Lottie.asset(s, animate: b)));
    } else {
      return Positioned(child: Container());
    }
  }
}

class FLAWidget extends StatelessWidget {
  const FLAWidget({
    Key? key,
    required this.aimbool,
    required this.h,
    required this.w,
    required this.t,
    required this.l,
    required this.m,
    required this.s,
    required this.b,
  }) : super(key: key);

  final bool aimbool;
  final int m;
  final double w;
  final double h;
  final double t;
  final double l;
  final String s;

  final bool b;

  @override
  Widget build(BuildContext context) {
    if (aimbool == true) {
      return AnimatedPositioned(
          duration: Duration(milliseconds: m),
          left: l,
          top: t,
          child: Lottie.asset(s, animate: b, width: w, height: h));
    } else {
      return Positioned(child: Container());
    }
  }
}

class CEWidget extends StatelessWidget {
  const CEWidget({
    Key? key,
    required this.isgamereallystarted,
    required this.coinexpwidth,
    required this.coinexplode,
  }) : super(key: key);

  final bool isgamereallystarted;
  final double coinexpwidth;
  final bool coinexplode;

  @override
  Widget build(BuildContext context) {
    if (isgamereallystarted == false) {
      return Positioned(
          top: 0,
          child: (Lottie.asset(
            "images/effects/money/moneyupdate.json",
            width: coinexpwidth,
            animate: coinexplode,
          )));
    } else {
      return Positioned(child: Container());
    }
  }
}

class EnvConWidget extends StatelessWidget {
  const EnvConWidget({
    Key? key,
    required this.shopwidth,
    required this.b,
    required this.btwo,
    required this.f,
    required this.img,
  }) : super(key: key);

  final Function f;
  final bool btwo;
  final String img;
  final double shopwidth;
  final bool b;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: () {
        if (b) {
          FlameAudio.play("use.wav");
          f();
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: (shopwidth / 3) * 2 / 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8.0,
                    )
                  ],
                  color: btwo ? Colors.green : Colors.white,
                ),
                width: (shopwidth / 3) * 8 / 10,
                height: (shopwidth / 3) * 8 / 10,
                child: Padding(
                  padding: EdgeInsets.all(shopwidth / 3 / 10),
                  child: Image.asset(img),
                ),
              ),
            ),
            Positioned(
                child: Opacity(
              opacity: b ? 0 : 0.5,
              child: Container(
                width: (shopwidth / 3) * 8 / 10,
                height: (shopwidth / 3) * 8 / 10,
                color: Colors.black,
              ),
            )),
            Positioned(
                child: Icon(
              CupertinoIcons.lock,
              shadows: const [
                Shadow(
                  blurRadius: 10.0, // shadow blur
                  color: Colors.black, // shadow color
                  offset: Offset(2.0, 2.0), // how much shadow will be shown
                )
              ],
              size: b ? 0 : (shopwidth / 3) * 6 / 10,
              color: Colors.white,
            )),
            Positioned(
                child: Icon(
              CupertinoIcons.checkmark_alt_circle_fill,
              shadows: const [
                Shadow(
                  blurRadius: 25.0, // shadow blur
                  color: Colors.black, // shadow color
                  offset: Offset(0, 0), // how much shadow will be shown
                )
              ],
              size: (b && btwo) ? (shopwidth / 3) * 6 / 10 : 0,
              color: Colors.white,
            )),
          ],
        ),
      ),
    );
  }
}

class SkillConWidget extends StatelessWidget {
  const SkillConWidget({
    Key? key,
    required this.shopwidth,
    required this.b,
    required this.f,
    required this.img,
  }) : super(key: key);

  final String img;
  final double shopwidth;
  final bool b;
  final Function f;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      maxSimultaneousDrags: b ? 2 : 0,
      childWhenDragging: Container(
        margin: EdgeInsets.only(bottom: (shopwidth / 3) * 2 / 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8.0,
                    )
                  ],
                  color: Colors.white,
                ),
                width: (shopwidth / 3) * 8 / 10,
                height: (shopwidth / 3) * 8 / 10,
                child: Padding(
                  padding: EdgeInsets.all(shopwidth / 3 / 20),
                  child: Image.asset("images/buttons/holder.png"),
                ),
              ),
            ),
          ],
        ),
      ),
      feedback: Container(
        margin: EdgeInsets.only(bottom: (shopwidth / 3) * 2 / 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8.0,
                    )
                  ],
                  color: Colors.white,
                ),
                width: (shopwidth / 3) * 8 / 10,
                height: (shopwidth / 3) * 8 / 10,
                child: Padding(
                  padding: EdgeInsets.all(shopwidth / 3 / 20),
                  child: Image.asset(img),
                ),
              ),
            ),
          ],
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: (shopwidth / 3) * 2 / 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8.0,
                    )
                  ],
                  color: Colors.white,
                ),
                width: (shopwidth / 3) * 8 / 10,
                height: (shopwidth / 3) * 8 / 10,
                child: Padding(
                  padding: EdgeInsets.all(shopwidth / 3 / 20),
                  child: Image.asset(img),
                ),
              ),
            ),
            Positioned(
                child: Opacity(
              opacity: b ? 0 : 0.5,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                width: (shopwidth / 3) * 8 / 10,
                height: (shopwidth / 3) * 8 / 10,
              ),
            )),
            Positioned(
                child: Icon(
              CupertinoIcons.lock,
              shadows: const [
                Shadow(
                  blurRadius: 10.0, // shadow blur
                  color: Colors.black, // shadow color
                  offset: Offset(2.0, 2.0), // how much shadow will be shown
                )
              ],
              size: b ? 0 : (shopwidth / 3) * 6 / 10,
              color: Colors.white,
            )),
          ],
        ),
      ),
      onDragEnd: (details) => f(details),
    );
  }
}

class SkillPWidget extends StatelessWidget {
  const SkillPWidget({
    Key? key,
    required this.shopwidth,
    required this.b,
    required this.money,
    required this.f,
    required this.img,
  }) : super(key: key);

  final double shopwidth;
  final String money;
  final bool b;
  final String img;
  final Function f;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            width: (shopwidth * 4 / 12),
            height: (shopwidth * 4 / 12),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(img),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                    child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    width: b ? 0 : (shopwidth * 4 / 12),
                    height: (shopwidth * 4 / 12),
                  ),
                )),
                Positioned(
                  child: TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () {
                      f();
                    },
                    child: Center(
                      child: Container(
                        width: b ? 0 : (shopwidth * 4 / 12),
                        height: (shopwidth * 4 / 12) / 4,
                        color: const Color(0xff90007d),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                                left: (shopwidth * 4 / 12) / 2,
                                child: Text(money,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: shopwidth / 15,
                                    )))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: (shopwidth * 4 / 12) / 2 - (shopwidth / 14),
          child: Image.asset("images/effects/money/coin.png",
              height: b ? 0 : shopwidth / 7, width: shopwidth / 7),
        ),
      ],
    );
  }
}

class FrameWidget extends StatelessWidget {
  const FrameWidget({
    Key? key,
    required this.top,
    required this.left,
    required this.height,
    required this.img,
  }) : super(key: key);

  final String img;
  final double height;
  final double left;
  final double top;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      top: top,
      left: left,
      child: SizedBox(
        height: height,
        child: Image.asset(img),
      ),
    );
  }
}

class ArrowClassFileWidget extends StatelessWidget {
  const ArrowClassFileWidget(
      {Key? key,
      required this.top,
      required this.left,
      required this.offset,
      required this.rot,
      required this.op,
      required this.height,
      required this.size})
      : super(key: key);

  final double top;
  final double left;
  final Offset offset;
  final double rot;
  final double op;
  final double height;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Transform(
          origin: offset,
          transform: Matrix4.rotationZ(
            rot,
          ),
          child: Opacity(
            opacity: op,
            child: Container(
              height: height,
              width: size,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                  image: AssetImage("images/arrow.png"),
                ),
              ),
            ),
          )),
    );
  }
}

class BackWallWidget extends StatelessWidget {
  const BackWallWidget({
    Key? key,
    required this.width,
    required this.top,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      height: height,
      left: 0,
      width: width,
      child: Image.asset(
        "images/walls/bacwallcn.png",
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

class HBackWidget extends StatelessWidget {
  const HBackWidget({
    Key? key,
    required this.left,
    required this.width,
    required this.top,
    required this.height,
  }) : super(key: key);

  final double left;
  final double width;
  final double height;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: left,
        top: top,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
                width: 2,
                color: const Color(0xffDCD6F7),
                style: BorderStyle.solid),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withAlpha(60),
                blurRadius: 6.0,
                spreadRadius: charmaxwidth / 8,
                offset: const Offset(
                  0.0,
                  3.0,
                ),
              ),
            ],
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xffDCD6F7),
                  Color(0xffA6B1E1),
                ]),
          ),
          height: height,
          width: width,
        ));
  }
}

class BarWidget extends StatelessWidget {
  const BarWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.b,
  }) : super(key: key);

  final double height;
  final bool b;
  final double width;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: height / 30, color: const Color(0xff4A55A2)),
              bottom: BorderSide(
                  width: height / 30, color: const Color(0xff4A55A2))),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xff9AC5F4),
                Color(0xff75C2F6),
                Color(0xff5A96E3),
                Color(0xff7895CB),
              ])),
      curve: Curves.fastOutSlowIn,
      width: b ? ((width / 4) * 9 / 10) : 0,
      height: height * 8 / 10,
    );
  }
}

class HBWidget extends StatelessWidget {
  const HBWidget({
    Key? key,
    required this.width,
    required this.top,
    required this.m,
    required this.height,
    required this.firstbar,
    required this.secondbar,
    required this.thirdbar,
    required this.fourthbar,
  }) : super(key: key);

  final bool firstbar;
  final bool secondbar;
  final bool thirdbar;
  final bool fourthbar;

  final double m;
  final double width;
  final double height;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: (m / 2) - (((height * 9 / 10) * 4) / 2),
        top: top + (height / 10),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withAlpha(60),
                blurRadius: 6.0,
                spreadRadius: charmaxwidth / 8,
                offset: const Offset(
                  0.0,
                  3.0,
                ),
              ),
            ],
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xffDCD6F7),
                  Color(0xffA6B1E1),
                ]),
          ),
          child: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BarWidget(height: height, width: width, b: firstbar),
                  BarWidget(height: height, width: width, b: secondbar),
                  BarWidget(height: height, width: width, b: thirdbar),
                  BarWidget(height: height, width: width, b: fourthbar),
                ]),
          ),
        ));
  }
}

class HSWidget extends StatelessWidget {
  const HSWidget({
    Key? key,
    required this.isgamestartedreally,
    required this.snhleft,
    required this.snhwidth,
    required this.snhtop,
    required this.snhheight,
    required this.highscoreann,
    required this.snhsize,
    required this.snhop,
    required this.highscorefunc,
    required this.highscoreendfunc,
  }) : super(key: key);

  final Function highscorefunc;
  final bool isgamestartedreally;
  final Function highscoreendfunc;

  final String highscoreann;
  final double snhleft;
  final double snhwidth;
  final double snhheight;
  final double snhtop;
  final double snhsize;
  final double snhop;

  @override
  Widget build(BuildContext context) {
    if (isgamestartedreally == false) {
      return AnimatedPositioned(
          duration: const Duration(milliseconds: 400),
          top: snhtop,
          left: snhleft,
          height: snhheight,
          width: snhwidth,
          onEnd: () {
            highscoreendfunc();
          },
          child: Opacity(
            opacity: snhop,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 25.0,
                    )
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                  border: Border.all(
                      width: 2,
                      color: const Color(0xffDC23D4),
                      style: BorderStyle.solid)),
              child: TextButton(
                onPressed: () {
                  highscorefunc();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GradientText(
                      "NEW RECORD:  ",
                      colors: const [Colors.purpleAccent, Colors.deepPurple],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: (charmaxwidth * 3 / 10),
                      ),
                    ),
                    GradientText(
                      highscoreann,
                      colors: const [Colors.purpleAccent, Colors.deepPurple],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: (snhsize),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
    } else {
      return Positioned(child: Container());
    }
  }
}

class SplashListWidget extends StatelessWidget {
  const SplashListWidget({
    Key? key,
    required this.screenheight,
    required this.mainareawidth,
  }) : super(key: key);

  final double mainareawidth;
  final double screenheight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      width: mainareawidth,
      height: screenheight,
      child: Stack(children: splashlist),
    );
  }
}

class SideWidget extends StatelessWidget {
  const SideWidget({
    Key? key,
    required this.wallwidth,
    required this.i,
    required this.l,
    required this.fone,
    required this.s,
    required this.ftwo,
  }) : super(key: key);

  final double l;
  final String s;
  final double wallwidth;
  final Function fone;
  final IconData i;
  final Function ftwo;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: charmaxwidth,
        left: l,
        child: SizedBox(
            width: wallwidth,
            height: wallwidth * 2,
            child: Column(children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                ),
                onPressed: () {
                  fone();
                },
                child: Icon(
                  color: Colors.white,
                  i,
                  shadows: const [
                    Shadow(
                      blurRadius: 10.0, // shadow blur
                      color: Colors.black, // shadow color
                      offset: Offset(2.0, 2.0), // how much shadow will be shown
                    )
                  ],
                  size: charmaxwidth / 2,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                ),
                onPressed: () {
                  ftwo();
                },
                child: Text(
                  s,
                  style: TextStyle(
                    color: Colors.white,
                    shadows: const [
                      Shadow(
                        blurRadius: 10.0, // shadow blur
                        color: Colors.black, // shadow color
                        offset:
                            Offset(2.0, 2.0), // how much shadow will be shown
                      )
                    ],
                    fontSize: charmaxwidth / 2,
                  ),
                ),
              )
            ])));
  }
}

class SIWidget extends StatelessWidget {
  const SIWidget(
      {Key? key,
      required this.f,
      required this.emerald,
      required this.money,
      required this.mainareawidth,
      required this.wallwidth,
      required this.moneytop,
      required this.enven,
      required this.shop,
      required this.r,
      required this.isgamestartedreally})
      : super(key: key);

  final Function f;

  final RewardedAd? r;

  final int emerald;
  final int money;

  final bool isgamestartedreally;
  final double mainareawidth;
  final double wallwidth;
  final double moneytop;

  final Function enven;
  final Function shop;

  @override
  Widget build(BuildContext context) {
    if (isgamestartedreally == false) {
      return Positioned(
          top: moneytop,
          child: SizedBox(
            height: wallwidth,
            width: mainareawidth,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: Icon(
                    CupertinoIcons.cart,
                    shadows: const [
                      Shadow(
                        blurRadius: 10.0, // shadow blur
                        color: Colors.black, // shadow color
                        offset:
                            Offset(2.0, 2.0), // how much shadow will be shown
                      )
                    ],
                    size: charmaxwidth * 8 / 10,
                    color: const Color(0xffE0AA3E),
                  ),
                  onPressed: () {
                    shop();
                  },
                ),
                Row(children: [
                  Image.asset("images/effects/money/coin.png",
                      height: charmaxwidth * 3 / 5),
                  Text(
                    money.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xffE0AA3E),
                        fontSize: charmaxwidth / 3,
                        shadows: const [
                          Shadow(
                            blurRadius: 10.0, // shadow blur
                            color: Colors.black, // shadow color
                            offset: Offset(
                                2.0, 2.0), // how much shadow will be shown
                          )
                        ]),
                  )
                ]),
                //here
                TextButton(
                  onPressed: () {
                    r?.show(onUserEarnedReward: (_, rew) {
                      f();
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  child: Row(
                    children: [
                      Image.asset("images/effects/money/emerald.png",
                          height: charmaxwidth * 6 / 10),
                      Text(
                        emerald.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: const Color(0xff00FF88),
                            fontSize: charmaxwidth / 3,
                            shadows: const [
                              Shadow(
                                blurRadius: 10.0, // shadow blur
                                color: Colors.black, // shadow color
                                offset: Offset(
                                    2.0, 2.0), // how much shadow will be shown
                              )
                            ]),
                      )
                    ],
                  ),
                ),
                TextButton(
                  child: Icon(
                    CupertinoIcons.bag_fill,
                    shadows: const [
                      Shadow(
                        blurRadius: 10.0, // shadow blur
                        color: Colors.black, // shadow color
                        offset:
                            Offset(2.0, 2.0), // how much shadow will be shown
                      )
                    ],
                    size: charmaxwidth * 8 / 10,
                    color: const Color(0xffaa6955),
                  ),
                  onPressed: () {
                    enven();
                  },
                ),
              ],
            ),
          ));
    } else {
      return Positioned(
        child: Container(),
      );
    }
  }
}

class IWidget extends StatelessWidget {
  const IWidget({
    Key? key,
    required this.w,
    required this.h,
    required this.t,
    required this.l,
  }) : super(key: key);

  final double w;
  final double h;
  final double t;
  final double l;

  @override
  Widget build(BuildContext context) {
    if (infoon == true) {
      return Positioned(
        top: t,
        left: l,
        child: Container(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  blurRadius: 25.0,
                )
              ],
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
              border: Border.all(
                  width: 2,
                  color: const Color(0xffDC23D4),
                  style: BorderStyle.solid)),
          height: h,
          width: w,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: charmaxwidth),
                  child: Image.asset("images/xd.png"),
                ),
                const Text("Sport Racing Car"),
                const Text("DRIVE by Alex-Productions"),
                const Text("https://onsound.eu/"),
                const Text("Music promoted by:"),
                const Text("https://www.chosic.com/free-music/all/"),
                const Text("Creative Commons CC BY 3.0"),
                const Text("https://creativecommons.org/licenses/by/3.0/"),
              ]),
        ),
      );
    } else {
      return Positioned(child: Container());
    }
  }
}

class RWidget extends StatelessWidget {
  const RWidget({
    Key? key,
    required this.f,
    required this.m,
    required this.b,
    required this.w,
    required this.h,
    required this.t,
    required this.l,
  }) : super(key: key);

  final bool b;
  final Function f;
  final double m;
  final double w;
  final double h;
  final double t;
  final double l;

  @override
  Widget build(BuildContext context) {
    if (b == true) {
      return Positioned(
        top: t,
        left: l,
        child: SizedBox(
            height: m * 3 / 10,
            width: m * 8 / 10,
            child: TextButton(
              style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
              onPressed: () {
                f();
              },
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Positioned(
                    left: (m * 4 / 10) - (m * 3 / 10),
                    height: m * 2 / 10,
                    width: m * 6 / 10,
                    child: Container(
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 25.0,
                            )
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                          border: Border.all(
                              width: 2,
                              color: const Color(0xffDC23D4),
                              style: BorderStyle.solid)),
                      child: Center(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("2x",
                                  style: TextStyle(
                                    shadows: const [
                                      Shadow(
                                          // bottomLeft
                                          offset: Offset(-1.5, -1.5),
                                          color: Colors.white),
                                      Shadow(
                                          // bottomRight
                                          offset: Offset(1.5, -1.5),
                                          color: Colors.white),
                                      Shadow(
                                          // topRight
                                          offset: Offset(1.5, 1.5),
                                          color: Colors.white),
                                      Shadow(
                                          // topLeft
                                          offset: Offset(-1.5, 1.5),
                                          color: Colors.white),
                                    ],
                                    fontSize: m * 1 / 10,
                                  )),
                              Image.asset("images/effects/money/coin.png",
                                  height: m * 2 / 15)
                            ]),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 0,
                      height: m * 2 / 10,
                      width: m * 2 / 10,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 25.0,
                              )
                            ],
                            color: Colors.white,
                            border: Border.all(
                                width: 2,
                                color: const Color(0xffDC23D4),
                                style: BorderStyle.solid)),
                        child: const Icon(
                          CupertinoIcons.film,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0, // shadow blur
                              color: Colors.black, // shadow color
                              offset: Offset(
                                  2.0, 2.0), // how much shadow will be shown
                            )
                          ],
                        ),
                      )),
                  Positioned(
                      height: m * 2 / 10,
                      width: m * 2 / 10,
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 25.0,
                                )
                              ],
                              color: Colors.white,
                              border: Border.all(
                                  width: 2,
                                  color: const Color(0xffDC23D4),
                                  style: BorderStyle.solid)),
                          child: Center(
                              child: Text(rcount.toString(),
                                  style: TextStyle(fontSize: m * 2 / 15))))),
                ],
              ),
            )),
      );
    } else {
      return Positioned(child: Container());
    }
  }
}

class MEWidget extends StatelessWidget {
  const MEWidget({
    Key? key,
    required this.b,
    required this.isgamestartedreally,
    required this.snend,
    required this.score,
    required this.sntop,
    required this.snleft,
    required this.snheight,
    required this.snwidth,
    required this.moneyfunc,
  }) : super(key: key);

  final bool b;
  final bool isgamestartedreally;
  final int snend;
  final int score;

  final double sntop;
  final double snleft;
  final double snheight;
  final double snwidth;

  final Function moneyfunc;

  @override
  Widget build(BuildContext context) {
    if (isgamestartedreally == false) {
      return Positioned(
          top: sntop,
          left: snleft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 25.0,
                  )
                ],
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
                border: Border.all(
                    width: 2,
                    color: const Color(0xffDC23D4),
                    style: BorderStyle.solid)),
            height: snheight,
            width: snwidth,
            child: TextButton(
              onPressed: () {
                if (b == false) {
                  moneyfunc();
                }
              },
              child: SizedBox(
                height: snheight,
                width: snwidth,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: Countup(
                        begin: 0,
                        end: snend.toDouble(),
                        duration: const Duration(seconds: 1),
                        style: TextStyle(
                            color: const Color(0xffE0AA3E),
                            fontSize: (score > 999)
                                ? (charmaxwidth)
                                : (charmaxwidth * 2),
                            shadows: const [
                              Shadow(
                                blurRadius: 10.0, // shadow blur
                                color: Colors.black, // shadow color
                                offset: Offset(
                                    2.0, 2.0), // how much shadow will be shown
                              )
                            ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    } else {
      return Positioned(child: Container());
    }
  }
}

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({
    Key? key,
    required this.top,
    required this.left,
    required this.canshake,
    required this.score,
  }) : super(key: key);

  final double top;
  final double left;
  final bool canshake;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        left: left - (charmaxwidth * 2),
        child: SizedBox(
          width: charmaxwidth * 4,
          height: charmaxwidth * 4,
          child: ShakeWidget(
            autoPlay: canshake,
            duration: const Duration(milliseconds: 500),
            shakeConstant: ShakeCrazyConstant2(),
            child: GradientText(
              score.toString(),
              colors: const [
                Color(0xff9AC5F4),
                Color(0xff75C2F6),
                Color(0xff5A96E3),
                Color(0xff7895CB),
              ],
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: (score > 999) ? (charmaxwidth) : (charmaxwidth * 2),
                  shadows: const [
                    Shadow(
                      blurRadius: 20.0, // shadow blur
                      color: Colors.black, // shadow color
                      offset: Offset(0, 0), // how much shadow will be shown
                    )
                  ]),
            ),
          ),
        ));
  }
}

class SideWallWidget extends StatelessWidget {
  const SideWallWidget({
    Key? key,
    required this.wallwidth,
    required this.screenheight,
    required this.left,
    required this.wb,
    required this.canshake,
    required this.buttonwidth,
    required this.buttononeimage,
    required this.buttontwoimage,
    required this.buttononefunc,
    required this.buttontwofunc,
    required this.wallimage,
    required this.sidewallbackuptwotop,
    required this.sidewallbackuptop,
    required this.sidewallonetop,
    required this.sidewalltwotop,
    required this.sidewallthreetop,
    required this.l,
  }) : super(key: key);

  final String wallimage;

  final double l;
  final double sidewallbackuptwotop;
  final double sidewallbackuptop;
  final double sidewallonetop;
  final double sidewalltwotop;
  final double sidewallthreetop;

  final String buttononeimage;
  final String buttontwoimage;

  final Function buttononefunc;
  final Function buttontwofunc;

  final double buttonwidth;
  final bool canshake;
  final String wb;
  final double wallwidth;
  final double left;
  final double screenheight;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: l,
      child: SizedBox(
        width: wallwidth,
        height: screenheight,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              top: 0,
              left: left,
              child: Container(
                  width: wallwidth,
                  height: screenheight,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(wb),
                          fit: BoxFit.fitWidth,
                          repeat: ImageRepeat.repeat)),
                  child: Stack(
                    children: [
                      SideWallWidgetAni(
                          image: wallimage,
                          top: sidewallbackuptwotop,
                          wallwidth: wallwidth),
                      SideWallWidgetAni(
                          image: wallimage,
                          top: sidewallbackuptop,
                          wallwidth: wallwidth),
                      SideWallWidgetAni(
                          image: wallimage,
                          top: sidewallonetop,
                          wallwidth: wallwidth),
                      SideWallWidgetAni(
                          image: wallimage,
                          top: sidewalltwotop,
                          wallwidth: wallwidth),
                      SideWallWidgetAni(
                          image: wallimage,
                          top: sidewallthreetop,
                          wallwidth: wallwidth),
                      Positioned(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SSbuttonWidget(
                                canshake: canshake,
                                buttonwidth: buttonwidth,
                                wallwidth: wallwidth,
                                image: buttononeimage,
                                func: buttononefunc),
                            SSbuttonWidget(
                                canshake: canshake,
                                buttonwidth: buttonwidth,
                                wallwidth: wallwidth,
                                image: buttontwoimage,
                                func: buttontwofunc),
                            //buttonWidget(buttonimageone, buttonfuncone),
                            //buttonWidget(buttonimagetwo, buttonfunctwo),
                            //buttonWidget(buttonimagethree, buttonfuncthree),
                          ],
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class SideWallWidgetAni extends StatelessWidget {
  const SideWallWidgetAni({
    Key? key,
    required this.image,
    required this.top,
    required this.wallwidth,
  }) : super(key: key);

  final double wallwidth;
  final String image;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      child: Image.asset(
        image,
        fit: BoxFit.fitWidth,
        height: wallwidth * 2000 / 479,
      ),
    );
  }
}

class SSbuttonWidget extends StatelessWidget {
  const SSbuttonWidget({
    Key? key,
    required this.canshake,
    required this.buttonwidth,
    required this.wallwidth,
    required this.image,
    required this.func,
  }) : super(key: key);

  final bool canshake;
  final double buttonwidth;
  final double wallwidth;
  final String image;
  final Function func;

  @override
  Widget build(BuildContext context) {
    return ShakeWidget(
      autoPlay: canshake,
      shakeConstant: ShakeHardConstant1(),
      duration: const Duration(seconds: 2),
      child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 50.0,
              )
            ],
          ),
          height: buttonwidth * 2,
          width: (image == "images/buttons/holder.png") ? 0 : wallwidth,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            child: Container(child: Image.asset(image)),
            onPressed: () {
              func();
            },
          )),
    );
  }
}

class SBWidget extends StatelessWidget {
  const SBWidget({
    Key? key,
    required this.startbuttonfunc,
    required this.startbuttontext,
    required this.wallwidth,
    required this.startbuttontop,
    required this.startbuttonleft,
    required this.isgamereallystarted,
    required this.startbuttonwidth,
    required this.startbuttonheight,
    required this.scorewidgetlist,
    required this.playerscorewidgetlist,
  }) : super(key: key);

  final bool isgamereallystarted;
  final Function startbuttonfunc;
  final String startbuttontext;
  final double wallwidth;
  final double startbuttontop;
  final double startbuttonleft;
  final double startbuttonwidth;
  final double startbuttonheight;
  final List<Widget> scorewidgetlist;
  final List<Widget> playerscorewidgetlist;

  @override
  Widget build(BuildContext context) {
    if (isgamereallystarted == false) {
      return Positioned(
        top: startbuttontop,
        left: startbuttonleft,
        child: SizedBox(
          width: startbuttonwidth,
          height: startbuttonheight,
          child: TextButton(
              onPressed: () {
                startbuttonfunc();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: wallwidth),
                    child: Column(
                      children: scorewidgetlist,
                    ),
                  ),
                  ShakeWidget(
                    duration: const Duration(seconds: 100),
                    shakeConstant: (ShakeSlowConstant1()),
                    autoPlay: true,
                    child: GradientText(
                      startbuttontext,
                      colors: const [Colors.blueAccent, Colors.deepPurple],
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: charmaxwidth * 3, shadows: const [
                        Shadow(
                          blurRadius: 10.0, // shadow blur
                          color: Colors.black, // shadow color
                          offset:
                              Offset(2.0, 2.0), // how much shadow will be shown
                        )
                      ]),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: wallwidth),
                    child: Column(
                      children: playerscorewidgetlist,
                    ),
                  )
                ],
              )),
        ),
      );
    } else {
      return Positioned(child: Container());
    }
  }
}

class MBWidget extends StatelessWidget {
  const MBWidget({
    Key? key,
    required this.mainbodyleft,
    required this.mainbodytop,
    required this.maxdrag,
    required this.dragablekey,
    required this.maincharrot,
    required this.choosenskin,
    required this.choosenskinbig,
    required this.ballcolor,
    required this.dragstartfunc,
    required this.mainthrowfunc,
  }) : super(key: key);

  final double mainbodyleft;
  final double mainbodytop;
  final int maxdrag;
  final GlobalKey dragablekey;

  final double maincharrot;

  final String choosenskin;
  final String choosenskinbig;

  final Color ballcolor;

  final Function dragstartfunc;
  final Function mainthrowfunc;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: mainbodyleft - maincharwithsize / 2,
      top: mainbodytop - maincharwithsize / 2,
      child: Container(
        height: maincharwithsize * 2,
        width: maincharwithsize * 2,
        alignment: Alignment.center,
        child: Draggable(
          maxSimultaneousDrags: maxdrag,
          hitTestBehavior: HitTestBehavior.translucent,
          //key: key,
          feedback: SizedBox(
            height: maincharwithsize * 2,
            width: maincharwithsize * 2,
            child: Stack(
              children: [
                Positioned(
                  left: maincharwithsize / 2,
                  top: maincharwithsize / 2,
                  child: Container(
                    key: dragablekey,
                    width: maincharwithsize,
                    height: maincharwithsize,
                    decoration: const BoxDecoration(
                      color: levelfour,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              ],
            ),
          ),
          childWhenDragging: Container(
            width: maincharwithsize,
            //key: startposkey,
            height: maincharwithsize,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(choosenskin),
              ),
              shape: BoxShape.circle,
            ),
          ),
          child: Transform(
            origin: Offset(maincharwithsize, maincharwithsize),
            transform: Matrix4.rotationZ(maincharrot),
            child: Container(
              width: maincharwithsize * 2,
              height: maincharwithsize * 2,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: ballcolor,
                    spreadRadius: -25.0,
                    blurRadius: charmaxwidth / 3,
                  )
                ],
                image: DecorationImage(
                  image: AssetImage(choosenskinbig),
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),

          onDragStarted: () => dragstartfunc(),
          onDragEnd: (details) => mainthrowfunc(details),
        ),
      ),
    );
  }
}

class BrickClassWidget extends StatelessWidget {
  const BrickClassWidget({
    Key? key,
    required this.top,
    required this.left,
    required this.height,
    required this.width,
    required this.image,
  }) : super(key: key);

  final double top;
  final double left;
  final double height;
  final double width;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        left: left,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withAlpha(60),
                blurRadius: 6.0,
                spreadRadius: 5.0,
                offset: const Offset(
                  0.0,
                  3.0,
                ),
              ),
            ],
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage(image),
            ),
          ),
          width: width,
          height: height,
        ));
  }
}

class EnemyWidget extends StatelessWidget {
  const EnemyWidget(
      {Key? key, required this.top, required this.left, required this.rot})
      : super(key: key);

  final double rot;
  final double left;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Transform(
        origin: Offset(enemyonewidth / 2, enemyoneheight / 2),
        transform: Matrix4.rotationZ(rot),
        child: Container(
            width: enemyonewidth,
            height: enemyoneheight,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.deepOrange,
                  spreadRadius: charmaxwidth / 3,
                  blurRadius: charmaxwidth,
                )
              ],
              image: const DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(basicenemyimage),
              ),
              shape: BoxShape.circle,
            )),
      ),
    );
  }
}

class PickupMonyWidget extends StatelessWidget {
  const PickupMonyWidget(
      {Key? key,
      required this.b,
      required this.t,
      required this.l,
      required this.h,
      required this.w})
      : super(key: key);

  final bool b;
  final double h;
  final double l;
  final double t;
  final double w;

  @override
  Widget build(BuildContext context) {
    if (b == true) {
      return Positioned(
          left: l,
          top: t,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.amber,
                spreadRadius: 4.0,
                blurRadius: charmaxwidth / 3,
              )
            ]),
            height: h,
            width: w,
            child: Image.asset("images/effects/money/coin.png"),
          ));
    } else {
      return Positioned(child: Container());
    }
  }
}

class PlantWidget extends StatelessWidget {
  const PlantWidget(
      {Key? key,
      required this.width,
      required this.top,
      required this.left,
      required this.height,
      required this.isgameshakeon,
      required this.c})
      : super(key: key);

  final bool isgameshakeon;
  final double width;
  final double height;
  final double c;
  final double left;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        left: left,
        child: ShakeWidget(
          duration: const Duration(seconds: 5),
          autoPlay: isgameshakeon,
          shakeConstant: ShakeLittleConstant2(),
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent,
                spreadRadius: c / 10,
                blurRadius: c,
              )
            ]),
            width: width,
            height: height,
            child: Image.asset("images/characters/alienplant.png"),
          ),
        ));
  }
}

class RocketWidget extends StatelessWidget {
  const RocketWidget({
    Key? key,
    required this.width,
    required this.top,
    required this.left,
  }) : super(key: key);

  final double width;
  final double left;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        left: left,
        child: Container(
          width: width,
          height: width * 2,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.deepOrange,
                  spreadRadius: charmaxwidth / 3,
                  blurRadius: charmaxwidth,
                )
              ],
              image: const DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage("images/characters/rocket.png"))),
        ));
  }
}

class ShooterClassWidget extends StatelessWidget {
  const ShooterClassWidget({
    Key? key,
    required this.top,
    required this.left,
    required this.origin,
    required this.rot,
    required this.height,
    required this.width,
    required this.image,
  }) : super(key: key);

  final double top;
  final double left;
  final Offset origin;
  final double rot;
  final double height;
  final double width;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Transform(
        origin: origin,
        transform: Matrix4.rotationZ(rot),
        child: SizedBox(
          width: width,
          height: height,
          child: image,
        ),
      ),
    );
  }
}

class JumpSplash extends StatefulWidget {
  JumpSplash({
    Key? key,
    required this.width,
    required this.height,
    required this.top,
    required this.left,
  }) : super(key: key);

  final double top;
  final double left;
  final double width;
  final double height;

  @override
  State<JumpSplash> createState() => _JumpSplashState();
}

class _JumpSplashState extends State<JumpSplash> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  bool kontrol = true;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: widget.top,
        left: widget.left,
        child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: Lottie.asset(
              "images/effects/movesplash.json",
              animate: kontrol,
              controller: _controller,
              onLoaded: (comp) {
                _controller.duration = comp.duration;
                _controller.forward();
              },
            )));
  }
}

class SidePlantWidget extends StatelessWidget {
  const SidePlantWidget({
    Key? key,
    required this.top,
    required this.left,
    required this.height,
    required this.width,
    required this.image,
    required this.isgameshakeon,
  }) : super(key: key);

  final double top;
  final double left;
  final double height;
  final double width;
  final String image;
  final bool isgameshakeon;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: ShakeWidget(
        shakeConstant: ShakeLittleConstant1(),
        duration: const Duration(seconds: 5),
        autoPlay: isgameshakeon,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xffda090b),
                spreadRadius: charmaxwidth / 10,
                blurRadius: charmaxwidth,
              )
            ],
            image: DecorationImage(
              image: AssetImage(image),
            ),
          ),
        ),
      ),
    );
  }
}

class AniWidget extends StatelessWidget {
  const AniWidget({
    Key? key,
    required this.jumpbool,
    required this.top,
    required this.left,
    required this.width,
    required this.anim,
    required this.rot,
    required this.route,
    required this.off,
  }) : super(key: key);

  final bool jumpbool;
  final double top;
  final Offset off;
  final double left;
  final double width;
  final bool anim;
  final double rot;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      width: width,
      child: Transform(
        origin: off,
        transform: Matrix4.rotationZ(rot),
        child: Lottie.asset(
          route,
          animate: anim,
        ),
      ),
    );
  }
}

class AnimLnWidget extends StatelessWidget {
  const AnimLnWidget({
    Key? key,
    required this.top,
    required this.left,
    required this.width,
    required this.anim,
  }) : super(key: key);

  final bool anim;
  final double width;
  final double left;
  final double top;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: telepsec ~/ 2),
      top: top,
      left: left,
      width: width,
      child: Center(
        child: Container(
          child: Lottie.asset(
            "images/effects/skills/teleport.json",
            animate: anim,
          ),
        ),
      ),
    );
  }
}

class BLWidget extends StatelessWidget {
  const BLWidget({
    Key? key,
    required this.isgamestartedreally,
    required this.top,
    required this.left,
    required this.width,
    required this.height,
    required this.boolx,
    required this.img,
  }) : super(key: key);

  final bool isgamestartedreally;
  final bool boolx;
  final double height;
  final String img;
  final double width;
  final double left;
  final double top;

  @override
  Widget build(BuildContext context) {
    if (isgamestartedreally == false) {
      return Positioned(
          top: top,
          left: left,
          child: Lottie.asset(img, width: width, animate: boolx));
    } else {
      return Positioned(child: Container());
    }
  }
}

class BTWidget extends StatelessWidget {
  const BTWidget({
    Key? key,
    required this.btbool,
    required this.h,
    required this.w,
    required this.t,
    required this.l,
    required this.o,
    required this.b,
  }) : super(key: key);

  final bool btbool;
  final double w;
  final double h;
  final double t;
  final double l;
  final double o;

  final bool b;

  @override
  Widget build(BuildContext context) {
    if (btbool == true) {
      return Positioned(
        left: l,
        top: t,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: o,
          child: SizedBox(
              width: w,
              height: h,
              child: Center(
                child: Lottie.asset("images/effects/skills/teleport.json",
                    animate: b),
              )),
        ),
      );
    } else {
      return Positioned(child: Container());
    }
  }
}

class DRWidget extends StatelessWidget {
  const DRWidget({
    Key? key,
    required this.h,
    required this.w,
    required this.o,
    required this.f,
  }) : super(key: key);

  final double w;
  final double h;
  final double o;
  final Function f;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: o,
        onEnd: () {
          f();
        },
        duration: const Duration(milliseconds: 400),
        child: Container(
          width: w,
          height: h,
          color: Colors.red,
        ));
  }
}

class NpcAniWidget extends StatelessWidget {
  const NpcAniWidget({
    Key? key,
    required this.firstcol,
    required this.st,
    required this.func,
    required this.top,
    required this.left,
    required this.w,
    required this.h,
  }) : super(key: key);

  final bool firstcol;
  final String st;
  final Function func;
  final double top;
  final double left;
  final double w;
  final double h;

  @override
  Widget build(BuildContext context) {
    if (firstcol == false) {
      return AnimatedPositioned(
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        top: top,
        left: left,
        onEnd: () {
          func();
        },
        child: Container(
          width: w,
          height: h,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.redAccent,
              spreadRadius: -5.0,
              blurRadius: charmaxwidth / 1.5,
            )
          ], image: DecorationImage(image: AssetImage(st))),
        ),
      );
    } else {
      return Positioned(child: Container());
    }
  }
}

double mcanitop = 0;

class McAniWidget extends StatelessWidget {
  const McAniWidget({
    Key? key,
    required this.st,
    required this.m,
    required this.s,
    required this.t,
    required this.op,
    required this.func,
    required this.b,
  }) : super(key: key);

  final String st;
  final double m;
  final Function func;
  final bool b;
  final double s;
  final double t;
  final double op;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
      width: charmaxwidth * 2,
      height: charmaxwidth * 2,
      top: t,
      left: (m / 2 - charmaxwidth / 2) - charmaxwidth / 2,
      onEnd: () {
        func();
      },
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(opacity: op, image: AssetImage(st))),
      ),
    );
  }
}

class SplashWidget extends StatelessWidget {
  const SplashWidget({
    Key? key,
    required this.top,
    required this.left,
    required this.width,
    required this.height,
    required this.splash,
    required this.finalwidth,
    required this.func,
  }) : super(key: key);

  final Function func;
  final double finalwidth;
  final bool splash;
  final double width;
  final double height;
  final double left;
  final double top;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: splash ? 1 : 0,
            child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 1000),
                width: splash ? 0 : finalwidth,
                height: splash ? 0 : finalwidth,
                onEnd: () {
                  func();
                },
                decoration: BoxDecoration(
                  border: Border.all(
                      color: splash
                          ? const Color(0xff962202)
                          : const Color(0xffffffff),
                      width: charmaxwidth / 6),
                  shape: BoxShape.circle,
                )),
          ),
        ),
      ),
    );
  }
}

class ShopMainWidget extends StatelessWidget {
  const ShopMainWidget({
    Key? key,
    required this.ftwo,
    required this.fone,
    required this.fthree,
    required this.shopwidth,
    required this.screenheight,
    required this.shopleft,
    required this.shopheight,
    required this.shopcolor,
    required this.buttontwotext,
    required this.buttontwo,
    required this.buttononetext,
    required this.buttonone,
    required this.buttonthreetext,
    required this.buttonthree,
    required this.containertwoheight,
    required this.containeroneheight,
    required this.onmarket,
    required this.onskills,
    required this.onitem,
    required this.skillone,
    required this.doyouhaveskillone,
    required this.skilltwo,
    required this.doyouhaveskilltwo,
    required this.skillthree,
    required this.doyouhaveskillthree,
    required this.skillfour,
    required this.doyouhaveskillfour,
    required this.sonefunc,
    required this.stwofunc,
    required this.sthreefunc,
    required this.sfourfunc,
    required this.onskins,
    required this.choosenskin,
    required this.flagcostume,
    required this.switchfunc,
    required this.usedflag,
    required this.ismcinuse,
    required this.ismedicinuse,
    required this.isenginuse,
    required this.isarmorinuse,
    required this.ismageinuse,
    required this.ispirateinuse,
    required this.isfinalinuse,
    required this.isofinuse,
    required this.isafrinuse,
    required this.isarbinuse,
    required this.isarginuse,
    required this.isausinuse,
    required this.isbaninuse,
    required this.isbreinuse,
    required this.iscaninuse,
    required this.ischninuse,
    required this.isegyinuse,
    required this.isendinuse,
    required this.isinginuse,
    required this.iseurinuse,
    required this.isfrainuse,
    required this.isgerinuse,
    required this.isindinuse,
    required this.isitlinuse,
    required this.isjpninuse,
    required this.iskorinuse,
    required this.ismexinuse,
    required this.ispakinuse,
    required this.isrussinuse,
    required this.isspasinuse,
    required this.isusainuse,
    required this.isturinuse,
    required this.doyouhavemc,
    required this.doyouhavemedic,
    required this.doyouhavearmor,
    required this.doyouhaveeng,
    required this.doyouhavemage,
    required this.doyouhavepirate,
    required this.doyouhavefinal,
    required this.doyouhaveattack,
    required this.doyouhavecenter,
    required this.doyouhaveelectrickattack,
    required this.doyouhaveexp,
    required this.doyouhavefireattack,
    required this.doyouhavehealth,
    required this.doyouhaveshield,
    required this.doyouhavejump,
    required this.doyouhavetime,
    required this.doyouhavewallbreak,
    required this.doyouhaveof,
    required this.doyouhaveafr,
    required this.doyouhavearb,
    required this.doyouhavearg,
    required this.doyouhaveaus,
    required this.doyouhaveban,
    required this.doyouhavebre,
    required this.doyouhavecan,
    required this.doyouhavechn,
    required this.doyouhaveegy,
    required this.doyouhaveend,
    required this.doyouhaveing,
    required this.doyouhaveeur,
    required this.doyouhavefre,
    required this.doyouhaveger,
    required this.doyouhaveind,
    required this.doyouhaveitl,
    required this.doyouhavejpn,
    required this.doyouhavekor,
    required this.doyouhavemex,
    required this.doyouhavepak,
    required this.doyouhaverus,
    required this.doyouhavespa,
    required this.doyouhavetur,
    required this.doyouhaveusa,
    required this.jumpfunccoin,
    required this.jumpfuncemerald,
    required this.centerfunccoin,
    required this.centerfuncemerald,
    required this.shieldfunccoin,
    required this.shieldfuncemerald,
    required this.healthfunccoin,
    required this.healthfuncemerald,
    required this.timefunccoin,
    required this.timefuncemerald,
    required this.attackfunccoin,
    required this.attackfuncemerald,
    required this.elecattackcoin,
    required this.elecattackemerald,
    required this.wallbreakcoin,
    required this.wallbreakemerald,
    required this.fireattackcoin,
    required this.fireattackemerald,
    required this.expcoin,
    required this.expemerald,
    required this.afrc,
    required this.afre,
    required this.arbc,
    required this.arbe,
    required this.argc,
    required this.arge,
    required this.ausc,
    required this.ause,
    required this.banc,
    required this.bane,
    required this.brec,
    required this.bree,
    required this.canc,
    required this.cane,
    required this.chnc,
    required this.chne,
    required this.egyc,
    required this.egye,
    required this.endc,
    required this.ende,
    required this.inge,
    required this.ingc,
    required this.eurc,
    required this.eure,
    required this.frec,
    required this.free,
    required this.gerc,
    required this.gere,
    required this.indc,
    required this.inde,
    required this.itlc,
    required this.itle,
    required this.jpnc,
    required this.jpne,
    required this.korc,
    required this.kore,
    required this.mexc,
    required this.mexe,
    required this.pakc,
    required this.pake,
    required this.rusc,
    required this.ruse,
    required this.spac,
    required this.spae,
    required this.turc,
    required this.ture,
    required this.usac,
    required this.usae,
    required this.medicc,
    required this.medice,
    required this.armorc,
    required this.armore,
    required this.enginc,
    required this.engine,
    required this.piratec,
    required this.piratee,
    required this.magec,
    required this.magee,
    required this.finalc,
    required this.finale,
    required this.chone,
    required this.chtwo,
    required this.chthree,
    required this.chfour,
    required this.cfive,
    required this.csix,
    required this.cseven,
    required this.ceight,
    required this.cnine,
    required this.cten,
    required this.offuse,
    required this.afruse,
    required this.arbuse,
    required this.arguse,
    required this.aususe,
    required this.banuse,
    required this.breuse,
    required this.canuse,
    required this.chnuse,
    required this.egyuse,
    required this.enduse,
    required this.inguse,
    required this.euruse,
    required this.freuse,
    required this.isgamereallystarted,
    required this.geruse,
    required this.induse,
    required this.itluse,
    required this.jpnuse,
    required this.koruse,
    required this.mexuse,
    required this.pakuse,
    required this.rususe,
    required this.spause,
    required this.turuse,
    required this.usause,
    required this.medicuse,
    required this.armoruse,
    required this.finaluse,
    required this.mageuse,
    required this.pirateuse,
    required this.enginuse,
    required this.normaluse,
  }) : super(key: key);

  final bool onmarket;
  final bool onskills;
  final bool onitem;
  final bool onskins;
  final double shopwidth;

  final bool ismcinuse;
  final bool ismedicinuse;
  final bool isenginuse;
  final bool isarmorinuse;
  final bool ismageinuse;
  final bool ispirateinuse;
  final bool isfinalinuse;

  final bool isofinuse;
  final bool isafrinuse;
  final bool isarbinuse;
  final bool isarginuse;
  final bool isausinuse;
  final bool isbaninuse;
  final bool isbreinuse;
  final bool iscaninuse;
  final bool ischninuse;
  final bool isegyinuse;
  final bool isendinuse;
  final bool isinginuse;
  final bool iseurinuse;
  final bool isfrainuse;
  final bool isgerinuse;
  final bool isindinuse;
  final bool isitlinuse;
  final bool isjpninuse;
  final bool iskorinuse;
  final bool ismexinuse;
  final bool ispakinuse;
  final bool isrussinuse;
  final bool isspasinuse;
  final bool isusainuse;
  final bool isturinuse;

  final bool doyouhavemc;
  final bool doyouhavemedic;
  final bool doyouhavearmor;
  final bool doyouhaveeng;
  final bool doyouhavemage;
  final bool doyouhavepirate;
  final bool doyouhavefinal;

  final bool doyouhaveattack;
  final bool doyouhavecenter;
  final bool doyouhaveelectrickattack;
  final bool doyouhaveexp;
  final bool doyouhavefireattack;
  final bool doyouhavehealth;
  final bool doyouhaveshield;
  final bool doyouhavejump;
  final bool doyouhavetime;
  final bool doyouhavewallbreak;

  final bool doyouhaveof;
  final bool doyouhaveafr;
  final bool doyouhavearb;
  final bool doyouhavearg;
  final bool doyouhaveaus;
  final bool doyouhaveban;
  final bool doyouhavebre;
  final bool doyouhavecan;
  final bool doyouhavechn;
  final bool doyouhaveegy;
  final bool doyouhaveend;
  final bool doyouhaveing;
  final bool doyouhaveeur;
  final bool doyouhavefre;
  final bool doyouhaveger;
  final bool doyouhaveind;
  final bool doyouhaveitl;
  final bool doyouhavejpn;
  final bool doyouhavekor;
  final bool doyouhavemex;
  final bool doyouhavepak;
  final bool doyouhaverus;
  final bool doyouhavespa;
  final bool doyouhavetur;
  final bool doyouhaveusa;

  final Function jumpfunccoin;
  final Function jumpfuncemerald;
  final Function centerfunccoin;
  final Function centerfuncemerald;
  final Function shieldfunccoin;
  final Function shieldfuncemerald;
  final Function healthfunccoin;
  final Function healthfuncemerald;
  final Function timefunccoin;
  final Function timefuncemerald;
  final Function attackfunccoin;
  final Function attackfuncemerald;
  final Function elecattackcoin;
  final Function elecattackemerald;
  final Function wallbreakcoin;
  final Function wallbreakemerald;
  final Function fireattackcoin;
  final Function fireattackemerald;
  final Function expcoin;
  final Function expemerald;

  final Function afrc;
  final Function afre;
  final Function arbc;
  final Function arbe;
  final Function argc;
  final Function arge;
  final Function ausc;
  final Function ause;
  final Function banc;
  final Function bane;
  final Function brec;
  final Function bree;
  final Function canc;
  final Function cane;
  final Function chnc;
  final Function chne;
  final Function egyc;
  final Function egye;
  final Function endc;
  final Function ende;
  final Function inge;
  final Function ingc;
  final Function eurc;
  final Function eure;
  final Function frec;
  final Function free;
  final Function gerc;
  final Function gere;
  final Function indc;
  final Function inde;
  final Function itlc;
  final Function itle;
  final Function jpnc;
  final Function jpne;
  final Function korc;
  final Function kore;
  final Function mexc;
  final Function mexe;
  final Function pakc;
  final Function pake;
  final Function rusc;
  final Function ruse;
  final Function spac;
  final Function spae;
  final Function turc;
  final Function ture;
  final Function usac;
  final Function usae;

  final Function medicc;
  final Function medice;

  final Function armorc;
  final Function armore;

  final Function enginc;
  final Function engine;

  final Function piratec;
  final Function piratee;

  final Function magec;
  final Function magee;

  final Function finalc;
  final Function finale;

  final Function chone;
  final Function chtwo;
  final Function chthree;
  final Function chfour;
  final Function cfive;
  final Function csix;
  final Function cseven;
  final Function ceight;
  final Function cnine;
  final Function cten;

  final Function offuse;
  final Function afruse;
  final Function arbuse;
  final Function arguse;
  final Function aususe;
  final Function banuse;
  final Function breuse;
  final Function canuse;
  final Function chnuse;
  final Function egyuse;
  final Function enduse;
  final Function inguse;
  final Function euruse;
  final Function freuse;
  final Function geruse;
  final Function induse;
  final Function itluse;
  final Function jpnuse;
  final Function koruse;
  final Function mexuse;
  final Function pakuse;
  final Function rususe;
  final Function spause;
  final Function turuse;
  final Function usause;

  final Function medicuse;
  final Function armoruse;
  final Function finaluse;
  final Function mageuse;
  final Function pirateuse;
  final Function enginuse;
  final Function normaluse;

  final Function ftwo;
  final Function fone;
  final Function fthree;

  final double screenheight;
  final double shopleft;
  final double shopheight;
  final Color shopcolor;
  final Color buttontwotext;
  final Color buttontwo;
  final Color buttononetext;
  final Color buttonone;
  final Color buttonthreetext;
  final Color buttonthree;
  final double containertwoheight;
  final double containeroneheight;

  final String skillone;
  final bool doyouhaveskillone;
  final String skilltwo;
  final bool doyouhaveskilltwo;
  final String skillthree;
  final bool doyouhaveskillthree;
  final String skillfour;
  final bool doyouhaveskillfour;

  final Function sonefunc;
  final Function stwofunc;
  final Function sthreefunc;
  final Function sfourfunc;
  final String choosenskin;
  final bool flagcostume;
  final Function switchfunc;
  final String usedflag;
  final bool isgamereallystarted;
  @override
  Widget build(BuildContext context) {
    if (isgamereallystarted == false) {
      return Positioned(
          left: shopleft,
          top: screenheight / 2 - (shopheight / 2),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  blurRadius: 25.0,
                )
              ],
              color: shopcolor,
            ),
            height: shopheight,
            width: shopwidth,
            child: Column(
              children: [
                Row(
                  children: [
                    ShopbuttonWidget(
                        width: shopwidth,
                        c: charmaxwidth,
                        text: "Skins",
                        textcolor: buttononetext,
                        color: buttonone,
                        func: () {
                          fone();
                        }),
                    ShopbuttonWidget(
                        width: shopwidth,
                        color: buttontwo,
                        textcolor: buttontwotext,
                        c: charmaxwidth,
                        text: "Skills",
                        func: () {
                          ftwo();
                        }),
                    ShopbuttonWidget(
                        textcolor: buttonthreetext,
                        width: shopwidth,
                        color: buttonthree,
                        c: charmaxwidth,
                        text: "Flags",
                        func: () {
                          fthree();
                        }),
                  ],
                ),
                SizedBox(height: charmaxwidth / 2),
                Container(
                  width: shopwidth,
                  height: containertwoheight,
                  color: Colors.white,
                  child: Center(
                      child: ReturnEnvWidget(
                          onmarket: onmarket,
                          onskills: onskills,
                          onitem: onitem,
                          shopwidth: shopwidth,
                          screenheight: screenheight,
                          containertwoheight: containertwoheight,
                          skillone: skillone,
                          doyouhaveskillone: doyouhaveskillone,
                          skilltwo: skilltwo,
                          doyouhaveskilltwo: doyouhaveskilltwo,
                          skillthree: skillthree,
                          doyouhaveskillthree: doyouhaveskillthree,
                          skillfour: skillfour,
                          doyouhaveskillfour: doyouhaveskillfour,
                          sonefunc: sonefunc,
                          stwofunc: stwofunc,
                          sthreefunc: sthreefunc,
                          sfourfunc: sfourfunc,
                          onskins: onskins,
                          choosenskin: choosenskin,
                          flagcostume: flagcostume,
                          switchfunc: switchfunc,
                          usedflag: usedflag)),
                ),
                SizedBox(
                  height: containeroneheight,
                  child: ReturnSkillWidget(
                      onmarket: onmarket,
                      onskills: onskills,
                      onitem: onitem,
                      onskins: onskins,
                      shopwidth: shopwidth,
                      ismcinuse: ismcinuse,
                      ismedicinuse: ismedicinuse,
                      isenginuse: isenginuse,
                      isarmorinuse: isarmorinuse,
                      ismageinuse: ismageinuse,
                      ispirateinuse: ispirateinuse,
                      isfinalinuse: isfinalinuse,
                      isofinuse: isofinuse,
                      isafrinuse: isafrinuse,
                      isarbinuse: isarbinuse,
                      isarginuse: isarginuse,
                      isausinuse: isausinuse,
                      isbaninuse: isbaninuse,
                      isbreinuse: isbreinuse,
                      iscaninuse: iscaninuse,
                      ischninuse: ischninuse,
                      isegyinuse: isegyinuse,
                      isendinuse: isendinuse,
                      isinginuse: isinginuse,
                      iseurinuse: iseurinuse,
                      isfrainuse: isfrainuse,
                      isgerinuse: isgerinuse,
                      isindinuse: isindinuse,
                      isitlinuse: isitlinuse,
                      isjpninuse: isjpninuse,
                      iskorinuse: iskorinuse,
                      ismexinuse: ismexinuse,
                      ispakinuse: ispakinuse,
                      isrussinuse: isrussinuse,
                      isspasinuse: isspasinuse,
                      isusainuse: isusainuse,
                      isturinuse: isturinuse,
                      doyouhavemc: doyouhavemc,
                      doyouhavemedic: doyouhavemedic,
                      doyouhavearmor: doyouhavearmor,
                      doyouhaveeng: doyouhaveeng,
                      doyouhavemage: doyouhavemage,
                      doyouhavepirate: doyouhavepirate,
                      doyouhavefinal: doyouhavefinal,
                      doyouhaveattack: doyouhaveattack,
                      doyouhavecenter: doyouhavecenter,
                      doyouhaveelectrickattack: doyouhaveelectrickattack,
                      doyouhaveexp: doyouhaveexp,
                      doyouhavefireattack: doyouhavefireattack,
                      doyouhavehealth: doyouhavehealth,
                      doyouhaveshield: doyouhaveshield,
                      doyouhavejump: doyouhavejump,
                      doyouhavetime: doyouhavetime,
                      doyouhavewallbreak: doyouhavewallbreak,
                      doyouhaveof: doyouhaveof,
                      doyouhaveafr: doyouhaveafr,
                      doyouhavearb: doyouhavearb,
                      doyouhavearg: doyouhavearg,
                      doyouhaveaus: doyouhaveaus,
                      doyouhaveban: doyouhaveban,
                      doyouhavebre: doyouhavebre,
                      doyouhavecan: doyouhavecan,
                      doyouhavechn: doyouhavechn,
                      doyouhaveegy: doyouhaveegy,
                      doyouhaveend: doyouhaveend,
                      doyouhaveing: doyouhaveing,
                      doyouhaveeur: doyouhaveeur,
                      doyouhavefre: doyouhavefre,
                      doyouhaveger: doyouhaveger,
                      doyouhaveind: doyouhaveind,
                      doyouhaveitl: doyouhaveitl,
                      doyouhavejpn: doyouhavejpn,
                      doyouhavekor: doyouhavekor,
                      doyouhavemex: doyouhavemex,
                      doyouhavepak: doyouhavepak,
                      doyouhaverus: doyouhaverus,
                      doyouhavespa: doyouhavespa,
                      doyouhavetur: doyouhavetur,
                      doyouhaveusa: doyouhaveusa,
                      jumpfunccoin: jumpfunccoin,
                      jumpfuncemerald: jumpfuncemerald,
                      centerfunccoin: centerfunccoin,
                      centerfuncemerald: centerfuncemerald,
                      shieldfunccoin: shieldfunccoin,
                      shieldfuncemerald: shieldfuncemerald,
                      healthfunccoin: healthfunccoin,
                      healthfuncemerald: healthfuncemerald,
                      timefunccoin: timefunccoin,
                      timefuncemerald: timefuncemerald,
                      attackfunccoin: attackfunccoin,
                      attackfuncemerald: attackfuncemerald,
                      elecattackcoin: elecattackcoin,
                      elecattackemerald: elecattackemerald,
                      wallbreakcoin: wallbreakcoin,
                      wallbreakemerald: wallbreakemerald,
                      fireattackcoin: fireattackcoin,
                      fireattackemerald: fireattackemerald,
                      expcoin: expcoin,
                      expemerald: expemerald,
                      afrc: afrc,
                      afre: afre,
                      arbc: arbc,
                      arbe: arbe,
                      argc: argc,
                      arge: arge,
                      ausc: ausc,
                      ause: ause,
                      banc: banc,
                      bane: bane,
                      brec: brec,
                      bree: bree,
                      canc: canc,
                      cane: cane,
                      chnc: chnc,
                      chne: chne,
                      egyc: egyc,
                      egye: egye,
                      endc: endc,
                      ende: ende,
                      inge: inge,
                      ingc: ingc,
                      eurc: eurc,
                      eure: eure,
                      frec: frec,
                      free: free,
                      gerc: gerc,
                      gere: gere,
                      indc: indc,
                      inde: inde,
                      itlc: itlc,
                      itle: itle,
                      jpnc: jpnc,
                      jpne: jpne,
                      korc: korc,
                      kore: kore,
                      mexc: mexc,
                      mexe: mexe,
                      pakc: pakc,
                      pake: pake,
                      rusc: rusc,
                      ruse: ruse,
                      spac: spac,
                      spae: spae,
                      turc: turc,
                      ture: ture,
                      usac: usac,
                      usae: usae,
                      medicc: medicc,
                      medice: medice,
                      armorc: armorc,
                      armore: armore,
                      enginc: enginc,
                      engine: engine,
                      piratec: piratec,
                      piratee: piratee,
                      magec: magec,
                      magee: magee,
                      finalc: finalc,
                      finale: finale,
                      chone: chone,
                      chtwo: chtwo,
                      chthree: chthree,
                      chfour: chfour,
                      cfive: cfive,
                      csix: csix,
                      cseven: cseven,
                      ceight: ceight,
                      cnine: cnine,
                      cten: cten,
                      offuse: offuse,
                      afruse: afruse,
                      arbuse: arbuse,
                      arguse: arguse,
                      aususe: aususe,
                      banuse: banuse,
                      breuse: breuse,
                      canuse: canuse,
                      chnuse: chnuse,
                      egyuse: egyuse,
                      enduse: enduse,
                      inguse: inguse,
                      euruse: euruse,
                      freuse: freuse,
                      geruse: geruse,
                      induse: induse,
                      itluse: itluse,
                      jpnuse: jpnuse,
                      koruse: koruse,
                      mexuse: mexuse,
                      pakuse: pakuse,
                      rususe: rususe,
                      spause: spause,
                      turuse: turuse,
                      usause: usause,
                      medicuse: medicuse,
                      armoruse: armoruse,
                      finaluse: finaluse,
                      mageuse: mageuse,
                      pirateuse: pirateuse,
                      enginuse: enginuse,
                      normaluse: normaluse),
                ),
              ],
            ),
          ));
    } else {
      return Positioned(child: Container());
    }
  }
}

class ReturnEnvWidget extends StatelessWidget {
  const ReturnEnvWidget({
    Key? key,
    required this.onmarket,
    required this.onskills,
    required this.onitem,
    required this.shopwidth,
    required this.screenheight,
    required this.containertwoheight,
    required this.skillone,
    required this.doyouhaveskillone,
    required this.skilltwo,
    required this.doyouhaveskilltwo,
    required this.skillthree,
    required this.doyouhaveskillthree,
    required this.skillfour,
    required this.doyouhaveskillfour,
    required this.sonefunc,
    required this.stwofunc,
    required this.sthreefunc,
    required this.sfourfunc,
    required this.onskins,
    required this.choosenskin,
    required this.flagcostume,
    required this.switchfunc,
    required this.usedflag,
  }) : super(key: key);

  final double shopwidth;
  final double screenheight;
  final double containertwoheight;

  final bool onmarket;
  final bool onskills;
  final bool onitem;
  final String skillone;
  final bool doyouhaveskillone;
  final String skilltwo;
  final bool doyouhaveskilltwo;
  final String skillthree;
  final bool doyouhaveskillthree;
  final String skillfour;
  final bool doyouhaveskillfour;
  final Function switchfunc;
  //herenow
  final Function sonefunc;
  final Function stwofunc;
  final Function sthreefunc;
  final Function sfourfunc;
  final bool onskins;
  final String choosenskin;
  final bool flagcostume;
  final String usedflag;

  @override
  Widget build(BuildContext context) {
    if (onmarket != true) {
      if (onskills) {
        return SizedBox(
          width: shopwidth,
          height: (screenheight * 6 / 10 - (shopwidth / 4) - (charmaxwidth)) *
              5 /
              8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: containertwoheight / 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SkillPWidget(
                        img: skillone,
                        shopwidth: shopwidth,
                        b: doyouhaveskillone,
                        money: "0",
                        f: () {
                          FlameAudio.play("unlock.wav");
                          sonefunc();
                        }),
                    SkillPWidget(
                        img: skilltwo,
                        shopwidth: shopwidth,
                        b: doyouhaveskilltwo,
                        money: "100",
                        f: () {
                          FlameAudio.play("unlock.wav");
                          stwofunc();
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: containertwoheight / 2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SkillPWidget(
                        img: skillthree,
                        shopwidth: shopwidth,
                        b: doyouhaveskillthree,
                        money: "500",
                        f: () {
                          FlameAudio.play("unlock.wav");
                          sthreefunc();
                        }),
                    SkillPWidget(
                        img: skillfour,
                        shopwidth: shopwidth,
                        b: doyouhaveskillfour,
                        money: "1500",
                        f: () {
                          FlameAudio.play("unlock.wav");
                          sfourfunc();
                        }),
                  ],
                ),
              ),
            ],
          ),
        );
      } else if (onskins) {
        return Padding(
          padding: EdgeInsets.all(containertwoheight * 2 / 10),
          child: SizedBox(
            width: containertwoheight,
            height: containertwoheight,
            child: Image.asset(choosenskin),
          ),
        );
      } else if (onitem) {
        return Column(
          children: [
            SizedBox(
              height: containertwoheight * 2 / 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "👕",
                    style: TextStyle(fontSize: containertwoheight * 1 / 10),
                  ),
                  Switch(
                      value: flagcostume,
                      activeColor: const Color(0xff00696a),
                      onChanged: (bool value) {
                        switchfunc(value);
                      })
                ],
              ),
            ),
            SizedBox(
              width: containertwoheight * 8 / 10,
              height: containertwoheight * 8 / 10,
              child: Image.asset(usedflag),
            )
          ],
        );
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }
}

class ReturnSkillWidget extends StatelessWidget {
  const ReturnSkillWidget({
    Key? key,
    required this.onmarket,
    required this.onskills,
    required this.onitem,
    required this.onskins,
    required this.shopwidth,
    required this.ismcinuse,
    required this.ismedicinuse,
    required this.isenginuse,
    required this.isarmorinuse,
    required this.ismageinuse,
    required this.ispirateinuse,
    required this.isfinalinuse,
    required this.isofinuse,
    required this.isafrinuse,
    required this.isarbinuse,
    required this.isarginuse,
    required this.isausinuse,
    required this.isbaninuse,
    required this.isbreinuse,
    required this.iscaninuse,
    required this.ischninuse,
    required this.isegyinuse,
    required this.isendinuse,
    required this.isinginuse,
    required this.iseurinuse,
    required this.isfrainuse,
    required this.isgerinuse,
    required this.isindinuse,
    required this.isitlinuse,
    required this.isjpninuse,
    required this.iskorinuse,
    required this.ismexinuse,
    required this.ispakinuse,
    required this.isrussinuse,
    required this.isspasinuse,
    required this.isusainuse,
    required this.isturinuse,
    required this.doyouhavemc,
    required this.doyouhavemedic,
    required this.doyouhavearmor,
    required this.doyouhaveeng,
    required this.doyouhavemage,
    required this.doyouhavepirate,
    required this.doyouhavefinal,
    required this.doyouhaveattack,
    required this.doyouhavecenter,
    required this.doyouhaveelectrickattack,
    required this.doyouhaveexp,
    required this.doyouhavefireattack,
    required this.doyouhavehealth,
    required this.doyouhaveshield,
    required this.doyouhavejump,
    required this.doyouhavetime,
    required this.doyouhavewallbreak,
    required this.doyouhaveof,
    required this.doyouhaveafr,
    required this.doyouhavearb,
    required this.doyouhavearg,
    required this.doyouhaveaus,
    required this.doyouhaveban,
    required this.doyouhavebre,
    required this.doyouhavecan,
    required this.doyouhavechn,
    required this.doyouhaveegy,
    required this.doyouhaveend,
    required this.doyouhaveing,
    required this.doyouhaveeur,
    required this.doyouhavefre,
    required this.doyouhaveger,
    required this.doyouhaveind,
    required this.doyouhaveitl,
    required this.doyouhavejpn,
    required this.doyouhavekor,
    required this.doyouhavemex,
    required this.doyouhavepak,
    required this.doyouhaverus,
    required this.doyouhavespa,
    required this.doyouhavetur,
    required this.doyouhaveusa,
    required this.jumpfunccoin,
    required this.jumpfuncemerald,
    required this.centerfunccoin,
    required this.centerfuncemerald,
    required this.shieldfunccoin,
    required this.shieldfuncemerald,
    required this.healthfunccoin,
    required this.healthfuncemerald,
    required this.timefunccoin,
    required this.timefuncemerald,
    required this.attackfunccoin,
    required this.attackfuncemerald,
    required this.elecattackcoin,
    required this.elecattackemerald,
    required this.wallbreakcoin,
    required this.wallbreakemerald,
    required this.fireattackcoin,
    required this.fireattackemerald,
    required this.expcoin,
    required this.expemerald,
    required this.afrc,
    required this.afre,
    required this.arbc,
    required this.arbe,
    required this.argc,
    required this.arge,
    required this.ausc,
    required this.ause,
    required this.banc,
    required this.bane,
    required this.brec,
    required this.bree,
    required this.canc,
    required this.cane,
    required this.chnc,
    required this.chne,
    required this.egyc,
    required this.egye,
    required this.endc,
    required this.ende,
    required this.inge,
    required this.ingc,
    required this.eurc,
    required this.eure,
    required this.frec,
    required this.free,
    required this.gerc,
    required this.gere,
    required this.indc,
    required this.inde,
    required this.itlc,
    required this.itle,
    required this.jpnc,
    required this.jpne,
    required this.korc,
    required this.kore,
    required this.mexc,
    required this.mexe,
    required this.pakc,
    required this.pake,
    required this.rusc,
    required this.ruse,
    required this.spac,
    required this.spae,
    required this.turc,
    required this.ture,
    required this.usac,
    required this.usae,
    required this.medicc,
    required this.medice,
    required this.armorc,
    required this.armore,
    required this.enginc,
    required this.engine,
    required this.piratec,
    required this.piratee,
    required this.magec,
    required this.magee,
    required this.finalc,
    required this.finale,
    required this.chone,
    required this.chtwo,
    required this.chthree,
    required this.chfour,
    required this.cfive,
    required this.csix,
    required this.cseven,
    required this.ceight,
    required this.cnine,
    required this.cten,
    required this.offuse,
    required this.afruse,
    required this.arbuse,
    required this.arguse,
    required this.aususe,
    required this.banuse,
    required this.breuse,
    required this.canuse,
    required this.chnuse,
    required this.egyuse,
    required this.enduse,
    required this.inguse,
    required this.euruse,
    required this.freuse,
    required this.geruse,
    required this.induse,
    required this.itluse,
    required this.jpnuse,
    required this.koruse,
    required this.mexuse,
    required this.pakuse,
    required this.rususe,
    required this.spause,
    required this.turuse,
    required this.usause,
    required this.medicuse,
    required this.armoruse,
    required this.finaluse,
    required this.mageuse,
    required this.pirateuse,
    required this.enginuse,
    required this.normaluse,
  }) : super(key: key);

  final bool onmarket;
  final bool onskills;
  final bool onitem;
  final bool onskins;
  final double shopwidth;

  final bool ismcinuse;
  final bool ismedicinuse;
  final bool isenginuse;
  final bool isarmorinuse;
  final bool ismageinuse;
  final bool ispirateinuse;
  final bool isfinalinuse;

  final bool isofinuse;
  final bool isafrinuse;
  final bool isarbinuse;
  final bool isarginuse;
  final bool isausinuse;
  final bool isbaninuse;
  final bool isbreinuse;
  final bool iscaninuse;
  final bool ischninuse;
  final bool isegyinuse;
  final bool isendinuse;
  final bool isinginuse;
  final bool iseurinuse;
  final bool isfrainuse;
  final bool isgerinuse;
  final bool isindinuse;
  final bool isitlinuse;
  final bool isjpninuse;
  final bool iskorinuse;
  final bool ismexinuse;
  final bool ispakinuse;
  final bool isrussinuse;
  final bool isspasinuse;
  final bool isusainuse;
  final bool isturinuse;

  final bool doyouhavemc;
  final bool doyouhavemedic;
  final bool doyouhavearmor;
  final bool doyouhaveeng;
  final bool doyouhavemage;
  final bool doyouhavepirate;
  final bool doyouhavefinal;

  final bool doyouhaveattack;
  final bool doyouhavecenter;
  final bool doyouhaveelectrickattack;
  final bool doyouhaveexp;
  final bool doyouhavefireattack;
  final bool doyouhavehealth;
  final bool doyouhaveshield;
  final bool doyouhavejump;
  final bool doyouhavetime;
  final bool doyouhavewallbreak;

  final bool doyouhaveof;
  final bool doyouhaveafr;
  final bool doyouhavearb;
  final bool doyouhavearg;
  final bool doyouhaveaus;
  final bool doyouhaveban;
  final bool doyouhavebre;
  final bool doyouhavecan;
  final bool doyouhavechn;
  final bool doyouhaveegy;
  final bool doyouhaveend;
  final bool doyouhaveing;
  final bool doyouhaveeur;
  final bool doyouhavefre;
  final bool doyouhaveger;
  final bool doyouhaveind;
  final bool doyouhaveitl;
  final bool doyouhavejpn;
  final bool doyouhavekor;
  final bool doyouhavemex;
  final bool doyouhavepak;
  final bool doyouhaverus;
  final bool doyouhavespa;
  final bool doyouhavetur;
  final bool doyouhaveusa;

  final Function jumpfunccoin;
  final Function jumpfuncemerald;
  final Function centerfunccoin;
  final Function centerfuncemerald;
  final Function shieldfunccoin;
  final Function shieldfuncemerald;
  final Function healthfunccoin;
  final Function healthfuncemerald;
  final Function timefunccoin;
  final Function timefuncemerald;
  final Function attackfunccoin;
  final Function attackfuncemerald;
  final Function elecattackcoin;
  final Function elecattackemerald;
  final Function wallbreakcoin;
  final Function wallbreakemerald;
  final Function fireattackcoin;
  final Function fireattackemerald;
  final Function expcoin;
  final Function expemerald;

  final Function afrc;
  final Function afre;
  final Function arbc;
  final Function arbe;
  final Function argc;
  final Function arge;
  final Function ausc;
  final Function ause;
  final Function banc;
  final Function bane;
  final Function brec;
  final Function bree;
  final Function canc;
  final Function cane;
  final Function chnc;
  final Function chne;
  final Function egyc;
  final Function egye;
  final Function endc;
  final Function ende;
  final Function inge;
  final Function ingc;
  final Function eurc;
  final Function eure;
  final Function frec;
  final Function free;
  final Function gerc;
  final Function gere;
  final Function indc;
  final Function inde;
  final Function itlc;
  final Function itle;
  final Function jpnc;
  final Function jpne;
  final Function korc;
  final Function kore;
  final Function mexc;
  final Function mexe;
  final Function pakc;
  final Function pake;
  final Function rusc;
  final Function ruse;
  final Function spac;
  final Function spae;
  final Function turc;
  final Function ture;
  final Function usac;
  final Function usae;

  final Function medicc;
  final Function medice;

  final Function armorc;
  final Function armore;

  final Function enginc;
  final Function engine;

  final Function piratec;
  final Function piratee;

  final Function magec;
  final Function magee;

  final Function finalc;
  final Function finale;

  final Function chone;
  final Function chtwo;
  final Function chthree;
  final Function chfour;
  final Function cfive;
  final Function csix;
  final Function cseven;
  final Function ceight;
  final Function cnine;
  final Function cten;

  final Function offuse;
  final Function afruse;
  final Function arbuse;
  final Function arguse;
  final Function aususe;
  final Function banuse;
  final Function breuse;
  final Function canuse;
  final Function chnuse;
  final Function egyuse;
  final Function enduse;
  final Function inguse;
  final Function euruse;
  final Function freuse;
  final Function geruse;
  final Function induse;
  final Function itluse;
  final Function jpnuse;
  final Function koruse;
  final Function mexuse;
  final Function pakuse;
  final Function rususe;
  final Function spause;
  final Function turuse;
  final Function usause;

  final Function medicuse;
  final Function armoruse;
  final Function finaluse;
  final Function mageuse;
  final Function pirateuse;
  final Function enginuse;
  final Function normaluse;

  @override
  Widget build(BuildContext context) {
    if (onmarket) {
      if (onskills) {
        return ListView(
          children: [
            ShopRowWidget(
              funconec: () {
                jumpfunccoin();
              },
              funconee: () {
                jumpfuncemerald();
              },
              functwoc: () {
                centerfunccoin();
              },
              functwoe: () {
                centerfuncemerald();
              },
              boolone: doyouhavejump,
              booltwo: doyouhavecenter,
              width: shopwidth,
              imageone: "images/buttons/on/jumpon.png",
              imagetwo: "images/buttons/on/centeron.png",
              diamondone: 0,
              diamondtwo: 1,
              coinone: 0,
              cointwo: 10,
            ),
            SizedBox(height: charmaxwidth / 2),
            ShopRowWidget(
              funconec: () {
                shieldfunccoin();
              },
              funconee: () {
                shieldfuncemerald();
              },
              functwoc: () {
                healthfunccoin();
              },
              functwoe: () {
                healthfuncemerald();
              },
              boolone: doyouhaveshield,
              booltwo: doyouhavehealth,
              width: shopwidth,
              imageone: "images/buttons/on/shieldon.png",
              imagetwo: "images/buttons/on/healthon.png",
              diamondone: 5,
              diamondtwo: 5,
              coinone: 100,
              cointwo: 100,
            ),
            SizedBox(height: charmaxwidth / 2),
            ShopRowWidget(
              funconec: () {
                attackfunccoin();
              },
              funconee: () {
                attackfuncemerald();
              },
              functwoc: () {
                timefunccoin();
              },
              functwoe: () {
                timefuncemerald();
              },
              boolone: doyouhaveattack,
              booltwo: doyouhavetime,
              width: shopwidth,
              imageone: "images/buttons/on/attackon.png",
              imagetwo: "images/buttons/on/timeon.png",
              diamondone: 10,
              diamondtwo: 10,
              coinone: 250,
              cointwo: 250,
            ),
            SizedBox(height: charmaxwidth / 2),
            ShopRowWidget(
              funconec: () {
                elecattackcoin();
              },
              funconee: () {
                elecattackemerald();
              },
              functwoc: () {
                wallbreakcoin();
              },
              functwoe: () {
                wallbreakemerald();
              },
              boolone: doyouhaveelectrickattack,
              booltwo: doyouhavewallbreak,
              width: shopwidth,
              imageone: "images/buttons/on/electricattackon.png",
              imagetwo: "images/buttons/on/wallbreakon.png",
              diamondone: 20,
              diamondtwo: 20,
              coinone: 500,
              cointwo: 500,
            ),
            SizedBox(height: charmaxwidth / 2),
            ShopRowWidget(
              funconec: () {
                expcoin();
              },
              funconee: () {
                expemerald();
              },
              functwoc: () {
                fireattackcoin();
              },
              functwoe: () {
                fireattackemerald();
              },
              boolone: doyouhaveexp,
              booltwo: doyouhavefireattack,
              width: shopwidth,
              imageone: "images/buttons/on/expon.png",
              imagetwo: "images/buttons/on/fireattackon.png",
              diamondone: 30,
              diamondtwo: 30,
              coinone: 1000,
              cointwo: 1000,
            ),
            SizedBox(height: charmaxwidth / 2),
          ],
        );
      } else if (onitem) {
        return ListView(children: [
          ShopRowWidget(
            funconec: () {
              afrc();
            },
            funconee: () {
              afre();
            },
            functwoc: () {
              arbc();
            },
            functwoe: () {
              arbe();
            },
            boolone: doyouhaveafr,
            booltwo: doyouhavearb,
            width: shopwidth,
            imageone: "images/flags/small/afrsmall.png",
            imagetwo: "images/flags/small/arbsmall.png",
            diamondone: 5,
            diamondtwo: 5,
            coinone: 400,
            cointwo: 400,
          ),
          SizedBox(height: charmaxwidth / 2),
          ShopRowWidget(
            funconec: () {
              argc();
            },
            funconee: () {
              arge();
            },
            functwoc: () {
              ausc();
            },
            functwoe: () {
              ause();
            },
            boolone: doyouhavearg,
            booltwo: doyouhaveaus,
            width: shopwidth,
            imageone: "images/flags/small/argsmall.png",
            imagetwo: "images/flags/small/aussmall.png",
            diamondone: 5,
            diamondtwo: 5,
            coinone: 400,
            cointwo: 400,
          ),
          SizedBox(height: charmaxwidth / 2),
          ShopRowWidget(
            funconec: () {
              banc();
            },
            funconee: () {
              bane();
            },
            functwoc: () {
              brec();
            },
            functwoe: () {
              bree();
            },
            boolone: doyouhaveban,
            booltwo: doyouhavebre,
            width: shopwidth,
            imageone: "images/flags/small/bansmall.png",
            imagetwo: "images/flags/small/bresmall.png",
            diamondone: 5,
            diamondtwo: 5,
            coinone: 400,
            cointwo: 400,
          ),
          SizedBox(height: charmaxwidth / 2),
          ShopRowWidget(
            funconec: () {
              canc();
            },
            funconee: () {
              cane();
            },
            functwoc: () {
              chnc();
            },
            functwoe: () {
              chne();
            },
            boolone: doyouhavecan,
            booltwo: doyouhavechn,
            width: shopwidth,
            imageone: "images/flags/small/cansmall.png",
            imagetwo: "images/flags/small/chnsmall.png",
            diamondone: 5,
            diamondtwo: 5,
            coinone: 400,
            cointwo: 400,
          ),
          SizedBox(height: charmaxwidth / 2),
          ShopRowWidget(
            funconec: () {
              egyc();
            },
            funconee: () {
              egye();
            },
            functwoc: () {
              endc();
            },
            functwoe: () {
              ende();
            },
            boolone: doyouhaveegy,
            booltwo: doyouhaveend,
            width: shopwidth,
            imageone: "images/flags/small/egysmall.png",
            imagetwo: "images/flags/small/endsmall.png",
            diamondone: 5,
            diamondtwo: 5,
            coinone: 400,
            cointwo: 400,
          ),
          SizedBox(height: charmaxwidth / 2),
          ShopRowWidget(
            funconec: () {
              ingc();
            },
            funconee: () {
              inge();
            },
            functwoc: () {
              eurc();
            },
            functwoe: () {
              eure();
            },
            boolone: doyouhaveing,
            booltwo: doyouhaveeur,
            width: shopwidth,
            imageone: "images/flags/small/engsmall.png",
            imagetwo: "images/flags/small/eursmall.png",
            diamondone: 5,
            diamondtwo: 5,
            coinone: 400,
            cointwo: 400,
          ),
          SizedBox(height: charmaxwidth / 2),
          ShopRowWidget(
            funconec: () {
              frec();
            },
            funconee: () {
              free();
            },
            functwoc: () {
              gerc();
            },
            functwoe: () {
              gere();
            },
            boolone: doyouhavefre,
            booltwo: doyouhaveger,
            width: shopwidth,
            imageone: "images/flags/small/frasmall.png",
            imagetwo: "images/flags/small/gersmall.png",
            diamondone: 5,
            diamondtwo: 5,
            coinone: 400,
            cointwo: 400,
          ),
          SizedBox(height: charmaxwidth / 2),
          ShopRowWidget(
            funconec: () {
              indc();
            },
            funconee: () {
              inde();
            },
            functwoc: () {
              itlc();
            },
            functwoe: () {
              itle();
            },
            boolone: doyouhaveind,
            booltwo: doyouhaveitl,
            width: shopwidth,
            imageone: "images/flags/small/indsmall.png",
            imagetwo: "images/flags/small/itlsmall.png",
            diamondone: 5,
            diamondtwo: 5,
            coinone: 400,
            cointwo: 400,
          ),
          SizedBox(height: charmaxwidth / 2),
          ShopRowWidget(
            funconec: () {
              jpnc();
            },
            funconee: () {
              jpne();
            },
            functwoc: () {
              korc();
            },
            functwoe: () {
              kore();
            },
            boolone: doyouhavejpn,
            booltwo: doyouhavekor,
            width: shopwidth,
            imageone: "images/flags/small/japsmal.png",
            imagetwo: "images/flags/small/korsmall.png",
            diamondone: 5,
            diamondtwo: 5,
            coinone: 400,
            cointwo: 400,
          ),
          SizedBox(height: charmaxwidth / 2),
          ShopRowWidget(
            funconec: () {
              mexc();
            },
            funconee: () {
              mexe();
            },
            functwoc: () {
              pakc();
            },
            functwoe: () {
              pake();
            },
            boolone: doyouhavemex,
            booltwo: doyouhavepak,
            width: shopwidth,
            imageone: "images/flags/small/mexsmal.png",
            imagetwo: "images/flags/small/paksmall.png",
            diamondone: 5,
            diamondtwo: 5,
            coinone: 400,
            cointwo: 400,
          ),
          SizedBox(height: charmaxwidth / 2),
          ShopRowWidget(
            funconec: () {
              spac();
            },
            funconee: () {
              spae();
            },
            functwoc: () {
              rusc();
            },
            functwoe: () {
              ruse();
            },
            boolone: doyouhavespa,
            booltwo: doyouhaverus,
            width: shopwidth,
            imageone: "images/flags/small/spasmall.png",
            imagetwo: "images/flags/small/russmall.png",
            diamondone: 5,
            diamondtwo: 5,
            coinone: 400,
            cointwo: 400,
          ),
          SizedBox(height: charmaxwidth / 2),
          ShopRowWidget(
            funconec: () {
              turc();
            },
            funconee: () {
              ture();
            },
            functwoc: () {
              usac();
            },
            functwoe: () {
              usae();
            },
            boolone: doyouhavetur,
            booltwo: doyouhaveusa,
            width: shopwidth,
            imageone: "images/flags/small/tursmall.png",
            imagetwo: "images/flags/small/usasmall.png",
            diamondone: 5,
            diamondtwo: 5,
            coinone: 400,
            cointwo: 400,
          ),
          SizedBox(height: charmaxwidth / 2),
        ]);
      } else if (onskins) {
        return ListView(
          children: [
            ShopRowWidget(
              funconec: () {
                medicc();
              },
              funconee: () {
                medice();
              },
              functwoc: () {
                armorc();
              },
              functwoe: () {
                armore();
              },
              boolone: doyouhavemedic,
              booltwo: doyouhavearmor,
              width: shopwidth,
              imageone: "images/characters/skins/skinnormal/medic.png",
              imagetwo: "images/characters/skins/skinnormal/armor.png",
              diamondone: 5,
              diamondtwo: 5,
              coinone: 100,
              cointwo: 100,
            ),
            SizedBox(height: charmaxwidth / 2),
            ShopRowWidget(
              funconec: () {
                piratec();
              },
              funconee: () {
                piratee();
              },
              functwoc: () {
                magec();
              },
              functwoe: () {
                magee();
              },
              boolone: doyouhavepirate,
              booltwo: doyouhavemage,
              width: shopwidth,
              imageone: "images/characters/skins/skinnormal/pirate.png",
              imagetwo: "images/characters/skins/skinnormal/mage.png",
              diamondone: 20,
              diamondtwo: 20,
              coinone: 500,
              cointwo: 500,
            ),
            SizedBox(height: charmaxwidth / 2),
            ShopRowWidget(
              funconec: () {
                enginc();
              },
              funconee: () {
                engine();
              },
              functwoc: () {
                finalc();
              },
              functwoe: () {
                finale();
              },
              boolone: doyouhaveeng,
              booltwo: doyouhavefinal,
              width: shopwidth,
              imageone: "images/characters/skins/skinnormal/eng.png",
              imagetwo: "images/characters/skins/skinnormal/final.png",
              diamondone: 30,
              diamondtwo: 50,
              coinone: 1000,
              cointwo: 5000,
            ),
            SizedBox(height: charmaxwidth / 2),
          ],
        );
      } else {
        return ListView(children: const []);
      }
    } else {
      if (onskills) {
        return ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SkillConWidget(
                    f: (x) {
                      FlameAudio.play("use.wav");
                      chone(x);
                    },
                    shopwidth: shopwidth,
                    b: doyouhavejump,
                    img: "images/buttons/on/jumpon.png"),
                SkillConWidget(
                    f: (x) {
                      FlameAudio.play("use.wav");
                      chtwo(x);
                    },
                    shopwidth: shopwidth,
                    b: doyouhavecenter,
                    img: "images/buttons/on/centeron.png"),
                SkillConWidget(
                    f: (x) {
                      FlameAudio.play("use.wav");
                      chthree(x);
                    },
                    shopwidth: shopwidth,
                    b: doyouhavehealth,
                    img: "images/buttons/on/healthon.png"),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SkillConWidget(
                    f: (x) {
                      FlameAudio.play("use.wav");

                      chfour(x);
                    },
                    shopwidth: shopwidth,
                    b: doyouhaveelectrickattack,
                    img: "images/buttons/on/electricattackon.png"),
                SkillConWidget(
                    f: (x) {
                      FlameAudio.play("use.wav");

                      cfive(x);
                    },
                    shopwidth: shopwidth,
                    b: doyouhavefireattack,
                    img: "images/buttons/on/fireattackon.png"),
                SkillConWidget(
                    f: (x) {
                      FlameAudio.play("use.wav");
                      csix(x);
                    },
                    shopwidth: shopwidth,
                    b: doyouhaveattack,
                    img: "images/buttons/on/attackon.png"),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SkillConWidget(
                    f: (x) {
                      FlameAudio.play("use.wav");
                      cseven(x);
                    },
                    shopwidth: shopwidth,
                    b: doyouhaveexp,
                    img: "images/buttons/on/expon.png"),
                SkillConWidget(
                    f: (x) {
                      FlameAudio.play("use.wav");
                      ceight(x);
                    },
                    shopwidth: shopwidth,
                    b: doyouhavetime,
                    img: "images/buttons/on/timeon.png"),
                SkillConWidget(
                    f: (x) {
                      FlameAudio.play("use.wav");
                      cnine(x);
                    },
                    shopwidth: shopwidth,
                    b: doyouhavewallbreak,
                    img: "images/buttons/on/wallbreakon.png"),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SkillConWidget(
                    f: (x) {
                      FlameAudio.play("use.wav");
                      cten(x);
                    },
                    shopwidth: shopwidth,
                    b: doyouhaveshield,
                    img: "images/buttons/on/shieldon.png"),
              ],
            ),
          ],
        );
      } else if (onitem) {
        return ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnvConWidget(
                  f: () {
                    offuse();
                  },
                  btwo: isofinuse,
                  shopwidth: shopwidth,
                  b: doyouhaveof,
                  img: "images/flags/small/off.png",
                ),
                EnvConWidget(
                  f: () {
                    afruse();
                  },
                  btwo: isafrinuse,
                  shopwidth: shopwidth,
                  b: doyouhaveafr,
                  img: "images/flags/small/afrsmall.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    arbuse();
                  },
                  btwo: isarbinuse,
                  shopwidth: shopwidth,
                  b: doyouhavearb,
                  img: "images/flags/small/arbsmall.png",
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnvConWidget(
                  //here
                  f: () {
                    arguse();
                  },
                  btwo: isarginuse,
                  shopwidth: shopwidth,
                  b: doyouhavearg,
                  img: "images/flags/small/argsmall.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    aususe();
                  },
                  btwo: isausinuse,
                  shopwidth: shopwidth,
                  b: doyouhaveaus,
                  img: "images/flags/small/aussmall.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    banuse();
                  },
                  btwo: isbaninuse,
                  shopwidth: shopwidth,
                  b: doyouhaveban,
                  img: "images/flags/small/bansmall.png",
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnvConWidget(
                  //here
                  f: () {
                    breuse();
                  },
                  btwo: isbreinuse,
                  shopwidth: shopwidth,
                  b: doyouhavebre,
                  img: "images/flags/small/bresmall.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    canuse();
                  },
                  btwo: iscaninuse,
                  shopwidth: shopwidth,
                  b: doyouhavecan,
                  img: "images/flags/small/cansmall.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    chnuse();
                  },
                  btwo: ischninuse,
                  shopwidth: shopwidth,
                  b: doyouhavechn,
                  img: "images/flags/small/chnsmall.png",
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnvConWidget(
                  //here
                  f: () {
                    egyuse();
                  },
                  btwo: isegyinuse,
                  shopwidth: shopwidth,
                  b: doyouhaveegy,
                  img: "images/flags/small/egysmall.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    enduse();
                  },
                  btwo: isendinuse,
                  shopwidth: shopwidth,
                  b: doyouhaveend,
                  img: "images/flags/small/endsmall.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    inguse();
                  },
                  btwo: isinginuse,
                  shopwidth: shopwidth,
                  b: doyouhaveing,
                  img: "images/flags/small/engsmall.png",
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnvConWidget(
                  //here
                  f: () {
                    euruse();
                  },
                  btwo: iseurinuse,
                  shopwidth: shopwidth,
                  b: doyouhaveeur,
                  img: "images/flags/small/eursmall.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    freuse();
                  },
                  btwo: isfrainuse,
                  shopwidth: shopwidth,
                  b: doyouhavefre,
                  img: "images/flags/small/frasmall.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    geruse();
                  },
                  btwo: isgerinuse,
                  shopwidth: shopwidth,
                  b: doyouhaveger,
                  img: "images/flags/small/gersmall.png",
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnvConWidget(
                  //here
                  f: () {
                    induse();
                  },
                  btwo: isindinuse,
                  shopwidth: shopwidth,
                  b: doyouhaveind,
                  img: "images/flags/small/indsmall.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    itluse();
                  },
                  btwo: isitlinuse,
                  shopwidth: shopwidth,
                  b: doyouhaveitl,
                  img: "images/flags/small/itlsmall.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    jpnuse();
                  },
                  btwo: isjpninuse,
                  shopwidth: shopwidth,
                  b: doyouhavejpn,
                  img: "images/flags/small/japsmal.png",
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnvConWidget(
                  //here
                  f: () {
                    koruse();
                  },
                  btwo: iskorinuse,
                  shopwidth: shopwidth,
                  b: doyouhavekor,
                  img: "images/flags/small/korsmall.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    mexuse();
                  },
                  btwo: ismexinuse,
                  shopwidth: shopwidth,
                  b: doyouhavemex,
                  img: "images/flags/small/mexsmal.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    pakuse();
                  },
                  btwo: ispakinuse,
                  shopwidth: shopwidth,
                  b: doyouhavepak,
                  img: "images/flags/small/paksmall.png",
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnvConWidget(
                  //here
                  f: () {
                    rususe();
                  },
                  btwo: isrussinuse,
                  shopwidth: shopwidth,
                  b: doyouhaverus,
                  img: "images/flags/small/russmall.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    spause();
                  },
                  btwo: isspasinuse,
                  shopwidth: shopwidth,
                  b: doyouhavespa,
                  img: "images/flags/small/spasmall.png",
                ),
                EnvConWidget(
                  //here
                  f: () {
                    turuse();
                  },
                  btwo: isturinuse,
                  shopwidth: shopwidth,
                  b: doyouhavetur,
                  img: "images/flags/small/tursmall.png",
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnvConWidget(
                  //here
                  f: () {
                    usause();
                  },
                  btwo: isusainuse,
                  shopwidth: shopwidth,
                  b: doyouhaveusa,
                  img: "images/flags/small/usasmall.png",
                ),
              ],
            ),
          ],
        );
      } else if (onskins) {
        return ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnvConWidget(
                  f: () {
                    normaluse();
                  },
                  btwo: ismcinuse,
                  shopwidth: shopwidth,
                  b: doyouhavemc,
                  img: "images/characters/skins/skinnormal/mc.png",
                ),
                EnvConWidget(
                  f: () {
                    enginuse();
                  },
                  btwo: isenginuse,
                  shopwidth: shopwidth,
                  b: doyouhaveeng,
                  img: "images/characters/skins/skinnormal/eng.png",
                ),
                EnvConWidget(
                  f: () {
                    mageuse();
                  },
                  btwo: ismageinuse,
                  shopwidth: shopwidth,
                  b: doyouhavemage,
                  img: "images/characters/skins/skinnormal/mage.png",
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnvConWidget(
                  f: () {
                    medicuse();
                  },
                  btwo: ismedicinuse,
                  shopwidth: shopwidth,
                  b: doyouhavemedic,
                  img: "images/characters/skins/skinnormal/medic.png",
                ),
                EnvConWidget(
                  f: () {
                    armoruse();
                  },
                  btwo: isarmorinuse,
                  shopwidth: shopwidth,
                  b: doyouhavearmor,
                  img: "images/characters/skins/skinnormal/armor.png",
                ),
                EnvConWidget(
                  f: () {
                    pirateuse();
                  },
                  btwo: ispirateinuse,
                  shopwidth: shopwidth,
                  b: doyouhavepirate,
                  img: "images/characters/skins/skinnormal/pirate.png",
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                EnvConWidget(
                  f: () {
                    finaluse();
                  },
                  btwo: isfinalinuse,
                  shopwidth: shopwidth,
                  b: doyouhavefinal,
                  img: "images/characters/skins/skinnormal/final.png",
                ),
              ],
            )
          ],
        );
      } else {
        return ListView(
          children: const [],
        );
      }
    }
  }
}
