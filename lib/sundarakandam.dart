import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audioplayers/audioplayers.dart';

class SundaraKandam extends StatefulWidget {
  const SundaraKandam({super.key});

  @override
  SundaraKandamState createState() => SundaraKandamState();
}

class SundaraKandamState extends State<SundaraKandam> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return ScreenUtilInit(
        designSize: const Size(320, 470),
        builder: (BuildContext context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'சுந்தர காண்டம் பாராயணம் ',
          home: Scaffold(
            backgroundColor: Colors.blue.shade200,
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
              backgroundColor: const Color.fromRGBO(128, 0, 0, 1),
              elevation: 0.0,
            ),
            body: const _Page(),
          ),
        ),
      );
    });
  }
}

class _Page extends StatefulWidget {
  const _Page();
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<_Page> {
  bool manthiramStarted = false;
  bool manthiramPaused = false;
  int manthiramCount = 0;
  bool firstTime = true;
  late AudioPlayer player = AudioPlayer();

  final controller = PageController(
    initialPage: 0,
  );

  _playManthiram() async {
    if (manthiramStarted == false && manthiramPaused == false) {
      setState(() {
        manthiramStarted = true;
      });
      for (var i = manthiramCount; i <= 107; i++) {
        await player.play(AssetSource('music/hanuman_manthiram.mp3'));
        await Future.delayed(const Duration(milliseconds: 22000), () {
          setState(() {
            player.stop();
            manthiramCount = manthiramCount + 1;
          });
        });
        setState(() {
          manthiramStarted;
          manthiramPaused;
        });

        if (manthiramPaused == true || manthiramCount == 108) {
          await Future.delayed(const Duration(milliseconds: 22000), () {
            setState(() {
              manthiramStarted = false;
            });
          });
          if (manthiramStarted == false) {
            manthiramPaused = false;
            break;
          }
        }
      }
    }
    await Future.delayed(const Duration(milliseconds: 1000), () {
      if (manthiramCount == 108) {
        manthiramCount = 0;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    player.setReleaseMode(ReleaseMode.stop);
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 12.0),
                backgroundColor: const Color.fromRGBO(0, 0, 128, 0.8),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                side: BorderSide(
                  width: 6.0,
                  color: Colors.blue.shade200,
                  style: BorderStyle.solid,
                ),
                elevation: 8,
                shadowColor: Colors.brown.shade400,
                textStyle: TextStyle(
                  fontFamily: 'meera',
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                )),
          ),
        ),
        home: Scaffold(
          backgroundColor: Colors.green.shade50,
          body: Center(
            child: PageView(
              controller: controller,
              onPageChanged: (page) => {},
              pageSnapping: true,
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Flex(
                    direction: orientation == Orientation.landscape
                        ? Axis.vertical
                        : Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        alignment: Alignment.center,
                        child: Text(
                          'கம்பராமாயணத்தில் சுந்தர காண்டம்\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: RichText(
                          text: TextSpan(
                            text:
                                'கம்பராமாயணத்தில் ஐந்தாவது காண்டமான சுந்தர காண்டம் அனுமாரின் அறிவுக் கூர்மையையும், வீரத்தையும், சொல்வன்மையையும், பெருமையையும் விளக்குகிறது.',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: RichText(
                          text: TextSpan(
                            text:
                                'சீதையைத் தேடும் பொருட்டு அங்கதன் (வாலியின் மைந்தன்) தலைமையில் சென்ற வானரக் கூட்டத்திடம் கழுகரசன் சம்பாதி கூறிய அறிவுரையின்படி, அனுமார் வானில் பறந்து, வழியில் பல தடங்கல்களைத் தாண்டி கடலைக் கடந்து இலங்கை சென்றார்.',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade900,
                            ),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: RichText(
                          text: TextSpan(
                            text:
                                'இலங்கையின் அசோகவனத்தில் இராவணனால் சிறை வைக்கப்பட்டிருந்த சீதையை, அனுமார் சிறு குரங்கு வடிவில் சந்தித்து, இராமரின் கணையாழி மோதிரத்தைக் கொடுத்து, தன்னை இராமதூதன் என்று அறிமுகப்படுத்திக் கொண்டார். கடல் கடந்தது பற்றி சீதை வினவ, அனுமான் கடல் கடந்த தன் பேர் உருவைக் காட்டி, பின் எளிய உருவுக்கு மாறினார். சீதை தனது நெற்றிச் சூடாமணி நகையை அடையாளமாக அனுமாரிடம் கொடுத்தார்.',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade900,
                            ),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: RichText(
                          text: TextSpan(
                            text:
                                'பின்னர் அரக்கர்களிடம் வேண்டுமென்றே சிக்கிக் கொண்ட அனுமாரின் வாலில் தீ வைக்கப்பட்டது. அனுமார், வாலில் வைக்கப்பட்ட தீயுடன் இலங்கை நகரைச் சுற்றி வந்து, நகரின் பெரும்பாலான பகுதிகளை எரித்தார். பின்னர் இராமரிடம் சீதை கொடுத்த சூடாமணியை அனுமார் கொடுத்து, சீதையின் செய்தியையும் கூறினார்.',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple.shade900,
                            ),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                        child: RichText(
                          text: TextSpan(
                            text:
                                ' இலங்கை சென்ற இராமர் இராவணனுடன் போரிடும் போது இராமனால் வெட்டப்பட்ட ஒவ்வொரு தலையும் பல தலைகளாக வளர்வதைக் கண்ட இராமர் மனம் வாடி நின்ற போது, அங்கு வந்த அகத்திய மாமுனிவர் சொல்லியபடி ஆதித்ய ஹ்ருதயம் ஸ்லோகங்களை இராமர் முறைப்படி பாராயணம் செய்து சூரிய பகவானின் அருளும் ஆசியும் பெற்று இராவணனை வென்று அன்னை ஜானகியுடன் அயோத்தி சென்று, வசிட்ட மாமுனிவர் பட்டாபிஷேகம் செய்து வைக்க, பல்லாண்டு காலம் நல்லாட்சி புரிந்தார்.\n',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade900,
                            ),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      SizedBox(
                        height: 0.05.sh,
                      )
                    ]),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      alignment: Alignment.center,
                      child: Text(
                        'பாராயணம் செய்யும் முறை\n',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: RichText(
                        text: TextSpan(
                          text:
                              'பூஜை அறையில் இராமர் பட்டாபிஷேகப் படம் (அல்லது இராமர், ஆஞ்சநேயர், நாராயணர் படம்) வைத்து, துளசி சாத்தி, அருகில் (நெய்) விளக்கு ஏற்றி, நைவேத்தியத்திற்குத் தேவையான வெற்றிலை, பாக்கு, வாழைப்பழங்கள் (இவை கிடைக்காதபோது, உலர் பழங்கள் அல்லது நீரில் சிறிது வெல்லம் சேர்த்த பானகம்) வைத்து பாராயணம் செய்பவர் சிறிய பலகை அல்லது சுத்தமான விரிப்பு மேல் அமர்ந்து, அருகில் (கோலமிட்ட) ஒரு மனைப் பலகை ஆசனம் ஆஞ்சநேயருக்காக வைக்க வேண்டும். ராம நாமம் எங்கு ஒலித்தாலும் ஆஞ்சநேயர் அங்கே பிரஸன்னமாவார் என்பது ஐதீகம்.  மேலும்  தீப, தூப பொருள்கள் (சாம்பிராணி / ஊதுவத்தி) மற்றும் மலர்கள் அருகில் வைத்துக் கொள்ளவும்.',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: RichText(
                        text: TextSpan(
                          text:
                              'குறிப்பிட்ட காரியம் நிறைவேற பிரார்த்தனை  செய்பவர்கள் ஆஞ்சநேயருக்கு மிளகு வடை (வெங்காயம் சேர்க்காமல்), வெண்ணைய் படைத்து  வணங்குதல்  மிகவும் சிறப்பு.',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown.shade900,
                          ),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: RichText(
                        text: TextSpan(
                          text:
                              'குளித்து சுத்தமாக பாராயணம் செய்ய சூரியோதயத்திற்கு முன்பும், காலையும், மாலை விளக்கு ஏற்றிய பிறகும் உகந்த நேரம் ஆகும். முதலில் விநாயகரையும், பின்பு குலதெய்வங்களையும் வணங்கி, மலர்கள் சாத்தி, அதன் பிறகு பாராயணம் தொடங்க  வேண்டும்.',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade900,
                          ),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: RichText(
                        text: TextSpan(
                          text:
                              'பாராயணத்தை இராமர் பட்டாபிஷேகப் பாடலுடன் (அரியணை அனுமன் தாங்க ...) நிறைவு செய்ய வேண்டும். இராமருக்கும், நாம் ஆவாதனம் செய்துள்ள ஆஞ்சநேயருக்கும்  தீப, தூபம் காட்டி மலர்கள் வைத்து, மனதை ஒருநிலைப் படுத்தி வணங்க வேண்டும்.',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 0.10.sh,
                    )
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      alignment: Alignment.center,
                      child: Text(
                        'பாராயணம் செய்யும் போது கிடைக்கும் பலன்கள்\n',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: RichText(
                        text: TextSpan(
                          text:
                              'சுந்தர காண்டத்தை தொடர்ந்து பாராயணம் செய்து வந்தால், மன வலிமை உண்டாகும். சுந்தரகாண்டத்தில் காயத்திரி மந்திரத்தின் அளவற்ற சக்தி உள்ளதாகக் கருதப்படுகிறது. சுந்தரகாண்டத்தை ஆத்மார்த்தமாக படித்து வந்தால் எல்லாத் துன்பங்களும் முடிவுக்கு வந்து விடும். சுந்தரகாண்டத்தை நீண்ட நாட்களாக பாராயணம் செய்பவர்களை விட்டு நவக்கிரக தோஷங்கள் முற்றிலும் அகலும். சுந்தரகாண்டத்தை மனம் உருகி படித்தால் பாவங்கள்  தீரும். முடியாத செயல்கள் முடிந்து விடும்.',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: RichText(
                        text: TextSpan(
                          text:
                              'சுந்தரகாண்டத்தை முறைப்படி வாசித்தால் காலதாமதமான திருமணம் விரைவில் கை கூடும். கவலைகள் மறைந்து போகும். சுந்தரகாண்டம் படித்து அனுமனை வழிபட்டு வந்தால் அறிவு, ஆற்றல், புகழ், குறிக்கோளை எட்டும் திறமை, துணிச்சல், ஆரோக்கியம், விழிப்புணர்வு, வாக்கு சாதூரியம் போன்றவற்றைப் பெறலாம். ஏழரை சனி, அஷ்டமத்து சனி திசை நடப்பவர்கள் தினமும் சுந்தரகாண்டம் படித்து வந்தால் துன்பங்களில் இருந்து விடுபடலாம்.',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown.shade900,
                          ),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: RichText(
                        text: TextSpan(
                          text:
                              'ஒரு பெண் கருத்தரித்த நாள் முதல் 9 மாதம் வரை நாள் தவறாமல் சுந்தரகாண்டம் படித்து வந்தால் சுகப் பிரசவம் உண்டாகி குழந்தை ஆரோக்கியத்துடன் பிறக்கும் என்பது ஐதீகம். கர்ப்பிணிகள் குறைந்த பட்சம் 5-வது மாதத்தில் இருந்து சுந்தரகாண்டம் படித்து வந்தால், பிறக்கும் குழந்தை நுண்ணறிவு, மனோவலிமை, புகழ், வீரம், ஆரோக்கியம், ஆன்மிக சிந்தனை உள்ள குழந்தையாக பிறக்கும்.',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    SizedBox(
                      height: 0.17.sh,
                    )
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 0.05.sh,
                      alignment: Alignment.center,
                      child: Text(
                        'ஸ்ரீ ராமஜெயம்',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          height: 0.4.sh,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: const Image(
                            image:
                                AssetImage('assets/images/sundarakandam.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          height: 0.3.sh,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.yellowAccent.shade100,
                              borderRadius: BorderRadius.circular(30.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: RichText(
                                text: TextSpan(
                              text: 'சுந்தரகாண்டம் என்று\n',
                              style: TextStyle(
                                fontFamily: 'meera',
                                fontSize: 16.0.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade900,
                              ),
                              children: const <TextSpan>[
                                TextSpan(
                                  text: '  பெயர் சொல்லுவார்-இதை\n',
                                ),
                                TextSpan(
                                  text: 'சுகம் தரும் சொர்க்கம்\n',
                                ),
                                TextSpan(
                                  text: '  என்று மனதில் கொள்வார்\n',
                                ),
                                TextSpan(
                                  text: 'கண்டேன் சீதையை என்று\n',
                                ),
                                TextSpan(
                                  text: '  காகுத்தனிடம் சொன்ன\n',
                                ),
                                TextSpan(
                                  text: 'கருணை மிகு இராமபக்தன்\n',
                                ),
                                TextSpan(
                                  text: '  ஆஞ்சநேயர் பெருமை இது',
                                ),
                              ],
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 0.10.sh,
                        ),
                      ],
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 0.1.sh,
                      alignment: Alignment.center,
                      child: Text(
                        'கடல் தாவு  படலம்',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.3.sh,
                      child: const Image(
                        image: AssetImage('assets/images/hanuman.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 0.3.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue.shade100,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'அஞ்சனை தனயன்\n',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo.shade900,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text: '  அலைகடல் தாண்டவே\n',
                              ),
                              TextSpan(
                                text: 'ஆயத்தமாகி நின்றார்\n',
                              ),
                              TextSpan(
                                text: '  இராம பாணம் போல்\n',
                              ),
                              TextSpan(
                                text: 'இராட்சசர் மனை நோக்கி\n',
                              ),
                              TextSpan(
                                text: '  இராஜ கம்பீரத்தோடு\n',
                              ),
                              TextSpan(
                                text: 'இராம தூதனும்\n',
                              ),
                              TextSpan(
                                text: '  விரைந்தே சென்றார்',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.10.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 0.1.sh,
                      alignment: Alignment.center,
                      child: Text(
                        'கடல் தாவு  படலம்',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.3.sh,
                      child: const Image(
                        image: AssetImage('assets/images/jambavan.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 0.3.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightGreen.shade100,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: RichText(
                            text: TextSpan(
                          text: 'அங்கதனும், ஜாம்பவானும்\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  அனைத்து வானரர்களும்\n',
                            ),
                            TextSpan(
                              text: 'அன்புடன் விடை\n',
                            ),
                            TextSpan(
                              text: '  கொடுத்து வழியனுப்பினரே\n',
                            ),
                            TextSpan(
                              text: 'வானவர்கள் தானவர்கள்\n',
                            ),
                            TextSpan(
                              text: '  வருணாதி தேவர்கள்\n',
                            ),
                            TextSpan(
                              text: 'வழியெல்லாம் சூழ நின்று\n',
                            ),
                            TextSpan(
                              text: '  பூமாரிப் பொழிந்தனரே',
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 0.10.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 0.05.sh,
                      child: Text(
                        'கடல் தாவு  படலம்',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.3.sh,
                      child: const Image(
                        image: AssetImage('assets/images/mainagaparvatham.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 0.3.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue.shade100,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: RichText(
                            text: TextSpan(
                          text: 'மைநாக பருவதம்\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  மாருதியை உபசரிக்க\n',
                            ),
                            TextSpan(
                              text: 'மகிழ்வுடன் மாருதியும்\n',
                            ),
                            TextSpan(
                              text: '  மைநாகனைத் திருப்தி செய்து\n',
                            ),
                            TextSpan(
                              text: 'சுரசையை வெற்றிகொண்டு,\n',
                            ),
                            TextSpan(
                              text: '  சிம்ஹிகையை வதம் செய்து\n',
                            ),
                            TextSpan(
                              text: 'சாகசமாய் சமுத்திரத்தைத்\n',
                            ),
                            TextSpan(
                              text: '  தாண்டியே  இலங்கை சேர்ந்தார்',
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 0.08.sh,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                controller.animateToPage(18,
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeInCirc);
                              },
                              child: const Text('மைந்நாகன்'),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                controller.animateToPage(19,
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeInCirc);
                              },
                              child: const Text('சுரசை, சிம்ஹிகை'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.10.sh,
                      child: Center(
                        child: Text(
                          'மைந்நாகன், சுரசை, சிம்ஹிகை பற்றிய\nவிவரங்களுக்கு பொத்தான்களை அழுத்தவும்',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 11.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    )
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 0.05.sh,
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: Text(
                        'ஊர் தேடு படலம்,',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.3.sh,
                      child: const Image(
                        image: AssetImage('assets/images/ashokavanam.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 0.3.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightGreen.shade100,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: RichText(
                            text: TextSpan(
                          text: 'இடக்காக பேசியே\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  இலங்கையின் தேவதையை\n',
                            ),
                            TextSpan(
                              text: 'இடக்கையால் தண்டித்தவன்\n',
                            ),
                            TextSpan(
                              text: '  இதயத்தைக்  கலக்கினான்\n',
                            ),
                            TextSpan(
                              text: 'அழகான இலங்கையில்\n',
                            ),
                            TextSpan(
                              text: '  அன்னை ஜானகியை\n',
                            ),
                            TextSpan(
                              text: 'அங்குமிங்கும் தேடியே\n',
                            ),
                            TextSpan(
                              text: '  அசோகவனத்தை அடைந்தார்',
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 0.08.sh,
                      child: Center(
                        child: OutlinedButton(
                          onPressed: () {
                            controller.animateToPage(20,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInCirc);
                          },
                          child: const Text('இலங்கை தேவதை'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.10.sh,
                      child: Center(
                        child: Text(
                          'இலங்கை தேவதை பற்றிய விவரங்களுக்கு\nபொத்தானை அழுத்தவும்',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 11.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    )
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 0.07.sh,
                      child: Column(
                        children: [
                          Text(
                            'காட்சிப் படலம்',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade700,
                            ),
                          ),
                          Text(
                            'உருக் காட்டு படலம் ',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.35.sh,
                      child: const Image(
                        image: AssetImage('assets/images/urukattu.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 0.3.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue.shade100,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: RichText(
                            text: TextSpan(
                          text: 'சிம்சுபா மரத்தடியில்\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  ஸ்ரீராமனைத் தியானம் செய்யும்\n',
                            ),
                            TextSpan(
                              text: 'சீதாப்பிராட்டியைக் கண்டு\n',
                            ),
                            TextSpan(
                              text: '  சித்தம் கலங்கினார்\n',
                            ),
                            TextSpan(
                              text: 'இராவணன் வெகுண்டிட\n',
                            ),
                            TextSpan(
                              text: '  இராட்சசியர் கலங்கிட\n',
                            ),
                            TextSpan(
                              text: 'வைதேகி அரண்டிட\n',
                            ),
                            TextSpan(
                              text: '  வந்தார் துயர் துடைக்க',
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 0.08.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 0.1.sh,
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'சூடாமணிப் படலம்,',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade700,
                            ),
                          ),
                          Text(
                            'பொழில் இறுத்த படலம்,',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade700,
                            ),
                          ),
                          Text(
                            ' கிங்கரர் வதைப் படலம்,',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.3.sh,
                      child: const Image(
                        image: AssetImage('assets/images/kanaiyazhi.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 0.3.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightGreen.shade100,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: RichText(
                            text: TextSpan(
                          text: 'கணையாழி கொடுத்து\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  ஜெயராமன் சரிதம் சொல்லி\n',
                            ),
                            TextSpan(
                              text: 'சூடாமணியைப் பெற்ற\n',
                            ),
                            TextSpan(
                              text: '  சுந்தர ஆஞ்சநேயர்\n',
                            ),
                            TextSpan(
                              text: 'அன்னையின் கண்ணீர் கண்டு\n',
                            ),
                            TextSpan(
                              text: ' அரக்கர் மேல் கோபம் கொண்டு\n',
                            ),
                            TextSpan(
                              text: 'அசோகவனம் அழித்து\n',
                            ),
                            TextSpan(
                              text: '  அனைவரையும் ஒழித்தார்',
                            ),
                          ],
                        )),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 0.1.sh,
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'சம்புமாலி வதைப் படலம்,',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade700,
                            ),
                          ),
                          Text(
                            'பஞ்ச சேனாபதிகள் வதைப் படலம்,',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade700,
                            ),
                          ),
                          Text(
                            'அக்ககுமாரன் வதைப் படலம்',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 0.1.sh,
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'பாசப் படலம்,',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade700,
                            ),
                          ),
                          Text(
                            'பிணிவீட்டுப் படலம்,',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade700,
                            ),
                          ),
                          Text(
                            'இலங்கை எரியூட்டு படலம்',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.3.sh,
                      child: const Image(
                        image: AssetImage('assets/images/fire.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 0.3.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue.shade100,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: RichText(
                            text: TextSpan(
                          text: 'பிரம்மாஸ்திரத்தினால்\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  பிணைத்திட்ட ஆஞ்சநேயர்\n',
                            ),
                            TextSpan(
                              text: 'பட்டாபிராமன் தன்\n',
                            ),
                            TextSpan(
                              text: '  பெருமையை எடுத்துரைக்க\n',
                            ),
                            TextSpan(
                              text: 'வெகுண்ட இலங்கை வேந்தன்\n',
                            ),
                            TextSpan(
                              text: '  வையுங்கள் தீ வாலுக்கென்றான்\n',
                            ),
                            TextSpan(
                              text: 'வைத்த நெருப்பினால்\n',
                            ),
                            TextSpan(
                              text: '  வெந்ததே இலங்கை நகர்',
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 0.10.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 0.1.sh,
                      child: Text(
                        'திருவடி தொழுத படலம்',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.3.sh,
                      child: const Image(
                        image: AssetImage('assets/images/return.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 0.3.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightGreen.shade100,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: RichText(
                            text: TextSpan(
                          text: 'அரக்கனின் அகந்தையை\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  அழித்திட்ட அனுமானும்\n',
                            ),
                            TextSpan(
                              text: 'அன்னை ஜானகியிடம்\n',
                            ),
                            TextSpan(
                              text: '  அனுமதி பெற்றுக் கொண்டார்\n',
                            ),
                            TextSpan(
                              text: 'ஆகாய மார்க்கத்தில்\n',
                            ),
                            TextSpan(
                              text: '  ஆஞ்சநேயர் தாவி வந்தார்\n',
                            ),
                            TextSpan(
                              text: 'அன்னையைக் கண்டுவிட்ட\n',
                            ),
                            TextSpan(
                              text: '  ஆனந்தத்தில் மெய்மறந்தார்',
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 0.10.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 0.1.sh,
                      child: Text(
                        'திருவடி தொழுத படலம்',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.3.sh,
                      child: const Image(
                        image: AssetImage('assets/images/sudamani.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 0.3.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue.shade100,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: RichText(
                            text: TextSpan(
                          text: 'ஆறாத சோகத்தில்\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  ஆழ்ந்திருந்த இராமனிடம்\n',
                            ),
                            TextSpan(
                              text: 'ஆஞ்சநேயர் கைகூப்பிக்\n',
                            ),
                            TextSpan(
                              text: '  கண்டேன் சீதையை என்றார்\n',
                            ),
                            TextSpan(
                              text: 'வைதேகி வாய்மொழியை\n',
                            ),
                            TextSpan(
                              text: '  அடையாளமாய்க் கூறி\n',
                            ),
                            TextSpan(
                              text: 'சொல்லின் செல்வர் ஆஞ்சநேயர்\n',
                            ),
                            TextSpan(
                              text: '  சூடாமணி அளித்தார்',
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 0.10.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 0.1.sh,
                      child: Text(
                        'திருவடி தொழுத படலம்',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.3.sh,
                      child: const Image(
                        image: AssetImage('assets/images/ramarhanuman.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 0.3.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightGreen.shade100,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: RichText(
                            text: TextSpan(
                          text: 'மனம் கனிந்து மாருதியை\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  மார்போடு அணைத்து இராமர்\n',
                            ),
                            TextSpan(
                              text: 'மைதிலியை சிறைமீட்க\n',
                            ),
                            TextSpan(
                              text: '  மறுகணம் சித்தமானார்\n',
                            ),
                            TextSpan(
                              text: 'ஆழ்கடலில் அற்புதமாய்\n',
                            ),
                            TextSpan(
                              text: '  அணைகட்டி படைகள் சூழ\n',
                            ),
                            TextSpan(
                              text: 'அனுமானும் இலக்குவனும்\n',
                            ),
                            TextSpan(
                              text: '  உடன்வரப் புறப்பட்டார்',
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 0.10.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 0.1.sh,
                      child: Text(
                        'திருவடி தொழுத படலம்',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.3.sh,
                      child: const Image(
                        image: AssetImage('assets/images/ramaravanan.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 0.3.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue.shade100,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: RichText(
                            text: TextSpan(
                          text: 'அழித்திட்டான் இராவணனை\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  ஒழித்திட்டான் அதர்மத்தை\n',
                            ),
                            TextSpan(
                              text: 'அன்னை சீதாப்பிராட்டியைக்\n',
                            ),
                            TextSpan(
                              text: '  கண்டு  அடைந்திட்டான்\n',
                            ),
                            TextSpan(
                              text: 'அயோத்தி சென்று இராமர்\n',
                            ),
                            TextSpan(
                              text: '  அகிலம் புகழ ஆட்சி செய்தார்\n',
                            ),
                            TextSpan(
                              text: 'அவனைச் சரணடைந்தோர்க்கு\n',
                            ),
                            TextSpan(
                              text: '  அவனருள் என்றென்றும் உண்டு',
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 0.10.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 0.1.sh,
                      child: Text(
                        'ஸ்ரீ ஆஞ்சநேயா உன்னைப் பணிகின்றோம்',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.3.sh,
                      child: const Image(
                        image: AssetImage('assets/images/karamkuppi.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 0.3.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightGreen.shade100,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: RichText(
                            text: TextSpan(
                          text: 'எங்கெங்கு ரகுநாத கீர்த்தனமோ\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  அங்கெல்லாம் கரம் குவித்து \n',
                            ),
                            TextSpan(
                              text: 'மனம் உருகி நீர் சொரிந்து \n',
                            ),
                            TextSpan(
                              text: '  ஆனந்தத்திலே மூழ்கிக் கேட்கும்\n',
                            ),
                            TextSpan(
                              text: 'பரிபூரண பக்தனே! ஸ்ரீ ஆஞ்சநேயா\n',
                            ),
                            TextSpan(
                              text: '   உன்னைப் பணிகின்றோம்\n',
                            ),
                            TextSpan(
                              text: 'பன்முறை உன்னைப் பணிகின்றோம்\n',
                            ),
                            TextSpan(
                              text: '   பன்முறை உன்னைப் பணிகின்றோம்',
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 0.10.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 0.1.sh,
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                      child: Text(
                        'பட்டாபிஷேகம்',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.33.sh,
                      child: const Image(
                        image: AssetImage('assets/images/pattabishegam.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 0.3.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.yellowAccent.shade100,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                            text: TextSpan(
                          text: 'அரியணை அனுமன் தாங்க,\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: '  அங்கதன் உடைவாள் ஏந்த,\n',
                            ),
                            TextSpan(
                              text: 'பரதன் வெண்குடை கவிக்க,\n',
                            ),
                            TextSpan(
                              text: '  இருவரும் கவரி வீச,\n',
                            ),
                            TextSpan(
                              text: 'விரைசெறி குழலி ஓங்க,\n',
                            ),
                            TextSpan(
                              text: '  வெண்ணெயூர்ச் சடையன் தங்கள்\n',
                            ),
                            TextSpan(
                              text: 'மரபுளோர் கொடுக்க வாங்கி,\n',
                            ),
                            TextSpan(
                              text: '  வசிட்டனே புனைந்தான் மௌலி',
                            ),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 0.12.sh,
                      child: Center(
                        child: OutlinedButton(
                          onPressed: () {
                            controller.animateToPage(21,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInCirc);
                          },
                          child: const Text('அருஞ்சொற்பொருள்'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(),
                      height: 0.04.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.yellowAccent.shade100,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'அனுமன் காயத்ரி மந்திரம்\n',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo.shade900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 0.2.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: const Image(
                        image:
                            AssetImage('assets/images/gayatri_manthiram.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      height: 0.14.sh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.lightGreen.shade100,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: RichText(
                            text: TextSpan(
                          text: 'ஓம்  ஆஞ்சநேயாய  வித்மஹே\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            color: Colors.indigo.shade900,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: 'வாயு  புத்ராய  தீமஹி \n',
                            ),
                            TextSpan(
                              text: 'தந்நோ  ஹனுமத்  ப்ரசோதயாத்',
                            ),
                          ],
                        )),
                      ),
                    ),
                    Text(
                      manthiramPaused
                          ? 'தொடங்கிய மந்திரம் இறுதி வரை ஒலிக்கும்'
                          : 'மந்திரம் 108 முறை தொடர்ந்து ஒலிக்கும்',
                      style: TextStyle(
                        fontFamily: 'meera',
                        fontSize: 10.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          iconSize: 50.0,
                          onPressed: manthiramStarted
                              ? null
                              : () {
                                  _playManthiram();
                                },
                          icon: const Icon(Icons.volume_up),
                        ),
                        SizedBox(
                          child: Text(
                            '$manthiramCount',
                            style: TextStyle(
                              fontFamily: 'arial',
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        IconButton(
                          iconSize: 64.0,
                          onPressed: (!manthiramPaused && !manthiramStarted)
                              ? null
                              : () {
                                  setState(() {
                                    manthiramPaused = true;
                                  });
                                },
                          icon: const Icon(Icons.volume_off),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          manthiramPaused
                              ? 'காத்திருக்கவும்'
                              : 'மந்திரம் தொடங்க',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 10.0.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.blueGrey,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          width: 0.25.sw,
                        ),
                        Text(
                          manthiramPaused ? 'இடை நிறுத்தம்' : 'இடை நிறுத்த',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 10.0.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.blueGrey,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    OutlinedButton(
                      onPressed: () {
                        controller.animateToPage(26,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInCirc);
                      },
                      child: const Text(
                        'பதினாறு வார்த்தைகளில் இராமாயணம்',
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        controller.animateToPage(22,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInCirc);
                      },
                      child: const Text(
                        'இராமாயண பாத்திரங்களின் பெயர்கள்',
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        SystemChannels.platform
                            .invokeMapMethod('SystemNavigator.pop');
                      },
                      child: const Text(
                        'சுந்தர காண்டம் நிறைவு',
                        style: TextStyle(
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 0.04.sh,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'அனுமான் செல்லும் வழியில் குறுக்கே எழுந்த மைந்நாக பருவதம் (மலை)',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                            text:
                                'அனுமான் இளைப்பாறிச் செல்ல வேண்டும் என்ற எண்ணத்தில், கடலரசன் மைந்நாக மலையைக் கடலிலிருந்து மேலே வரச் சொல்ல, அது மேலே வந்தது. தன் வழியில் குறுக்கிட்ட மலையை அனுமான் தன் காலால் உந்தி கடலுக்கு அடியில் மூழ்கும்படி செய்தார்.\n\n',
                            style: TextStyle(
                              fontFamily: 'meera',
                              fontSize: 11.0.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    'மைந்நாகம் சிறு மானிட உருவம் எடுத்து பருவதத்தின் மேலே நின்றுகொண்டு, அனுமானை வணங்கி பின்வருமாறு கூறியது. முன்னொரு காலத்தில் மலைகளுக்குச் சிறகுகள் இருந்தன. மலைகள் பறப்பது தேவர்களுக்கு இடைஞ்சலாக இருந்ததால், இந்திரன் தன் வஜ்ஜிராயுதத்தால் மலைகளின் சிறகுகளை வெட்டிய போது, அன்புள்ளம் கொண்ட தங்கள் தந்தை வாயு பகவான் என் மீது இரக்கப்பட்டு என்னைக் காப்பாற்றி கடலுக்கடியில் ஒளித்து வைத்தார். தாங்கள் இளைப்பாறிச் செல்ல வேண்டும் என்று கடலரசன் விரும்பியதால், நான் கடலுக்கு மேலே வந்தேன்.\n\n',
                                style: TextStyle(
                                  fontFamily: 'meera',
                                  fontSize: 11.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown.shade900,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'மைந்நாகனின் அன்பான உபசரிப்பில் மகிழ்ந்த அனுமான், தன் தலைவன் இராமபிரானின் கருணையினால் தனக்கு களைப்பு ஏற்படாது என்றும், தனக்குள்ள கடமையை விளக்கி, திருப்பி வரும்போது தங்கி மைந்நாகனின் உபசரிப்பை ஏற்பதாக உறுதி அளித்தார். மைந்நாக பருவதத்தின் செயலால் மகிழ்ச்சி அடைந்த இந்திரன், மைந்நாகனை கடலுக்கு மேலேயே இருக்கும்படி வாழ்த்தினார்.\n\n',
                                style: TextStyle(
                                  fontFamily: 'meera',
                                  fontSize: 11.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        controller.animateToPage(6,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInCirc);
                      },
                      child: const Text('பாராயணம் தொடர...'),
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 0.005.sh,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'சுரசை, சிம்ஹிகை (அங்காரதாரை) தாக்குதல்கள்',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          text:
                              'அனுமானின் ஆற்றலையும், வீரத்தையும் சோதிக்க எண்ணிய தேவர்கள், பிரஜாபதி தட்சனின் மகளும், பாம்பினங்களின் தாயான சுரசையை அரக்கி வடிவில் அனுப்பினர். அவள் அனுமான் முன் கோரமான இராட்சச உருவில் தோன்றி, எனக்கு நீ உணவாக வேண்டும் என்று கர்ஜித்தாள். \'நான் உன் வாய்க்குள் செல்வேன், உன்னால் முடிந்தால் என்னை உன் உணவாக்கிக்கொள்\' என்று அனுமான் சொல்ல, சுரசையும் சம்மதித்து தன் வாயை அகலத்  திறந்தாள். அனுமானும் உடனே மிகப் பெரிய உருவம் எடுத்தார். இன்னும் பெரிதாக உருவம் எடுக்க எடுக்க சுரசையும் தன் வாயை அதற்கேற்றாற் போல பெரிதாக்கினாள். ஒரு நொடியில் அனுமான் தன் உருவத்தைக் கட்டைவிரல் அளவிற்கு ஆக்கி அவள் வாயினுள் புகுந்து வெளியே வந்தார்.\n\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 11.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  'சிம்ஹிகை ஒரு இராட்சசி. ஒருவரின் நிழலைப் பற்றி இழுக்கும் ஆற்றலும், ஒரு காதம் (10 மைல்) தூரத்தில் உள்ள பொருளையும் பார்க்கும் வல்லமையும் பெற்றவள். அவள் கடலுக்கு மேலே எழுந்து, அனுமான் நிழலைப் பிடித்து இழுத்ததால் அவரால் தொடர்ந்து பறக்க முடியவில்லை. உடனே அவர், அவள் வாயினுள் சிறிய உருவில் புகுந்து பின் பெரிய உருவம் எடுத்து அவள் குடலைக் உருவி அவளைக் கொன்றுவிட்டு மேலே பறந்தார்.\n\n',
                              style: TextStyle(
                                color: Colors.brown.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        controller.animateToPage(6,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInCirc);
                      },
                      child: const Text('பாராயணம் தொடர...'),
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 0.005.sh,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'அனுமான் இலங்கை தேவதையின் இதயத்தைக் கலக்கினார்',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          text:
                              'அனுமான் அரக்கர்களிடம் போரிட்டால் நேரம் வீணாகும் என்று எண்ணி, மதில்கள், மரங்கள் மீது தாவி உள்ளே நுழைந்தார். அப்போது நான்கு முகங்களும், எட்டுக் கரங்களும், வானை முட்டும் நெடிய உருவமும் கொண்ட இலங்காதேவி அனுமானை இடைமறித்தாள்.\n\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 11.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text:
                                    '\'நான் இந்த ஊருக்குள் போகாமல் திரும்பிப் போகமாட்டேன்\' என்று இடக்காக கூறிய அனுமானின் வார்த்தைகளால் கடும் கோபம் கொண்ட இலங்காதேவி அனுமான் மீது பற்பல ஆயுதங்களை ஏவினாள். எல்லாவற்றையும் தூள்தூளாக்கிய அனுமான், இறுதியாக தன் இடக்கையால் தாக்கி, இலங்காதேவியைக்  கீழே தள்ளினார். கீழே விழுந்த இலங்காதேவி, நினவு திருப்பியபின் அழகிய பெண்ணாக மாறியிருந்தாள். பின் இதயம் கலங்கினாள்.\n\n',
                                style: TextStyle(
                                  color: Colors.brown.shade900,
                                )),
                            TextSpan(
                                text:
                                    'அனுமானிடம் தன் வரலாற்றைக்க கூறினாள். இந்த இலங்கை மூதூரைக் காவல் புரியும் தொழிலை நான் எத்துணை காலம் செய்ய வேண்டும் என்று பிரமனிடம் கேட்டேன். அதற்கு அவர் வலிமை மிக்க குரங்கு ஒன்று உன்னைத் தன் கையால் பலமாகக் குத்துகிறதோ, அன்றோடு உன் பணி முடியும். அதன் பிறகு அந்த இலங்கை நகரம் அழிந்து போகும் என்று எனக்குச் சொன்னார். தன் பணி முடிந்து விட்டது என்றும் அனுமான் தாராளமாக ஊருக்குள் செல்லலாம் என்று கூறி வணங்கி வானுலகம் சென்றாள்.\n\n',
                                style: TextStyle(
                                  color: Colors.blue.shade900,
                                )),
                          ],
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        controller.animateToPage(7,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInCirc);
                      },
                      child: const Text('பாராயணம் தொடர...'),
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        'அனுமன் அரியணை தாங்க.. \nபாடலின் அருஞ்சொற்பொருள்\n\n',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          text: 'தாங்க - ',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade900,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'காத்து நிற்க\n',
                              style: TextStyle(
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'கவிக்க (நிழற்ற)- ',
                              style: TextStyle(
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'நிழல் கொடுக்கும்படி பிடிக்க\n',
                              style: TextStyle(
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'இருவரும் -  ',
                              style: TextStyle(
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'இலக்குவ சத்துருக்கர்\n',
                              style: TextStyle(
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'விரைசெறி  குழலி - ',
                              style: TextStyle(
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'மணம் கமழ்கிற கூந்தலை உடைய பிராட்டி\n',
                              style: TextStyle(
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'ஓங்க - ',
                              style: TextStyle(
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'பெருமிதமாய் விளங்க\n',
                              style: TextStyle(
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'வெண்ணெயூர்ச் சடையன் தங்கள் மரபுளோர் கொடுக்க - ',
                              style: TextStyle(
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'திருவெண்ணெய் நல்லூர்ச் சடையப்ப வள்ளல் கால் வழியின் முன்னோராக உள்ளோர் (மகுடத்தை) எடுத்துக் கொடுக்க\n',
                              style: TextStyle(
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'வாங்கி -  ',
                              style: TextStyle(
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'பெற்றுக்கொண்டு\n',
                              style: TextStyle(
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'வசிட்டனே - ',
                              style: TextStyle(
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'முன்னர் வசிஷ்டர் திட்டமிட்ட பட்டாபிஷேகம் நிறைவேறாது போக, இந்த முறை வசிட்டனே\n',
                              style: TextStyle(
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'புனைந்தான் - ',
                              style: TextStyle(
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'சூட்டினான்\n',
                              style: TextStyle(
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'மௌலி - ',
                              style: TextStyle(
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'மகுடம்.\n',
                              style: TextStyle(
                                fontFamily: 'meera',
                                fontSize: 12.0.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        controller.animateToPage(16,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInCirc);
                      },
                      child: const Text('பாராயணம் தொடர...'),
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'இராமாயண பாத்திரங்களின் பெயர்கள்',
                        style: TextStyle(
                          fontFamily: 'meera',
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                              text: '1. அகல்யை: ',
                              style: TextStyle(
                                fontFamily: 'meera',
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade900,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      'இராமரின் அருளால் சாபம் நீங்கப்பெற்றவள் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '2. அகத்தியர்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'இராமனுக்குப் போர்க்களத்தில் ஆதித்ய ஹ்ருதயம் உபதேசித்த மாமுனிவர் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '3. அகம்பனன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'இராவணனிடம் இராமனைப்பற்றி கோள் சொன்னவன். இராமனின் அம்புக்கு தப்பிப்பிழைத்த அதிசய இராட்சஷன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '4. அங்கதன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'வாலி, தாரையின் மகன். கிஷ்கிந்தையின் இளவரசன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '5. அத்திரி: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'அனுசூயா என்ற பத்தினியின் கணவர். இராம தரிசனம் பெற்றவர் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '6. அட்சயகுமாரன் (அக்ககுமாரன்), இந்திரஜித் (மேகநாதன்): ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'ராவணனின் மகன்கள். அட்சயகுமாரன் அனுமானாலும் (அக்ககுமாரன் வதைப் படலம்), இந்திரஜித் லட்சுமணனாலும் அழிந்தவர்கள். ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '7. கரன் & தூஷணன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'ராவணனின் தம்பிகள், இராமனின் கையால் அழிந்தவர்கள். ஜனஸ்தானம் என்ற இடத்திற்கு அதிபதிகள் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '8. கபந்தன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'தலையும் காலும் இல்லாத அரக்கன். இராமனால் வதைக்கப்பட்டவன். கந்தர்வ வடிவம் பெற்று இராமர்  லட்சமணர்கள் கிஷ்கிந்தை செல்ல வழி காட்டியவன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '9. குகன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'வேடர் தலைவன், படகோட்டி, இராமரால், சகோதரனாக ஏற்றுக் கொள்ள‍ப்பட்ட‍வன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '10. கும்பகர்ணன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'ராவணனின் தம்பி, ஆறுமாதங்கள் சாப்பிட்டும், மீதமுள்ள‍ ஆறுமாதங்கள் பெரும் தூக்கம் தூங்கியே பொழுதை கழிப்பவன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '11. கும்பன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'கும்பகர்ணனின் மகன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '12. குசத்வஜன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'ஜனகரின் தம்பி, மாண்டவி, சுருதகீர்த்தி ஆகியோரின் தந்தை. பரத சத்ருக்கனின் மாமனார் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '13. கவுசல்யா, கைகேயி, சுமித்திரை: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'தசரதரின் பட்டத்தரசியர்  ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '14. சுநைனா: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'ஜனகரின் மனைவி, சீதையின் தாய் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '15. கவுதமர்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'அகல்யையின் கணவர், முனிவர் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                              ])),
                    ),
                    SizedBox(
                      height: 0.005.sh,
                    )
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                              text: '16. சதானந்தர்: ',
                              style: TextStyle(
                                fontFamily: 'meera',
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade900,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      'அகல்யை, கவுதமரின் மகன். சீதையின் திருமணத்திற்கு வந்த புரோகிதர் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '17. சம்பராசுரன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'இவனுக்கும், தேவர்களுக்கும் நடந்த போரில் தசரதர் தேவர்களுக்கு உதவினார் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '18. சபரி: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'மதங்க முனிவரின் மாணவி, இராமனை தரிசித்தவள் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '19. சதபலி: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'வடக்கு திசையில் சீதையை தேடச் சென்றவன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '20. சம்பாதி: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'கழுகரசன் ஜடாயுவின் அண்ணன், சீதையைக் காண அங்கதனின் படைக்கு உதவியவன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '21. சீதா: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'இராமனின் மனைவி, ஜானகி, வைதேகி, ஜனகநந்தினி, ஜனககுமாரி, மைதிலி ஆகிய பெயர்களும் இவளுக்கு உண்டு ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '22. சுமந்திரர்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'தசரதரின் மந்திரி, தேரோட்டி ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '23. சுக்ரீவன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'கிஷ்கிந்தையின் மன்னன், வாலியின் தம்பி, சூரியபகவானின் அருளால் பிறந்தவன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '24. சுஷேணன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'வாலியின் மாமனார், வானர மருத்துவன், மேற்கு திசையில் சீதையை தேடச் சென்றவன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '25. சூர்ப்பணகை: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'ராவணனின் தங்கை, கணவனை இழந்தவள் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '26. தசரதர்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'இராமனின் தந்தை ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '27. ததிமுகன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'சுக்ரீவனின் சித்தப்பா, மதுவனம் என்று பகுதியின் பாதுகாவலர் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '28. தாடகை: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'காட்டில் வசித்த அரக்கி, இராமனால் கொல்லப்பட்டவள் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '29. தாரை: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'வாலியின் மனைவி, அங்கதனின் தாய். அறிவில் சிறந்த வானர ராணி ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '30. தான்யமாலினி: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'ராவணனின் இளைய மனைவி ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '31. திரிசடை: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'அசோக வனத்தில் அரக்கிகளுள் நல்லவள், சீதைக்கு நம்பிக்கை ஊட்டியவள் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '32. திரிசிரஸ்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'ராவணனின் தம்பியான கரனின் சேனாதிபதி ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '33. நளன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'பொறியியல் அறிந்த வானரவீரன், விஸ்வகர்மாவின்மகன், கடலின்மீது இலங்கைக்கு பாலம் கட்டியவன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                              ])),
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                              text: '34. நாரதர்: ',
                              style: TextStyle(
                                fontFamily: 'meera',
                                fontSize: 14.0.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo.shade900,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      'பிரம்மாவின் மனத்தில் பிறந்தவர், கலக முனிவர் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '35. நிகும்பன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'கும்பகர்ணனின் மகன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '36. நீலன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'வானர வீரன் நளனின் நண்பன், வானர சேனாதிபதி, அக்னி தேவனின் அருளால் பிறந்தவன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '37. பரசுராமர்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'விஷ்ணுவின் அவதாரம், ஜமத்கனியின் மகன், இராமனுடன் போரிட்டவர் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '38. பரத்வாஜர்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'பிராயாகை அருகே ஆசிரமம் அமைத்திருந்த முனிவர் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '39. பரதன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'கைகேயியின் மகன், இராமனின் தம்பி ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '40. மந்தரை: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'கைகேயியுடன் கேகய நாட்டிலிருந்து அயோத்திக்கு வந்த வேலைக்காரி, கூனி என்றும் சொல்வர் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '41. மதங்கர்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'தவ முனிவர் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '42. மண்டோதரி: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'தேவலோக சிற்பியான மயனின் மகள், இராவணனின் பட்டத்தரசி, இந்திரஜித்தின் தாய்  ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '43. மாரீசன் & சுபாகு: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'தாடகையின் மகன்கள். இராமனால் வதம் செய்யப்பட்டவர்கள், மாரீசன் மாய மானாக வந்தவன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '44. மால்யவான்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'ராவணனின் தாய்வழிப் பாட்டன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '45. மாதலி: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'இந்திரனின் தேரோட்டி  ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '46. யுதாஜித்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'கைகேயியின் தம்பி, பரதனின் தாய்மாமன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '47. இராவணன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'மிச்ரவா என்பரின் மகன், குபேரனின் தம்பி, புலஸ்திய முனிவரின் பேரன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '48. இராமன்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'இராமாயண கதாநாயகன் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '49. ரிஷ்யசிருங்கர்:  ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'புத்திரகாமேஷ்டி செய்த முனிவர் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '50. ருமை: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'சுக்ரீவனின் மனைவி, வாலியால் கவரப்பட்டவள் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '51. லங்காதேவி: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'இலங்கையின் காவல் தெய்வம்  ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text: '52. வசிஷ்டர்: ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'தசரதனின் குலகுரு, அருந்ததியின் கணவர் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '53. மார்க்கண்டேயர், மவுத்கல்யர், வாமதேவர், காஷ்யபர், கார்த்தியாயனர், கவுதமர், ஜாபாலி  – ',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                    color: Colors.indigo.shade900,
                                  ),
                                ),
                                TextSpan(
                                  text: 'தசரதரின் மற்ற குருமார்கள் ',
                                  style: TextStyle(
                                    fontSize: 11.0.sp,
                                    color: Colors.blue.shade800,
                                  ),
                                ),
                              ])),
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          text: '54. வருணன்: ',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade900,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'கடலரசன் ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '55. வால்மீகி: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'இராமாயணத்தை எழுதியவர். இரத்னாகரன் என்பது இயற்பெயர், கொள்ளைக்காரனாக இருந்தவர், இராமனின் மகன் குசனுக்க இராமாயணம் போதித்தவர், சீதைக்கு அடைக்கலம் அளித்தவர் ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '56. வாலி: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'இந்திரனின் அருளால் பிறந்த வானர வேந்தன் ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '57. விஸ்வாமித்ரர்: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'இராமனுக்கு அஸ்திரவித்தை போதித்தவர், சீதா-ராமன் திருமணத்திற்கு காரணமானவர் ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '58. விராதன்: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'தண்டகவனத்தில் வசித்த அரக்கன், இராமனால் சாபம் தீர்ந்தவன் ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '59. விபீஷணன்: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'ராவணனின் தம்பி, இராமனிடம் அடைக்கலம் அடைந்தவன் ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '60. வினதன்: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'கிழக்குத் திசையில் சீதையை தேடச் சென்றவன் ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '61. ஜடாயு: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'கழுகரசன் சம்பாதியின் தம்பி, தசரதனின் தோழன், சீதைக்காக இராவணனுடன் போராடி உயிர்நீத்தவன் ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '62. ஜனகர்: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'சீதை, ஊர்மிளாவின் தந்தை ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '63. ஊர்மிளா: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'லட்சுமணனின் மனைவி ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '64. ஜாம்பவான்: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'கரடி வேந்தர், பிரம்மாவின் அருள்பெற்று பிறந்தவர் ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '65. அனுமான்: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'அஞ்சனை, கேசரி ஆகியோருக்கு வாயு பகவானின் அருளால் பிறந்தவன், ஆஞ்ச நேயன், மாருதி ஆகியவை வேறு பெயர்கள் ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '66. ஸ்வயம்பிரபை: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'குகையில் வாழ்ந்த தபஸ்வினி, குரங்குப் படையினருக்கு உணவிட்டவள் ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '67. மாண்டவி: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'பரதனின் மனைவி ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '68. சுருதகீர்த்தி: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text: 'சத்ருக்கனனின் மனைவி ',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            TextSpan(
                              text: '69. கம்பர்: ',
                              style: TextStyle(
                                fontSize: 14.0.sp,
                                color: Colors.indigo.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'வால்மீகி எழுதிய இராமாயணத்தை தமிழில் எழுதியவர்\n',
                              style: TextStyle(
                                fontSize: 11.0.sp,
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        controller.animateToPage(26,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInCirc);
                      },
                      child: const Text('பதினாறு வார்த்தைகளில் இராமாயணம்'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        SystemChannels.platform
                            .invokeMapMethod('SystemNavigator.pop');
                      },
                      child: const Text('சுந்தர காண்டம் நிறைவு',
                          style: TextStyle(
                            color: Colors.yellow,
                          )),
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                  ],
                ),
                Flex(
                  direction: orientation == Orientation.landscape
                      ? Axis.vertical
                      : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 0.005.sh,
                    ),
                    Text(
                      'பதினாறு வார்த்தைகளில் இராமாயணம்',
                      style: TextStyle(
                        fontFamily: 'meera',
                        fontSize: 13.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo.shade900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          text:
                              'பிறந்தார், வளர்ந்தார், கற்றார், பெற்றார், மணந்தார், சிறந்தார், துறந்தார், நெகிழ்ந்தார், இழந்தார், அலைந்தார், அழித்தார், செழித்தார், துறந்தார், துவண்டார், ஆண்டார், மீண்டார்.\n\n',
                          style: TextStyle(
                            fontFamily: 'meera',
                            fontSize: 11.0.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromRGBO(128, 0, 0, 1.0),
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '1.பிறந்தார்: ஸ்ரீராமர், தசரதரின் ஏக்கத்தைப் போக்கப் பிறந்தார்.\n',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '2.வளர்ந்தார்: தசரதர், கௌசல்யை, சுமித்திரை, கைகேயி ஆகியோர் அன்பிலே வளர்ந்தார்.\n',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '3.கற்றார்: வசிஷ்டரிடம் சகல வேதங்கள், ஞானங்கள், கலைகளை முறையாகக் கற்றார்.\n',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '4.பெற்றார்: வசிஷ்டரிடம் கற்ற துனுர்வேதத்தைக் கொண்டு விஸ்வாமித்ரர் யாகம் காத்து பல திவ்ய அஸ்திரங்களைப் பெற்றார்.\n',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '5.மணந்தார்: ஜனகபுரியில் சிவனாரின் வில்லை உடைத்து மண்ணின் மகளாம் சீதையை மணந்தார்.\n',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '6.சிறந்தார்: அயோத்தி மக்கள் மற்றும் கோசல தேசத்தினர் அனைவர் மனதிலும்  இடம் பிடித்துச் சிறந்தார்.\n',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '7.துறந்தார்: கைகேயியின் சொல் ஏற்று தனக்காக அறிவிக்கப்பட்ட ராஜ்ஜியத்தைத் துறந்தார்.\n',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '8.நெகிழ்ந்தார்: அயோத்தி நகர் மக்களின் அன்பிலும், குகனார் நட்பிலும், பரத்வாஜர் பாசத்திலும், பரதனின் அப்பழுக்கற்ற விசுவாசத்திலும், ஆஞ்சனேயரின் சேவையிலும் நெகிழ்ந்தார்.\n',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '9.இழந்தார் : மாய மானால் அன்னை சீதையை இழந்தார்.\n',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '10.அலைந்தார்: அன்னை சீதையைத் தேடி அலைந்தார்.\n',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '11.அழித்தார்: சீதையை மீட்டு, இலங்கையை அழித்தார்.\n',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '12.செழித்தார்: சீதையை மீட்டும், ராஜ்ஜிய பரிபாலனத்தை மீண்டும் ஏற்றும் செழித்தார்.\n',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '13.துறந்தார்: மக்களின் குழப்பத்தைத் தீர்க்க அன்னை சீதையை மீண்டும் துறந்தார்.\n',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '14.துவண்டார்: அன்னை சீதையைப் பிரிந்து துவண்டார்.\n',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.red.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '15.ஆண்டார்: மக்களுக்கு நல்லாட்சி தந்து அவர்களை ஆண்டார்.\n',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '16.மீண்டார்: பதினோறாயிர ஆண்டு நல்லாட்சிக்குப் பின், தம்  நாட்டு மக்களோடு வைகுண்டம் மீண்டார்.',
                              style: TextStyle(
                                fontSize: 10.0.sp,
                                color: Colors.red.shade900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        controller.animateToPage(22,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInCirc);
                      },
                      child: const Text('இராமாயண பாத்திரங்களின் பெயர்கள்'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        SystemChannels.platform
                            .invokeMapMethod('SystemNavigator.pop');
                      },
                      child: const Text('சுந்தர காண்டம் நிறைவு',
                          style: TextStyle(
                            color: Colors.yellowAccent,
                          )),
                    ),
                    SizedBox(
                      height: 0.03.sh,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
