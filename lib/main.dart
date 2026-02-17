import 'package:flutter/material.dart';
import 'package:flutter_api_fetch/core/di/injection.dart';
import 'package:flutter_api_fetch/features/products/domain/model/product.dart';
import 'package:flutter_api_fetch/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter_api_fetch/features/products/presentation/screens/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('productBox');
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
