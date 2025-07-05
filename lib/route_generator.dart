import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/presentation/screens/account/account_screen.dart';
import 'package:newsapp/presentation/screens/bookmark/bookmark_screen.dart';
import 'package:newsapp/presentation/screens/bottom_navigator_screen.dart';
import 'package:newsapp/presentation/screens/complain/complain_screen.dart';
import 'package:newsapp/presentation/screens/connection_timeout/connection_timeout_screen.dart';
import 'package:newsapp/presentation/screens/details/detail_screen.dart';
import 'package:newsapp/presentation/screens/details/detail_screen_stories.dart';
import 'package:newsapp/presentation/screens/favorite/favorite_screen.dart';
import 'package:newsapp/presentation/screens/home_tabs/headline_expanded_news.dart';
import 'package:newsapp/presentation/screens/info_screen/info_screen.dart';
import 'package:newsapp/presentation/screens/language/language_screen.dart';
import 'package:newsapp/presentation/screens/live/breaking_news_tv.dart';
import 'package:newsapp/presentation/screens/login/login_screen.dart';
import 'package:newsapp/presentation/screens/login/sign_up_screen.dart';
import 'package:newsapp/presentation/screens/my_subscription/payment_screen.dart';
import 'package:newsapp/presentation/screens/my_subscription/manage_subscription_screen.dart';
import 'package:newsapp/presentation/screens/my_subscription/selected_subscription_screen.dart';
import 'package:newsapp/presentation/screens/my_subscription/subscription_screen.dart';
import 'package:newsapp/presentation/screens/news_details/news_details_screen.dart';
import 'package:newsapp/presentation/screens/news_details/text_editor_component.dart';
import 'package:newsapp/presentation/screens/news_details/upload_news.dart';
import 'package:newsapp/presentation/screens/news_details/your_news_screen.dart';
import 'package:newsapp/presentation/screens/notification/notification_screen.dart';
import 'package:newsapp/presentation/screens/qr_scanner/qr_scanner.dart';
import 'package:newsapp/presentation/screens/search/search_detail_screen.dart';
import 'package:newsapp/presentation/screens/search/search_screen.dart';
import 'package:newsapp/presentation/screens/session_expire/session_expire.dart';
import 'package:newsapp/presentation/screens/sign_in_screen/sign_in_third_screen.dart';
import 'package:newsapp/presentation/screens/splash/splash.dart';
import 'package:newsapp/presentation/screens/submit_news/submit_your_news.dart';
import 'package:newsapp/presentation/screens/term_and_conditions/terms_and_conditions.dart';
import 'package:newsapp/presentation/screens/web_view/web_view_screen.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const BottomNavigatorScreen());
      case '/splashScreen':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/infoScreen':
        return MaterialPageRoute(builder: (_) => const InfoScreen());
      case '/signInThirdScreen':
        return MaterialPageRoute(builder: (_) => const SignInThirdScreen());
      case '/detailsStories':
        var map = args as String;
        return MaterialPageRoute(
            builder: (_) => DetailStoriesScreen(
                  id: map,
                ));
      case '/details':
        var map = args as String;
        return MaterialPageRoute(
          builder: (_) => DetailsScreen(
            id: map,
          ),
        );
      case '/bannerExpanded':
        var map = args as Map;
        return MaterialPageRoute(
            builder: (_) => HeadLineExpandedNews(
                  data: map['list'],
                  image: map['image'],
                ),
            allowSnapshotting: false,
            fullscreenDialog: false);
      // case '/webView':
      //   var map = args as String;
      //   return MaterialPageRoute(
      //       builder: (_) => WebViewScreen(
      //             url: map,
      //           ));
      case '/submitYourNews':
        return MaterialPageRoute(builder: (_) => const SubmitYourNews());
      case '/termsAndConditions':
        return MaterialPageRoute(builder: (_) => const TermsAndConditions());
      case '/subscriptionScreen':
        return MaterialPageRoute(builder: (_) => const SubscriptionScreen());
      case '/complain':
        return MaterialPageRoute(builder: (_) => const ComplainScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case '/login':
        bool checkBackButton = false;
        bool sessionExpired = false;
        if (args is Map) {
          checkBackButton = args["checkBackButton"] ?? false;
          sessionExpired = args["sessionExpired"] ?? false;
        }

        return MaterialPageRoute(
            builder: (_) => LoginScreen(
                checkBackButton: checkBackButton,
                sessionExpired: sessionExpired));
      case '/signUp':
        bool checkBackButton = false;
        bool sessionExpired = false;
        if (args is Map) {
          checkBackButton = args["checkBackButton"] ?? false;
          sessionExpired = args["sessionExpired"] ?? false;
        }

        return MaterialPageRoute(
            builder: (_) => SignUpScreen(
                checkBackButton: checkBackButton,
                sessionExpired: sessionExpired));
      case '/myFavorite':
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());
      case '/breakingNewsTv':
        var map = args as ChewieController;
        return MaterialPageRoute(
            builder: (_) => BreakingNewsTV(
                  controller: map,
                ));
      case '/languageScreen':
        return MaterialPageRoute(builder: (_) => const LanguageScreen());
      case '/sessionExpired':
        return MaterialPageRoute(builder: (_) => const SessionExpiredScreen());

      case '/selectedSubscriptionScreen':
        Map map = args as Map;
        return MaterialPageRoute(
            builder: (_) => SelectedSubscriptionScreen(
                planName: map['planName'],
                description: map['description'],
                amount: map["amount"],
                percentage: map['percentage']));

      case '/paymentScreen':
        Map map = args as Map;
        return MaterialPageRoute(
            builder: (_) =>
                PaymentScreen(paymentType: map['type'], image: map['image']));
      case '/searchDetailScreen':
        Map map = args as Map;
        return MaterialPageRoute(
            builder: (_) => SearchDetailScreen(
                  newsId: map['id'],
                ));
      // case '/qrScanner':
      //   return MaterialPageRoute(
      //       builder: (_) => const QRScannerWidget());
      case '/showBookmark':
        return MaterialPageRoute(
            builder: (_) => const BookmarkScreen());

      case '/yourNewsScreen':
        return MaterialPageRoute(builder: (_) => const YourNewsScreen());

      case '/uploadNewsScreen':
        Map map = args as Map;
        return MaterialPageRoute(
            builder: (_) => UploadNewsScreen(
                  categoryList: map['categoryList'],
                  newsId: map['newsId'],
                ));

      // case '/newsDetails':
      //   Map map = args as Map;
      //   return MaterialPageRoute(
      //       builder: (_) => YourNewsDetailScreen(
      //             newsId: map['id'],
      //           ));

      case '/newsDetails':
        Map map = args as Map;
        return MaterialPageRoute(
            builder: (_) => NewsDetailScreen(
                  newsId: map['id'],
                ));

      case '/manageSubscriptionScreen':
        return MaterialPageRoute(
            builder: (_) => const ManageSubscriptionScreen());

      case '/textEditorComponent':
        Map map = args as Map;
        return MaterialPageRoute(
            allowSnapshotting: false,
            builder: (_) => TextEditorComponent(
                title: map["title"],
                value: map["value"],
                onChange: map["onChange"]));
      case '/connectionTimeout':
        bool isHome = false;
        if (args != null) {
          if (args is bool) {
            isHome = args;
          }
        }
        return MaterialPageRoute(
            allowSnapshotting: false,
            builder: (_) => ConnectionTimeoutScreen(
                  isHome: isHome,
                ));
      case '/notification':
        return MaterialPageRoute(
            allowSnapshotting: false,
            builder: (_) => const NotificationScreens());
      case '/account':
        return MaterialPageRoute(
            allowSnapshotting: false,
            builder: (_) => const Account());
    }
    return null;
  }
}
