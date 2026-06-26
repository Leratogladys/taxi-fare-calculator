import 'package:flutter/material.dart';
import 'package:taxi_fare_app/routes/app_router.dart';
import 'package:provider/provider.dart';
import 'package:taxi_fare_app/viewmodels/fare_viewmodels.dart';
import 'package:taxi_fare_app/viewmodels/payment_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FareViewmodel()),
        ChangeNotifierProvider(create: (_) => PaymentViewmodel()),
      ],
       child: MaterialApp(
        title: "Taxi Maths Calculator",
        debugShowCheckedModeBanner: false,
        theme: ThemeData( scaffoldBackgroundColor: const Color(0xFF2D2B55)),
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRoutes.home,
       ),
    );
  }
}
