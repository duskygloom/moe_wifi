import 'package:flutter/material.dart';
import 'package:moe_wifi/view/home_app_bar/home_app_bar.dart';
import 'package:moe_wifi/view/home_body/home_body.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HomeAppBar(), body: HomeBody());
  }
}
