class ApiConstants {


  static String ip = "192.168.29.191";
  static String baseUrlTemp = "http://$ip:3001";
  static String baseUrl = "$baseUrlTemp/v1/";



  static String authUrl = '${baseUrl}auth/authMe';
  static String refreshTokenUrl = '${baseUrl}auth/refreshToken';
  static String apiUrl = '${baseUrl}categories';
  static String categoryUrl = '${baseUrl}newsCategories/getActiveNewsCategories';
  static String latestNewsUrl = '${baseUrl}home/getFeaturedNews';
  static String getNewsUrl = '${baseUrl}home/getPersonalizedNews?';
  static String getReportReasonUrl = '${baseUrl}reportNews/getNewsReportReasons';
  static String getBookmarkListUrl = '${baseUrl}likedNews/getMyLikedNews?';
  static String getYourListUrl = '${baseUrl}userNews/getMyUserNews?';
  static String getNewsDetailUrl = '${baseUrl}allNews/getById';
  static String getUserNewsDetailUrl = '${baseUrl}userNews/getById';
  static String getLikedNewsUrl = '${baseUrl}allNews/getSimilarNews/';
  static String bookMarkUrl = '${baseUrl}likedNews/toggleLike/';
  static String submitReportsUrl = '${baseUrl}reportNews/submitReport';
  static String updateMyDetailsUrl = '${baseUrl}userInterests/addMyInterest';
  static String updateMyProfileApi = '${baseUrl}users/updateMyDetails';
  static String addFreeSubscriptionApi = '${baseUrl}subscriptions/addFreeSubscription';
  static String pushNewsUrl = '${baseUrl}userNews/add';
  static String updateNewsUrl = '${baseUrl}userNews/update';
  static String generateDeepLinkUrl = '${baseUrl}userNews/shareNews/';

  static String deleteNewsUrl = '${baseUrl}userNews/delete/';
  static String detailUrl = '${baseUrl}news/';
  static String breakingUrl = '${baseUrl}news/breakingNews';
  static String termsUrl = '${baseUrl}terms';
  static String signUpUrl = '${baseUrl}auth/register';
  static String loginUrl = '${baseUrl}auth/login';
  static String logOutUrl = '${baseUrl}auth/logout';
  static String allSubscriptionUrl = '${baseUrl}subscriptionPlans/getAll';
  static String addSubscriptionUrl = '${baseUrl}Subscriptions/addMySubscription';
  static String renewSubscriptionUrl = '${baseUrl}subscriptions/renewSubscription';
  static String upgradeSubscriptionApi = '${baseUrl}subscriptions/upgradeSubscription';
  static String currentSubscriptionUrl = '${baseUrl}subscriptions/getMySubscription';
  static String likeUrl = '${baseUrl}news/like';
  static String unLikeUrl = '${baseUrl}news/unlike';
  static String allFavoriteUrl = '${baseUrl}news/liked';
  static String dummyVideoUrl = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  static String dummyAdsVideoUrl = 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4';

  // Notification
  static String getNotificationTypeApi = '${baseUrl}notificationCategories/getUserNotificationCategory';
  static String allNotificationApi = '${baseUrl}notifications/getMyNotifications/';
  static String deleteNotificationApi = '${baseUrl}notifications/clearNotification';


}

