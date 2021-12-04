class DialogArgs {
  final String title;
  final String description;
  final String negativeButtonText;
  final String positiveButtonText;
  final void Function()? onNegativeButtonPressed;
  final void Function()? onPositiveButtonPressed;
  final bool dismissible;

  DialogArgs({
    this.title = '',
    required this.description,
    this.negativeButtonText = '',
    this.onNegativeButtonPressed,
    String? positiveButtonText,
    this.onPositiveButtonPressed,
    this.dismissible = true,
  }) : positiveButtonText = positiveButtonText ??= "Okey";
}
