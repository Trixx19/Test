// ignore_for_file: file_names

import 'package:flutter/material.dart';

class IconButtonBack extends StatelessWidget {
  final String navigator;
  const IconButtonBack({
    super.key,
    required this.navigator,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.width * .01),
      child: SizedBox(
        height: size.height * .07,
        child: FloatingActionButton(
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
          ),
          onPressed: () {
            if (navigator == '') {
              Navigator.of(context).pop();
            } else {
              Navigator.of(context).pushNamed(navigator);
            }
          },
          // ROTA = rota do botão "voltar"
        ),
      ),
    );
  }
}
