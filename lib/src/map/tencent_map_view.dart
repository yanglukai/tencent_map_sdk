part of '../../tencent_map_sdk.dart';

typedef OnViewCreated = Function(TencentMapController);

class TencentMapView extends StatefulWidget {
  const TencentMapView({
    super.key,
    required this.onViewCreated,
    this.mapConfig,
  });

  final OnViewCreated onViewCreated;
  final TmConfig? mapConfig;

  @override
  State<TencentMapView> createState() => _TencentMapViewState();
}

class _TencentMapViewState extends State<TencentMapView>
    with WidgetsBindingObserver {
  TencentMapController? _mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: "eplbks.tencent_map_view",
        creationParams: const <String, dynamic>{},
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: (viewId) {
          final controller = TencentMapController.initChannel(viewId);
          _mapController = controller;
          controller.updateMapConfig(widget.mapConfig ?? TmConfig._default());
          widget.onViewCreated.call(controller);
        },
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: "eplbks.tencent_map_view",
        creationParams: const <String, dynamic>{},
        creationParamsCodec: const TencentMapCodec(),
        onPlatformViewCreated: (viewId) {
          final controller = TencentMapController.initChannel(viewId);
          controller.updateMapConfig(widget.mapConfig ?? TmConfig._default());
          widget.onViewCreated.call(controller);
        },
      );
    }
    // else if (defaultTargetPlatform == TargetPlatform.ohos) {
    //   return OhosView(
    //     viewType: "eplbks.tencent_map_view",
    //     creationParams: const <String, dynamic>{},
    //     creationParamsCodec: const StandardMessageCodec(),
    //     onPlatformViewCreated: (viewId) {
    //       final controller = TencentMapController.initChannel(viewId);
    //       controller._setMapViewOnReadyComplete(callback: () {
    //         controller.updateMapConfig(widget.mapConfig ?? TmConfig._default());
    //         widget.onViewCreated.call(controller);
    //       });
    //     },
    //   );
    // }
    else {
      return Text("$defaultTargetPlatform is not supported");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // 将 Flutter 的生命周期映射到 Android Activity 生命周期
    switch (state) {
      case AppLifecycleState.resumed:
        _mapController?._resumed();
      case AppLifecycleState.paused:
        _mapController?._paused();
      case AppLifecycleState.detached:
        _mapController?._detached();
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
