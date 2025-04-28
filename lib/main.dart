import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_update/in_app_update.dart';
import 'sundarakandam.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool _singaporeHanuman = false;
  bool _vada = false;
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;

  void checkForUpdate() async {
    AppUpdateInfo updateInfo = await InAppUpdate.checkForUpdate();
    if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      InAppUpdate.performImmediateUpdate();
    }
  }

  void _hanuman() {
    if (_singaporeHanuman == false) {
      Future.delayed(const Duration(milliseconds: 40), () {
        setState(() {
          _singaporeHanuman = true;
        });
      });
    }
  }

  void _vadamalai() {
    if (_vada == false) {
      Future.delayed(const Duration(milliseconds: 4500), () {
        setState(() {
          _vada = true;
        });
      });
    }
  }

  void _loadBannerAd() async {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-7346088169082906/1693989499',
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void initState() {
    checkForUpdate();
    _hanuman();
    _vadamalai();
    super.initState();
    _loadBannerAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(320, 470),
      builder: (BuildContext context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'சுந்தர காண்டம் பாராயணம்',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'meera',
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            toolbarHeight: 60,
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 66, 32, 235),
            elevation: 0.0,
          ),
          backgroundColor: Colors.lightBlueAccent,
          body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              AnimatedContainer(
                height: _singaporeHanuman ? 0.6.sh : 0.0,
                duration: const Duration(milliseconds: 4000),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/sundarakandam_open_image.webp"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              AnimatedOpacity(
                opacity: _vada ? 1.0 : 0.0,
                duration: const Duration(
                  milliseconds: 1000,
                ),
                curve: Curves.fastLinearToSlowEaseIn,
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const SundaraKandam()),
                      );
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 66, 32, 235),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0)),
                        elevation: 3,
                        textStyle: TextStyle(
                          fontFamily: 'meera',
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        )),
                    child: const Text('பாராயணம் தொடங்க'),
                  ),
                ),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              Container(
                child: (_isAdLoaded && _bannerAd != null)
                    ? Container(
                        alignment: Alignment.center,
                        height: _bannerAd!.size.height.toDouble(),
                        width: _bannerAd!.size.width.toDouble(),
                        child: AdWidget(ad: _bannerAd!),
                      )
                    : Container(),
              ),
              SizedBox(
                height: 0.03.sh,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
