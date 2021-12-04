import 'package:flutter/material.dart';
import 'package:trivia/data/networking/api_error.dart';
import 'package:trivia/utils/interaction_mixin.dart';

class BaseViewModel<VA> extends ChangeNotifier with InteractionMixin {
  VA? arguments;

  VA get args => arguments!;
  bool isBusy = false;
  bool mounted = false;
  bool showLoading = false;

  void parseArgs([Object? args]) {
    if (args != null && args is VA) {
      arguments = args as VA?;
    }
    if (!mounted) {
      mounted = true;
    }
  }

  void notify() => notifyListeners();

  @protected
  @visibleForTesting
  void onBindingCreated() {}

  Future<void> flow<T extends Object?>(
    final Function callback, {
    final ValueChanged<T>? onSuccess,
    final void Function(ApiError, StackTrace)? onError,
    final bool showLoading = true,
    final bool showError = true,
    final void Function(dynamic)? onPopDialog,
  }) async {
    this.showLoading = showLoading;
    isBusy = true;
    notify();

    try {
      final T data = await callback();
      onSuccess?.call(data);
    } on ApiError catch (e, s) {
      this.showLoading = false;
      isBusy = false;
      notify();
      if (onError != null) {
        onError(e, s);
      } else {
        if (showError) {
          //Hadle Error
          debugPrint("HATA:" + e.message);
          // dialog(DialogArgs(
          //     description: e.message, title: SovtajSepetiLocalized.error));
        }
      }
    } finally {
      this.showLoading = false;
      isBusy = false;
      notify();
    }
  }
}
