import 'package:flutter/material.dart';
import 'package:open_weather_cubit/constants/constants.dart';

class ShowIcon extends StatelessWidget {
  final String icon;
  const ShowIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif',
      image: 'http://$kIconHost/img/wn/$icon@4x.png',
      width: 112,
      height: 112,
    );
  }
}
