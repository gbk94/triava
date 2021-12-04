import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickerView extends StatefulWidget {
  const PickerView(
      {Key? key,
      required this.items,
      this.placeholder = "",
      this.onValueChanged})
      : super(key: key);
  final List<String> items;
  final String placeholder;
  final void Function(int index)? onValueChanged;

  @override
  _PickerViewState createState() => _PickerViewState();
}

class _PickerViewState extends State<PickerView> {
  bool valueSelected = false;
  int selectedIndex = -1;

  void openPicker(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) => SizedBox(
          height: 200,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Tamam"),
                  )
                ],
              ),
              Expanded(
                  child: CupertinoPicker(
                      onSelectedItemChanged: onValueChange,
                      itemExtent: 32.0,
                      children: renderItems()))
            ],
          )),
    );
  }

  List<Widget> renderItems() {
    List<Widget> list = [];
    for (var i = 0; i < widget.items.length; i++) {
      list.add(
        Text(widget.items[i]),
      );
    }
    return list;
  }

  onValueChange(int index) {
    setState(() {
      valueSelected = true;
      selectedIndex = index;
    });
    if (widget.onValueChanged != null) {
      widget.onValueChanged!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openPicker(context);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
                width: 2, color: valueSelected ? Colors.black : Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                valueSelected
                    ? widget.items[selectedIndex]
                    : widget.placeholder,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: valueSelected ? Colors.black : Colors.grey)),
            const Icon(Icons.arrow_drop_down_sharp, color: Colors.black)
          ],
        ),
      ),
    );
  }
}
