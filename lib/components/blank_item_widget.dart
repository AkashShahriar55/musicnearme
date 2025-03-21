import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'blank_item_model.dart';
export 'blank_item_model.dart';

class BlankItemWidget extends StatefulWidget {
  const BlankItemWidget({super.key});

  @override
  State<BlankItemWidget> createState() => _BlankItemWidgetState();
}

class _BlankItemWidgetState extends State<BlankItemWidget> {
  late BlankItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BlankItemModel());

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
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 100.0,
              decoration: BoxDecoration(
                color: Color(0xFFDADADA),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Container(
              width: double.infinity,
              height: 20.0,
              decoration: BoxDecoration(
                color: Color(0xFFDADADA),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            Divider(
              thickness: 1.0,
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
          ].divide(SizedBox(height: 10.0)),
        ),
      ),
    );
  }
}
