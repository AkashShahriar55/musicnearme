// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingUpMenu extends StatefulWidget {
  const SlidingUpMenu({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<SlidingUpMenu> createState() => _SlidingUpMenuState();
}

class _SlidingUpMenuState extends State<SlidingUpMenu> {
  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      minHeight: MediaQuery.of(context).size.height * .08,
      maxHeight: MediaQuery.of(context).size.height * .50,
      panel: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
                top: 15,
                left: MediaQuery.of(context).size.width * .40,
                right: MediaQuery.of(context).size.width * .40,
                child: Icon(
                  Icons.maximize_outlined,
                  color: Colors.pink,
                  size: 50,
                )),
            Positioned(
              top: MediaQuery.of(context).size.height * .1,
              right: 0,
              left: 0,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
