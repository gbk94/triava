import 'package:flutter/material.dart';
import 'package:trivia/res/TAColors.dart';
import 'package:trivia/route/args/dialog_args.dart';
import 'package:trivia/view/common/widgets/trivia_button.dart';

class DialogUtil {
  DialogUtil._();
  static final DialogUtil instance = DialogUtil._();

  final _dialogAnimationTween = Tween<double>(begin: 0.97, end: 1);
  static const toastDuration = Duration(seconds: 2);
  static const alertDuration = Duration(seconds: 3, milliseconds: 400);

  final _dialogTransitionDuration = const Duration(milliseconds: 200);

  static const _kDialogShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)));

  static final _dialogPadding = const EdgeInsets.all(16).copyWith(top: 12);

  Future<T?> dialog<T>(
    final BuildContext context,
    final DialogArgs args,
  ) async {
    return showGeneralDialog<T>(
      context: context,
      barrierLabel: 'Dialog',
      barrierDismissible: args.dismissible,
      transitionDuration: _dialogTransitionDuration,
      pageBuilder: (context, _, __) => _buildDialog(context, args),
      transitionBuilder: (_, animation, __, child) {
        return ScaleTransition(
          scale: _dialogAnimationTween.animate(
            CurvedAnimation(
              curve: Curves.decelerate,
              reverseCurve: Curves.ease,
              parent: animation,
            ),
          ),
          child: child,
        );
      },
    );
  }

  Future<T?> call<T>(final BuildContext context, final DialogArgs args) async {
    return dialog<T>(context, args);
  }

  Widget _buildDialog(
    final BuildContext context,
    final DialogArgs args,
  ) {
    return WillPopScope(
      onWillPop: () => Future.value(args.dismissible),
      child: Dialog(
        backgroundColor: TAColors.red,
        elevation: 12,
        shape: _kDialogShape,
        insetAnimationDuration: Duration.zero,
        child: Padding(
          padding: _dialogPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (args.title.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12, top: 8),
                  child: Text(
                    args.title,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),
              Text(
                args.description,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  if (args.negativeButtonText.isNotEmpty)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SizedBox(
                          height: 48,
                          child: TriviaButton(
                            buttonTitle: args.negativeButtonText,
                            onPressed: () {
                              pop(context, false);
                              args.onNegativeButtonPressed?.call();
                            },
                          ),
                        ),
                      ),
                    ),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: TriviaButton(
                        buttonTitle: args.positiveButtonText,
                        onPressed: () {
                          pop(context, true);
                          args.onPositiveButtonPressed?.call();
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<T?> customDialog<T extends Object?>(
    final BuildContext context,
    final Widget child, {
    final bool dismissible = true,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: _kDialogShape,
          child: child,
        );
      },
    );
  }

  Future<T?> bottomSheet<T>(
    final BuildContext context, {
    required final String route,
    final Object? args,
    final bool enableDrag = true,
    final bool dismissible = true,
    final bool clear = false,
    final bool scrollControlled = true,
    final EdgeInsetsGeometry? margin,
  }) async {
    return showModalBottomSheet<T>(
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      enableDrag: enableDrag,
      isScrollControlled: scrollControlled,
      routeSettings: RouteSettings(name: route, arguments: args),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isDismissible: dismissible,
      context: context,
      builder: (_) {
        return WillPopScope(
          onWillPop: () => Future<bool>.value(dismissible),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
              ),
              Flexible(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(2),
                    ),
                  ),
                  child: const SizedBox(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void pop<T extends Object?>(final BuildContext context, [T? result]) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context, rootNavigator: true).pop(result);
    }
  }
}
