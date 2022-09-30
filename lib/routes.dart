import 'package:flutter/material.dart';
import 'package:goresto/Screens/Favourite/favourite_screen.dart';
import 'package:goresto/Screens/MapTest/map.dart';
import 'package:goresto/Screens/Orders/orders_screen.dart';
import 'package:goresto/Screens/Profile/profile_screen.dart';
import 'package:goresto/Screens/Restaurant/restaurant_screen.dart';
import 'package:goresto/Screens/Search/search.dart';
import 'package:goresto/Screens/design_course/homePage.dart';
import 'package:goresto/Screens/menuItem/item_screen.dart';
import 'package:goresto/Screens/reservastion/reservation_screen.dart';

import 'Screens/introduction_animation/introduction_animation_screen.dart';

// final Map<String, WidgetBuilder>  routes = {
//   WelcomeScreen.routeName: (context) => const WelcomeScreen(),
//   HomeScreen.routeName: (context) => const HomeScreen(),
//   CurrentLocation.routeName : (context) => const CurrentLocation(),
//  // RestaurantScreen.routeName : (context) =>  RestaurantScreen(data: data),
//   GeoLocationScreen.routeName : (context) => const GeoLocationScreen(),
//   //MenuProduct.routeName : (context) => MenuProduct(),
//   IntroductionAnimationScreen.routeName : (context) => IntroductionAnimationScreen(),
//   NewHomeScreen.routeName : (context) => NewHomeScreen(),
//   ReservationScreen.routeName : (context) => ReservationScreen(),
//   SearchScreenEmpty.routeName : (context) =>  SearchScreenEmpty()
// };

// Route createRoute(String route, {data}){
//   return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => routes.entries.firstWhere((element) => element.key==route).value(context),opaque: false,
//       transitionsBuilder: (context, animation, secondaryAnimation, child){
//         const begin = Offset(0.0, 1.0);
//         const end = Offset.zero;
//         const curve = Curves.fastOutSlowIn;
//         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve,));
//         return SlideTransition(position: animation.drive(tween),
//           child: child,);
//       },
//       transitionDuration: Duration(milliseconds: 800)
//   );
// }


class AppRouter {
  static const String onBoardingRoute = '/';
  static const String homeRoute = 'home';
  static const String detailsRoute = 'details';
  static const String favouritesRoute = 'favourites';
  static const String mapRoute = 'map';
  static const String ordersRoute = '/order';
  static const String itemRoute = '/item';
  static const String bookingRoute = 'booking';
  static const String profileRoute = 'profile';
  static const String searchRoute = 'search';


  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case onBoardingRoute :
        return MaterialPageRoute(builder: (context) => IntroductionAnimationScreen(),);
      case homeRoute :
        return MaterialPageRoute(builder: (context) => NewHomeScreen(),);
      case detailsRoute :
        return MaterialPageRoute(builder: (context) => RestaurantScreen(data: settings.arguments as Map<String, dynamic>),);
      case favouritesRoute :
        return MaterialPageRoute(builder: (context) => FavouriteScreen(),);
      case mapRoute :
        return MaterialPageRoute(builder: (context) => MapTest(animationController: settings.arguments as AnimationController),);
      case itemRoute :
        return MaterialPageRoute(builder: (context) => MenuProduct(data: settings.arguments as List<dynamic>),);
      case ordersRoute :
        return MaterialPageRoute(builder: (context) => OrdersScreen(),);
      case profileRoute :
        return MaterialPageRoute(builder: (context) => ProfileScreen(),);
      case bookingRoute :
        return MaterialPageRoute(builder: (context) => ReservationScreen(),);
      case  searchRoute :
        return MaterialPageRoute(builder: (context) => SearchScreenEmpty(),);
      default :
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));

    }
  }
}