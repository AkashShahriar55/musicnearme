import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'notifications_page_widget.dart' show NotificationsPageWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationsPageModel extends FlutterFlowModel<NotificationsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for eventReminders widget.
  bool? eventRemindersValue;
  // State field(s) for nearbyOffersAndPromotions widget.
  bool? nearbyOffersAndPromotionsValue;
  // State field(s) for popularEventsInYourArea widget.
  bool? popularEventsInYourAreaValue;
  // State field(s) for updatesAndAnnouncements widget.
  bool? updatesAndAnnouncementsValue;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
