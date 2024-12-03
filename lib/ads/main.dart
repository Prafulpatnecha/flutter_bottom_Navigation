import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the Google Mobile Ads SDK
  MobileAds.instance.initialize();
  // Update request configuration (use your own testDeviceIds if necessary)
  MobileAds.instance.updateRequestConfiguration(
    RequestConfiguration(
      testDeviceIds: ['a5d416b854f14b94823610ca1ad1abe1'.toUpperCase()],
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InlineAdaptiveExample(),
    );
  }
}

class InlineAdaptiveExample extends StatefulWidget {
  @override
  _InlineAdaptiveExampleState createState() => _InlineAdaptiveExampleState();
}

class _InlineAdaptiveExampleState extends State<InlineAdaptiveExample> {
  static const _insets = 16.0;
  AdManagerBannerAd? _inlineAdaptiveAd;
  bool _isLoaded = false;
  AdSize? _adSize;
  late Orientation _currentOrientation;

  double get _adWidth => MediaQuery.of(context).size.width - (2 * _insets);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentOrientation = MediaQuery.of(context).orientation;
    _loadAd();
  }

  // Load the banner ad
  void _loadAd() async {
    // Dispose previous ad to free resources
    await _inlineAdaptiveAd?.dispose();
    setState(() {
      _inlineAdaptiveAd = null;
      _isLoaded = false;
    });

    // Get an inline adaptive size based on the screen width
    AdSize size = AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
      _adWidth.truncate(),
    );

    // Create the banner ad with the appropriate size
    _inlineAdaptiveAd = AdManagerBannerAd(
      // Replace with your valid Ad Unit ID
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // Use the AdMob test ad unit for testing
      sizes: [AdSize(width: size.width, height: size.height)],
      request: AdManagerAdRequest(),
      listener: AdManagerBannerAdListener(
        onAdLoaded: (Ad ad) async {
          print('Inline adaptive banner loaded: ${ad.responseInfo}');
          // Get platform-specific ad size after loading
          AdManagerBannerAd bannerAd = ad as AdManagerBannerAd;
          final AdSize? size = await bannerAd.getPlatformAdSize();
          if (size == null) {
            print('Error: getPlatformAdSize() returned null for $bannerAd');
            return;
          }
          setState(() {
            _inlineAdaptiveAd = bannerAd;
            _isLoaded = true;
            _adSize = size;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Inline adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    await _inlineAdaptiveAd!.load();
  }

  // Get the ad widget if loaded, otherwise reload when orientation changes
  Widget _getAdWidget() {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (_currentOrientation == orientation &&
            _inlineAdaptiveAd != null &&
            _isLoaded &&
            _adSize != null) {
          return Align(
            child: Container(
              color: Colors.blue.withOpacity(0.5),
              width: _adWidth,
              height: _adSize!.height.toDouble(),
              child: AdWidget(
                ad: _inlineAdaptiveAd!,
              ),
            ),
          );
        }
        if (_currentOrientation != orientation) {
          _currentOrientation = orientation;
          _loadAd();
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Inline adaptive banner example'),
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _insets),
        child: ListView.separated(
          itemCount: 20,
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              height: 40,
            );
          },
          itemBuilder: (BuildContext context, int index) {
            if (index == 1) {
              return _getAdWidget();
            }
            return _getAdWidget();
            //   Text(
            //   'Placeholder text $index',
            //   style: TextStyle(fontSize: 24),
            // );
          },
        ),
      ),
    ),
  );

  @override
  void dispose() {
    super.dispose();
    _inlineAdaptiveAd?.dispose();
  }
}

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// void main()
// {
//   WidgetsFlutterBinding.ensureInitialized();
//   // MobileAds.instance.initialize();
//
//   MobileAds.instance.updateRequestConfiguration(
//       RequestConfiguration(testDeviceIds: ['50bdc4e99d004332a09e03b092032d87'.toUpperCase()]));
//   print('50bdc4e99d004332a09e03b092032d87'.toUpperCase());
//   // void loadBanner() {
//   //
//   //   final adUnitId = '/21775744923/example/adaptive-banner';
//   //   final bannerAd = AdManagerBannerAd(
//   //     adUnitId: adUnitId,
//   //     request: AdManagerAdRequest(),
//   //     sizes: [AdSize.banner], listener: AdManagerBannerAdListener(),
//   //   );
//   //   bannerAd.load();
//   //
//   // }
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   // dynamic size=0;
//
//   // @override
//   // Future<void> initState() async {
//   //   // TODO: implement initState
//   //   super.initState();
//   //    // size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
//   //    //    MediaQuery.sizeOf(context).width.truncate());
//   // }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//             home: InlineAdaptiveExample(),
//       // home: Scaffold(
//       //   body: Column(
//       //     children: [
//       //     ],
//       //   ),
//       // ),
//     );
//
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
// // import 'package:flutter/material.dart';
// // import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// /// This example demonstrates inline adaptive banner ads.
// ///
// /// Loads and shows an inline adaptive banner ad in a scrolling view,
// /// and reloads the ad when the orientation changes.
// class InlineAdaptiveExample extends StatefulWidget {
//   @override
//   _InlineAdaptiveExampleState createState() => _InlineAdaptiveExampleState();
// }
//
// class _InlineAdaptiveExampleState extends State<InlineAdaptiveExample> {
//   static const _insets = 16.0;
//   AdManagerBannerAd? _inlineAdaptiveAd;
//   bool _isLoaded = false;
//   AdSize? _adSize;
//   late Orientation _currentOrientation;
//
//   double get _adWidth => MediaQuery.of(context).size.width - (2 * _insets);
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _currentOrientation = MediaQuery.of(context).orientation;
//     _loadAd();
//   }
//
//   void _loadAd() async {
//     await _inlineAdaptiveAd?.dispose();
//     setState(() {
//       _inlineAdaptiveAd = null;
//       _isLoaded = false;
//     });
//
//     // Get an inline adaptive size for the current orientation.
//     AdSize size = AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
//         _adWidth.truncate());
//
//     _inlineAdaptiveAd = AdManagerBannerAd(
//       // TODO: replace with your own ad unit.
//       adUnitId: 'ca-app-pub-2568606411679432/9171074781',
//       sizes: [
//         AdSize(width: size.width, height: size.height)
//       ],
//       request: AdManagerAdRequest(),
//       listener: AdManagerBannerAdListener(
//         onAdLoaded: (Ad ad) async {
//           print('Inline adaptive banner loaded: ${ad.responseInfo}');
//
//           // After the ad is loaded, get the platform ad size and use it to
//           // update the height of the container. This is necessary because the
//           // height can change after the ad is loaded.
//           AdManagerBannerAd bannerAd = (ad as AdManagerBannerAd);
//           final AdSize? size = await bannerAd.getPlatformAdSize();
//           if (size == null) {
//             print('Error: getPlatformAdSize() returned null for $bannerAd');
//             return;
//           }
//
//           setState(() {
//             _inlineAdaptiveAd = bannerAd;
//             _isLoaded = true;
//             _adSize = size;
//           });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('Inline adaptive banner failedToLoad: $error');
//           ad.dispose();
//         },
//       ),
//     );
//     await _inlineAdaptiveAd!.load();
//   }
//
//   /// Gets a widget containing the ad, if one is loaded.
//   ///
//   /// Returns an empty container if no ad is loaded, or the orientation
//   /// has changed. Also loads a new ad if the orientation changes.
//   Widget _getAdWidget() {
//     return OrientationBuilder(
//       builder: (context, orientation) {
//         if (_currentOrientation == orientation &&
//             _inlineAdaptiveAd != null &&
//             _isLoaded &&
//             _adSize != null) {
//           return Align(
//               child: Container(
//                 color: Colors.blue.withOpacity(0.5),
//                 width: _adWidth,
//                 height: _adSize!.height.toDouble(),
//                 child: AdWidget(
//                   ad: _inlineAdaptiveAd!,
//                 ),
//               ));
//         }
//         // Reload the ad if the orientation changes.
//         if (_currentOrientation != orientation) {
//           _currentOrientation = orientation;
//           _loadAd();
//         }
//         return Container();
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//       appBar: AppBar(
//         title: Text('Inline adaptive banner example'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: _insets),
//           child: ListView.separated(
//             itemCount: 20,
//             separatorBuilder: (BuildContext context, int index) {
//               return Container(
//                 height: 40,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               if (index == 10) {
//                 return _getAdWidget();
//               }
//               return Text(
//                 'Placeholder text',
//                 style: TextStyle(fontSize: 24),
//               );
//             },
//           ),
//         ),
//       ));
//
//   @override
//   void dispose() {
//     super.dispose();
//     _inlineAdaptiveAd?.dispose();
//   }
// }



//
// class BannerExampleState extends State{
//   AdManagerBannerAd? _bannerAd;
//   bool _isLoaded = false;
//
//   // TODO: replace this test ad unit with your own ad unit.
//   final adUnitId = '/21775744923/example/adaptive-banner';
//
//   /// Loads a banner ad.
//   void loadAd() async {
//     // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
//     final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
//         MediaQuery.sizeOf(context).width.truncate());
//
//     _bannerAd = AdManagerBannerAd(
//       adUnitId: adUnitId,
//       request: const AdManagerAdRequest(),
//       sizes: [],
//       listener: AdManagerBannerAdListener(
//         // Called when an ad is successfully received.
//         onAdLoaded: (ad) {
//           debugPrint('$ad loaded.');
//           setState(() {
//             _isLoaded = true;
//           });
//         },
//         // Called when an ad request failed.
//         onAdFailedToLoad: (ad, err) {
//           debugPrint('AdManagerBannerAd failed to load: $err');
//           // Dispose the ad here to free resources.
//           ad.dispose();
//         },
//       ),
//     )..load();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
//
//
// //
// // class BannerExampleState extends State<BannerExample> {
// //   AdManagerBannerAd? _bannerAd;
// //   bool _isLoaded = false;
// //
// //   // TODO: replace this test ad unit with your own ad unit.
// //   final adUnitId = '/21775744923/example/adaptive-banner';
// //
// //
// //   /// Loads a banner ad.
// //   void loadAd() async {
// //     // Get an AnchoredAdaptiveBannerAdSize before loading the ad.
// //     final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
// //         MediaQuery.sizeOf(context).width.truncate());
// //
// //     _bannerAd = AdManagerBannerAd(
// //       adUnitId: adUnitId,
// //       request: const AdManagerAdRequest(),
// //       sizes: [],
// //       listener: AdManagerBannerAdListener(
// //         // Called when an ad is successfully received.
// //         onAdLoaded: (ad) {
// //           debugPrint('$ad loaded.');
// //           setState(() {
// //             _isLoaded = true;
// //           });
// //         },
// //         // Called when an ad request failed.
// //         onAdFailedToLoad: (ad, err) {
// //           debugPrint('AdManagerBannerAd failed to load: $err');
// //           // Dispose the ad here to free resources.
// //           ad.dispose();
// //         },
// //         // Called when an ad opens an overlay that covers the screen.
// //         onAdOpened: (Ad ad) {},
// //         // Called when an ad removes an overlay that covers the screen.
// //         onAdClosed: (Ad ad) {},
// //         // Called when an impression occurs on the ad.
// //         onAdImpression: (Ad ad) {},
// //       ),
// //     )..load();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //     throw UnimplementedError();
// //   }
// // }