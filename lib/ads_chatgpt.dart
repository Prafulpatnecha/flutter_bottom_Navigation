import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the SDK
  MobileAds.instance.initialize().then((InitializationStatus status) {
    print("Google Mobile Ads SDK initialized: ${status.adapterStatuses}");

    // Set up test devices using the RequestConfiguration
    MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: ['a5d416b8-54f1-4b94-8236-10ca1ad1abe1'])
    );

    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    loadBannerAd();
  }

  // Load the Banner Ad
  void loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Test Ad Unit ID
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            _isAdLoaded = true;
          });
          print('Banner Ad Loaded');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Banner Ad failed to load: ${error.message}');
        },
      ),
    );
    _bannerAd.load();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AdMob Banner Test')),
      body: Center(
        child: _isAdLoaded
            ? Container(
          height: 50,
          child: AdWidget(ad: _bannerAd),
        )
            : Text('Ad failed to load'),
      ),
    );
  }
}
