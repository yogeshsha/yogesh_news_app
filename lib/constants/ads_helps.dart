// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class AdsHelper{
//   static  AdWidget? home;
//   static  AdWidget? ads2;
//   final AdManagerBannerAdListener listener = AdManagerBannerAdListener(
//     onAdLoaded: (Ad ad) => print('Ad loaded.'),
//     onAdFailedToLoad: (Ad ad, LoadAdError error) {
//       ad.dispose();
//       print('Ad failed to load: ${error.message}');
//     },
//     // Called when an ad opens an overlay that covers the screen.
//     onAdOpened: (Ad ad) => print('Ad opened.'),
//     // Called when an ad removes an overlay that covers the screen.
//     onAdClosed: (Ad ad) => print('Ad closed.'),
//     // Called when an impression occurs on the ad.
//     onAdImpression: (Ad ad) => print('Ad impression.'),
//   );
//   //added
//   static final AdManagerBannerAd homeAds = AdManagerBannerAd(
//     adUnitId: 'ca-app-pub-3940256099942544/6300978111',
//     sizes: [AdSize.banner],
//     request: const AdManagerAdRequest(),
//     listener: AdManagerBannerAdListener(),
//   );
//   //added
//   static final AdManagerBannerAd adsShow2 = AdManagerBannerAd(
//     adUnitId: 'ca-app-pub-3940256099942544/2247696110',
//     sizes: [AdSize.banner],
//     request: const AdManagerAdRequest(),
//     listener: AdManagerBannerAdListener(),
//   );
//   static initializeAds(){
//     home = AdWidget(ad: homeAds);
//     ads2 = AdWidget(ad: adsShow2);
//   }
// }

class AdWidgetUrls {
  static const String fixedSizeBannerAd = "ca-app-pub-3940256099942544/6300978111"; //Working
  static const String nativeAd = "ca-app-pub-3940256099942544/2247696110";
  static const String adaptiveBannerAd = "ca-app-pub-3940256099942544/9214589741"; //Working
  static const String appOpenAd = "ca-app-pub-3940256099942544/9257395921";
  static const String interstitialAd = "ca-app-pub-3940256099942544/1033173712";
  static const String rewardedAd = "ca-app-pub-3940256099942544/5224354917";
  static const String rewardedInterstitialAd = "ca-app-pub-3940256099942544/5354046379";
  static const String nativeVideoAd = "ca-app-pub-3940256099942544/1044960115";
}