import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'catch_page_model.dart';
export 'catch_page_model.dart';

class CatchPageWidget extends StatefulWidget {
  const CatchPageWidget({super.key});

  static String routeName = 'catchPage';
  static String routePath = '/catchPage';

  @override
  State<CatchPageWidget> createState() => _CatchPageWidgetState();
}

class _CatchPageWidgetState extends State<CatchPageWidget> {
  late CatchPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CatchPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().onboardingComplete) {
        if (loggedIn) {
          if ((currentUserPhoto != null && currentUserPhoto != '') &&
              (currentUserDisplayName != null &&
                  currentUserDisplayName != '')) {
            FFAppState().currentPage = 'Home';
            safeSetState(() {});

            context.pushNamed(NewHomePageWidget.routeName);

            return;
          } else {
            context.goNamed(AccountSetupWidget.routeName);

            return;
          }
        } else {
          context.goNamed(
            LoginWidget.routeName,
            extra: <String, dynamic>{
              kTransitionInfoKey: TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
                duration: Duration(milliseconds: 100),
              ),
            },
          );

          return;
        }
      } else {
        context.goNamed(
          Onboarding1Widget.routeName,
          extra: <String, dynamic>{
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.fade,
              duration: Duration(milliseconds: 0),
            ),
          },
        );

        return;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      ),
    );
  }
}
