// ignore_for_file: unused_import, duplicate_import, duplicate_ignore, unused_local_variable, must_be_immutable

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger/layouts/shopApp/cubit/shopcubit.dart';
import 'package:messenger/layouts/shopApp/shopLayout.dart';
import 'package:messenger/layouts/social_app/social_Layout.dart';
import 'package:messenger/layouts/social_app/socialcubit/socialCubit.dart';
import 'package:messenger/layouts/social_app/sociallogincubit/sociallogincubit.dart';
import 'package:messenger/models/ShopModels/LoginModel.dart';
import 'package:messenger/modules/ShopappModules/onBoardingScreen.dart';
import 'package:messenger/modules/ShopappModules/shopLoginScreen.dart';
import 'package:messenger/layouts/other/homelayout.dart';
import 'package:messenger/layouts/news_app/cubit/cubit.dart';
import 'package:messenger/layouts/news_app/cubit/states.dart';
import 'package:messenger/layouts/news_app/news_layout.dart';
import 'package:messenger/modules/ShopappModules/onBoardingScreen.dart';
// ignore: unused_import
import 'package:messenger/modules/otherModules/bmiresult/BMIResult.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';

// ignore: unused_import
import 'package:messenger/modules/otherModules/counter/CounterScreen.dart';
// ignore: unused_import
import 'package:messenger/modules/otherModules/login/log_in.dart';
// ignore: unused_import
import 'package:messenger/modules/otherModules/userscreen/userscreen.dart';
import 'package:messenger/modules/social_app_modules/chats/chatsScreen.dart';
import 'package:messenger/modules/social_app_modules/social_Register_screen/home.dart';
import 'package:messenger/modules/social_app_modules/social_login_screen/social_login_screen.dart';
import 'package:messenger/shared/components/components.dart';
import 'package:messenger/shared/components/themes.dart';
import 'package:messenger/shared/cubit/cubit.dart';
import 'package:messenger/shared/cubit/states.dart';
import 'package:messenger/shared/shared.network/local/cash_Helper.dart';
import 'package:messenger/shared/shared.network/remote/dio_Helper.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:hexcolor/hexcolor.dart';
// ignore: unused_import
import 'modules/otherModules/messenger/messengerscreen.dart';
import 'shared/components/constants.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  
  print(message.data.toString());
  print('ON Backgorung message');
 
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var tooken = await FirebaseMessaging.instance.getToken();
  print(tooken);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
     print('on message');
     print('on message');
     print('on message');
     print('on message');
     print('on message');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    print('on messages opend');
    
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = Blocobserver();
  DioHelper.init();
  await CashHelper.init();
  if (CashHelper.getdata(key: 'isDark') == null) {
    CashHelper.savedata(key: 'isDark', value: false);
  }
  if (CashHelper.getdata(key: 'onboarding') == null) {
    CashHelper.savedata(key: 'onboarding', value: false);
  }

  bool? isDark = CashHelper.getdata(key: 'isDark');
  bool? onboarding = CashHelper.getdata(key: 'onboarding');
  token = CashHelper.getdata(key: 'token');
// print('oboarding is = $onboarding');
// print('token is = $token');
// print(CashHelper.getdata(key: 'token'));
  Widget widget;
  // if (onboarding ==true ){
  //   if(token !=null){widget = ShopLayout();}
  //   else {widget = SocialLoginScreen();}
  // }else widget = OnBoarding();
  uId = CashHelper.getdata(key: 'uId');
  print(' the uid in constants is = $uId');
  print(' the uid in cash helper =  ${CashHelper.getdata(key: 'uId')}');

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(isDark!, widget));
}

class Blocobserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}

class MyApp extends StatelessWidget {
  final bool isDark;
  Widget widget;
  MyApp(this.isDark, this.widget);

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //   BlocProvider(
        //  create: (BuildContext context) => NewsCubit()
        //      // ..getBusiness()
        //       ..darkmodetoggle(fromshared: isDark),
        //   ),
        BlocProvider(create: (BuildContext context) => Appcubit()),
        BlocProvider(
            create: (BuildContext context) => SocialCubit()
              ..getUserData()
              ..getposts()
              ..getUsers()),

        // //..getHomeData()..getFavorites()..getCategoryData()..getuser()
        // )
      ],
      child: BlocConsumer<Appcubit, Appstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: AppTheme.apptheme,
            themeMode:
                Appcubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            darkTheme: AppThemeDark.appthemedark,
            home: widget,
          );
        },
      ),
    );
  }
}
