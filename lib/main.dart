import 'package:flutter/material.dart';
import 'package:flutter_api_fetch/core/di/injection.dart';
import 'package:flutter_api_fetch/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter_api_fetch/features/products/presentation/screens/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  configureDependancy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ProductBloc>()..add(FetchProductEvent()),
        ),
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomePage()),
    );
  }
}
