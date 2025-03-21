import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'no_events_component_model.dart';
export 'no_events_component_model.dart';

class NoEventsComponentWidget extends StatefulWidget {
  const NoEventsComponentWidget({
    super.key,
    required this.title,
    required this.titleSize,
  });

  final String? title;
  final int? titleSize;

  @override
  State<NoEventsComponentWidget> createState() =>
      _NoEventsComponentWidgetState();
}

class _NoEventsComponentWidgetState extends State<NoEventsComponentWidget> {
  late NoEventsComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoEventsComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.0,
      height: 300.0,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title!,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  fontSize: widget.titleSize?.toDouble(),
                  letterSpacing: 0.0,
                ),
          ),
        ],
      ),
    );
  }
}
