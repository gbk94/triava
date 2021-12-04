mixin InteractionMixin {
  late Future<T?> Function<T extends Object?>(String routeName,
      {Object? args, bool clearStack}) navigate;
  // late Future<T?> Function<T extends Object?>(DialogArgs args) dialog;

  late void Function<T extends Object?>([T result]) pop;
  late void Function(bool loading) loadingOverlay;
}
