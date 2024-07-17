import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required int totalItem,
    required int activeScreenIndex,
  })  : _totalItem = totalItem,
        _activeScreenIndex = activeScreenIndex;

  final int _totalItem;
  final int _activeScreenIndex;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...List.generate(
        (_totalItem),
        (idx) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              // color:Colors.black,
              height: 10,
              width: idx == _activeScreenIndex ? 25 : 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: idx == _activeScreenIndex
                      ? Colors.black
                      : Colors.black.withOpacity(0.2)),
            ),
          );
        },
      ),
    ]);
  }
}
