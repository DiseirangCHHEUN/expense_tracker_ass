import 'package:curved_navigation_bar_with_label/nav_custom_painter.dart';
import 'package:flutter/material.dart';

typedef LetIndexPage = bool Function(int value);

int _currentIndex = 0;

class CurvedNavigationBar extends StatefulWidget {
  final List<CurvedNavigationBarItem> items;
  final int index;
  final Color? color;
  final Color backgroundColor;
  final Color? buttonBackgroundColor;
  final Color? buttonLabelColor;
  final ValueChanged<int>? onTap;
  final LetIndexPage letIndexChange;
  final Curve animationCurve;
  final Duration animationDuration;
  final double height;

  CurvedNavigationBar({
    super.key,
    required this.items,
    this.index = 0,
    this.color,
    this.backgroundColor = Colors.blueAccent,
    this.buttonBackgroundColor,
    this.buttonLabelColor,
    this.onTap,
    LetIndexPage? letIndexChange,
    this.animationCurve = Curves.easeOut,
    this.animationDuration = const Duration(milliseconds: 600),
    this.height = 60.0,
  })  : letIndexChange = letIndexChange ?? ((_) => true),
        assert(items.isNotEmpty),
        assert(0 <= index && index < items.length),
        assert(0 <= height && height <= height);

  @override
  CurvedNavigationBarState createState() => CurvedNavigationBarState();
}

class CurvedNavigationBarState extends State<CurvedNavigationBar>
    with SingleTickerProviderStateMixin {
  late double _startingPos;
  int _endingIndex = 0;
  late double _pos;
  double _buttonHide = 0;
  late Widget _icon;
  late String _label;
  late AnimationController _animationController;
  late int _length;

  @override
  void initState() {
    super.initState();

    _icon = widget.items[widget.index].icon;
    _label = widget.items[widget.index].label;
    _length = widget.items.length;
    _pos = widget.index / _length;
    _startingPos = widget.index / _length;

    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.items.length;
        final middle = (endingPos + _startingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = widget.items[_endingIndex].icon;
          _label = widget.items[_endingIndex].label;
        }
        _buttonHide =
            (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
      });
    });
  }

  @override
  void didUpdateWidget(CurvedNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _label = widget.items[_endingIndex].label;
    _length = widget.items.length;

    Size size = Size(
        MediaQuery.of(context).size.width -
            (MediaQuery.of(context).padding.left +
                MediaQuery.of(context).padding.right),
        MediaQuery.of(context).size.height);

    return SafeArea(
      child: Material(
        color: widget.backgroundColor,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: -25 - (75.0 - widget.height),
              left: Directionality.of(context) == TextDirection.rtl
                  ? null
                  : _pos * size.width,
              right: Directionality.of(context) == TextDirection.rtl
                  ? _pos * size.width
                  : null,
              width: size.width / _length,
              child: Center(
                child: Transform.translate(
                  offset: Offset(
                    0,
                    -(1 - _buttonHide) * 80,
                  ),
                  child: Material(
                    color: widget.buttonBackgroundColor ??
                        Theme.of(context).cardColor,
                    type: MaterialType.circle,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _icon,
                    ),
                  ),
                ),
              ),
            ),
            CustomPaint(
              painter: NavCustomPainter(
                startingLoc: _pos,
                itemsLength: _length,
                color: Theme.of(context).scaffoldBackgroundColor,
                textDirection: Directionality.of(context),
              ),
              child: Container(
                height: widget.height,
              ),
            ),
            Positioned(
              left: Directionality.of(context) == TextDirection.rtl
                  ? null
                  : _pos * size.width,
              right: Directionality.of(context) == TextDirection.rtl
                  ? _pos * size.width
                  : null,
              width: size.width / _length,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(
                    _label,
                    style: TextStyle(
                        color:
                            widget.buttonLabelColor ?? widget.backgroundColor,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: widget.height,
              child: Row(
                children: widget.items.map(
                  (item) {
                    return NavButton(
                      onTap: _buttonTap,
                      position: _pos,
                      length: _length,
                      index: widget.items.indexOf(item),
                      height: widget.height,
                      child: Center(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: item.icon,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  item.label,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  setPage(int index) {
    _buttonTap(index);
  }

  _buttonTap(int index) {
    if (widget.onTap != null) {
      widget.onTap!(index);
    }

    if (_endingIndex != index) {
      if (!widget.letIndexChange(index)) {
        return;
      }

      final newPosition = index / _length;
      setState(() {
        _startingPos = _pos;
        _endingIndex = index;
        _currentIndex = index;
        _animationController.animateTo(newPosition,
            duration: widget.animationDuration, curve: widget.animationCurve);
      });
    }
  }
}

class CurvedNavigationBarItem {
  final Widget icon;
  final String label;

  CurvedNavigationBarItem({required this.icon, required this.label});
}

class NavButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final ValueChanged<int> onTap;
  final Widget child;
  final double height;

  const NavButton({
    super.key,
    required this.onTap,
    required this.position,
    required this.length,
    required this.index,
    required this.child,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final desiredPosition = 1.0 / length * index;
    final difference = (position - desiredPosition).abs();
    final verticalAlignment = 1 - length * difference;
    final opacity = length * difference;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: _currentIndex != index
            ? InkWell(
                customBorder:
                    const CircleBorder(), //const ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                onTap: () {
                  onTap(index);
                },
                child: SizedBox(
                  height: height,
                  child: Transform.translate(
                    offset: Offset(0,
                        difference < 1.0 / length ? verticalAlignment * 40 : 0),
                    child: Opacity(
                      opacity: difference < 1.0 / length * 0.99 ? opacity : 1.0,
                      child: child,
                    ),
                  ),
                ),
              )
            : GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  onTap(index);
                },
                child: SizedBox(
                  height: height,
                  child: Transform.translate(
                    offset: Offset(
                      0,
                      difference < 1.0 / length ? verticalAlignment * 40 : 0,
                    ),
                    child: Opacity(
                      opacity: difference < 1.0 / length * 0.99 ? opacity : 1.0,
                      child: child,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
