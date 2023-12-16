import 'package:flutter/material.dart';

class MainCto extends StatefulWidget {
  const MainCto({
    super.key,
    required ValueNotifier<bool> isSubscribed,
  }) : _switch = isSubscribed;

  final ValueNotifier<bool> _switch;

  @override
  State<MainCto> createState() => _MainCtoState();
}

class _MainCtoState extends State<MainCto> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        widget._switch.value = !widget._switch.value;
      },
      child: const Icon(Icons.add),
    );
  }
}
