import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:izinto/bindings/initial_binding.dart';
import 'package:izinto/controllers/car_specialty_controller.dart';
import 'package:izinto/controllers/cart_controller.dart';
import 'package:izinto/controllers/laundry_specialty_controller.dart';
import 'package:izinto/controllers/location_controller.dart';
import 'package:izinto/controllers/popular_specialty_controller.dart';
import 'package:izinto/controllers/recommended_specialty_controller.dart';
import 'package:izinto/controllers/subscriptions.dart';
import 'package:izinto/data_uploader_screen.dart';
import 'package:izinto/helpers/dependencies.dart' as dep;
import 'package:izinto/models/user.dart';
import 'package:izinto/pages/cart/cart_page.dart';
import 'package:izinto/pages/checkout/order_success.dart';
import 'package:izinto/pages/checkout/payment_page.dart';
import 'package:izinto/pages/home/home_page.dart';
import 'package:izinto/pages/home/home_route.dart';
import 'package:izinto/pages/home/wrapper.dart';
import 'package:izinto/pages/options/profile_settings.dart';
import 'package:izinto/pages/splash/splash_screen.dart';
import 'package:izinto/routes/route_helper.dart';
import 'package:izinto/scratch.dart';
import 'package:izinto/services/dependency_injection.dart';
import 'package:izinto/services/firebase_auth_methods.dart';
import 'package:izinto/services/location/location_model.dart';
import 'package:izinto/services/location/location_service.dart';
import 'package:izinto/services/phone_auth_methods.dart';
import 'package:izinto/utils/colors.dart';
import 'package:izinto/widgets/location/address_details_view.dart';
import 'package:provider/provider.dart';
import 'controllers/car_wash_support_questions_controller.dart';
import 'controllers/laundry_support_questions_controller.dart';
import 'firebase_options.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.getInitialMessage();
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(alert: true, badge: true);
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await dep.init();

  NetworkInjection.init();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
    statusBarBrightness: Brightness.light, //status bar brightness
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness:
        Brightness.light, //status barIcon Brightness
    //   //   //systemNavigationBarDividerColor:
    //   //   //  Colors.brown[100], //Navigation bar divider color
    //   //   // systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // runApp(DevicePreview(builder: (context) => const MyApp(), enabled: true));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    Get.put(LocationController());
    return GetBuilder<PopularSpecialtyController>(builder: (_) {
      return GetBuilder<RecommendedSpecialtyController>(builder: (_) {
        return GetBuilder<LaundrySpecialtyController>(builder: (_) {
          return GetBuilder<CarSpecialtyController>(builder: (_) {
            return GetBuilder<SubscriptionController>(builder: (_) {
              return GetBuilder<LaundrySupportQuestionsController>(
                  builder: (_) {
                return GetBuilder<CarWashSupportQuestionsController>(
                    builder: (_) {
                  return GetBuilder<PhoneAuthMethods>(builder: (_) {
                    return StreamProvider<UserModel?>.value(
                      value: FirebaseAuthMethods().user,
                      initialData: UserModel(uid: ''),
                      child: GetMaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: 'Izinto',
                        home: Wrapper(),
                        theme: ThemeData(
                          colorScheme: ColorScheme.fromSwatch().copyWith(
                            // or from RGB
                            primary: const Color(0xFFB09B71),
                            secondary: const Color(0Xff353839),
                          ),
                        ),

                        // initialRoute: RouteHelper.getSplashScreen(),
                        // home: FirebaseAuthMethods(FirebaseAuth.instance).handleAuthState(),
                        // home: DataUploaderScreen(),
                        // home: HomeRoute(),
                        getPages: RouteHelper.routes,
                      ),
                    );
                  });
                });
              });
            });
          });
        });
      });
    });
  }
}
