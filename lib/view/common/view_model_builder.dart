import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia/utils/interaction_mixin.dart';
import 'package:trivia/utils/navigator_utils.dart';
import 'base_view_model.dart';

class ViewModelBuilder<T extends ChangeNotifier> extends StatefulWidget {
  const ViewModelBuilder({
    Key? key,
    required this.initViewModel,
    required this.builder,
    this.onModelReady,
  })  : reactive = true,
        super(key: key);

  final T Function() initViewModel;
  final Widget Function(BuildContext context, T value) builder;
  final bool reactive;
  final void Function(T)? onModelReady;

  const ViewModelBuilder.nonReactive({
    Key? key,
    required this.initViewModel,
    required this.builder,
    this.onModelReady,
  })  : reactive = false,
        super(key: key);

  @override
  _ViewModelBuilder<T> createState() => _ViewModelBuilder<T>();
}

class _ViewModelBuilder<T extends ChangeNotifier>
    extends State<ViewModelBuilder<T>> {
  late final T viewModel;
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_init) {
      viewModel = widget.initViewModel();

      if (viewModel is InteractionMixin) {
        (viewModel as InteractionMixin).navigate = _navigate;
        // (viewModel as InteractionMixin).dialog = _dialog;
        (viewModel as InteractionMixin).pop = _pop;

        (viewModel as InteractionMixin).loadingOverlay = _loading;
      }

      if (viewModel is BaseViewModel) {
        (viewModel as BaseViewModel)
            .parseArgs(ModalRoute.of(context)?.settings.arguments);
      }
      widget.onModelReady?.call(viewModel);
    }
    _init = true;
  }

  Future<R?> _navigate<R extends Object?>(String routeName,
      {Object? args, bool clearStack = false}) {
    return NavigatorUtil.instance(context, routeName,
        args: args, clearStack: clearStack);
  }

  // Future<R?> _dialog<R extends Object?>(final DialogArgs args) {
  //   return DialogUtil.instance<R>(context, args);
  // }

  void _pop<R extends Object?>([R? result]) {
    return NavigatorUtil.instance.pop<R>(context, result);
  }

  void _loading(bool loading) {
    // if (loading) {
    //  _overlayEntry?.remove();
    //  _overlayEntry = OverlayEntry(
    //    builder: (_) => Container(
    //      color: BloopiColor.loadingOverlayBackground,
    //      child: Column(
    //        mainAxisSize: MainAxisSize.max,
    //        mainAxisAlignment: MainAxisAlignment.center,
    //        children: [
    //          Center(
    //            child: Lottie.asset(AssetPaths.bloopiLoading,
    //                width: 200, height: 200),
    //          )
    //        ],
    //      ),
    //    ),
    //  );

    //  Overlay.of(context)?.insert(_overlayEntry!);
    // } else {
    //  _overlayEntry?.remove();
    //  _overlayEntry = null;
    // }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.reactive) {
      return ChangeNotifierProvider<T>(
        create: (_) => viewModel,
        child: Consumer<T>(
          builder: (context, viewModel, _) => Stack(
            children: [
              widget.builder(context, viewModel),
              // if ((viewModel is BaseViewModel) && viewModel.showLoading)
              //   Container(
              //     color: SovtajSepetiColor.loadingOverlayBackground,
              //     child: Column(
              //       mainAxisSize: MainAxisSize.max,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Center(
              //           child: Lottie.asset(AssetPaths.sovtajsepetiLoading,
              //               width: 200, height: 200),
              //         )
              //       ],
              //     ),
              //   )
            ],
          ),
        ),
      );
    } else {
      return widget.builder(context, viewModel);
    }
  }
}
