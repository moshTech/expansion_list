library expansion_list;

/// A Calculator.
// class Calculator {
//   /// Returns [value] plus 1.
//   int addOne(int value) => value + 1;
// }

import 'package:flutter/material.dart';

/// An expansion list
///
/// A widget that expands and collapses with a list of items.
///
/// Get the item selected and set it as title.
class ExpansionList<T> extends StatefulWidget {
  /// The list of items for the expansion
  final List<T>? items;
  /// The title of the expansion which changes on new item selected.
  final String? title;
  /// The method to get the item selected for re-use
  final Function(T)? onItemSelected;
  /// If set to true, a small specific size is given to the expansion by default
  final bool smallVersion;
  /// The alignment for the items
  final MainAxisAlignment? childrenAlignment;
  /// Title alignment
  final MainAxisAlignment? titleAlignment;
  /// The title icon
  final Icon? icon;
  /// The collapsing expansion height
  final double height;
  /// The collapsing expansion width
  final double width;
  /// To set the color of the divider between title and other items
  final Color? dividerColor;
  /// To style the text of the items
  final TextStyle? textStyle;
  /// Background color when expands
  final Color? backgroundColor;
  /// collapsing background color
  final Color? collapseBackgroundColor;
  /// To space item from its leading and trailing icons
  final double? spacingBtwTextAndIcon;
  /// Items trailing icon if not null
  final Icon? childrenTrailingIcon;
  /// Items leading icon if not null
  final Icon? childrenLeadingIcon;
  ExpansionList({
    Key? key,
    this.items,
    this.title,
    @required this.onItemSelected,
    this.smallVersion = false,
    this.childrenAlignment,
    this.titleAlignment,
    this.icon,
    this.childrenTrailingIcon,
    this.childrenLeadingIcon,
    this.height = 40,
    this.dividerColor,
    this.textStyle,
    this.backgroundColor,
    this.collapseBackgroundColor,
    this.spacingBtwTextAndIcon, this.width = 100,
  }) : super(key: key);

  _ExpansionListState createState() => _ExpansionListState();
}

class _ExpansionListState extends State<ExpansionList> {
  // final double startingHeight = 40;
  double? expandedHeight;
  bool expanded = false;
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.title;
    _calculateExpandedHeight();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(0),
      color: expanded
          ? widget.backgroundColor ?? Colors.white
          : widget.collapseBackgroundColor ?? Colors.white,
      child: AnimatedContainer(
        // padding: sharedStyles.fieldPadding,
        duration: const Duration(milliseconds: 180),
        height: expanded
            ? expandedHeight
            : widget.smallVersion
            ? 30
            : widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: expanded
              ? widget.backgroundColor ?? Colors.white
              : widget.collapseBackgroundColor ?? Colors.white,
          boxShadow: expanded
              ? [BoxShadow(blurRadius: 10, color: Colors.grey[300]!)]
              : null,
        ),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            ExpansionListItem(
              height: widget.height,
              title: selectedValue,
              textStyle: widget.textStyle,
              onTap: () {
                setState(() {
                  expanded = !expanded;
                });
              },
              showArrow: true,
              smallVersion: widget.smallVersion,
              mainAxisAlignment: widget.titleAlignment,
              icon: widget.icon,
            ),
            Container(
              height: 2,
              color: widget.dividerColor ?? Colors.grey[300],
            ),
            ..._getDropdownListItems()
          ],
        ),
      ),
    );
  }

  List<Widget> _getDropdownListItems() {
    return widget.items!
        .map((item) => ExpansionListItem(
        isChildren: true,
        itemSpacing: widget.spacingBtwTextAndIcon,
        height: widget.height,
        textStyle: widget.textStyle,
        smallVersion: widget.smallVersion,
        mainAxisAlignment:
        widget.childrenAlignment ?? MainAxisAlignment.start,
        leadingIcon: widget.childrenLeadingIcon,
        title: item.toString(),
        icon: widget.childrenTrailingIcon,
        showArrow: widget.childrenTrailingIcon == null ? false : true,
        onTap: () {
          setState(() {
            expanded = !expanded;
            selectedValue = item.toString();
          });

          widget.onItemSelected!(item);
        }))
        .toList();
  }

  void _calculateExpandedHeight() {
    expandedHeight = 2.0 +
        (widget.smallVersion ? 30 : widget.height) +
        (widget.items!.length * (widget.smallVersion ? 30 : widget.height));
  }
}

class ExpansionListItem extends StatelessWidget {
  final Function()? onTap;
  final String? title;
  final TextStyle? textStyle;
  final bool showArrow;
  final bool smallVersion;
  final MainAxisAlignment? mainAxisAlignment;
  final Icon? icon;
  final Icon? leadingIcon;
  final double? itemSpacing;
  final double height;
  final bool isChildren;
  const ExpansionListItem({
    Key? key,
    this.onTap,
    this.title,
    this.showArrow = false,
    this.smallVersion = false,
    this.mainAxisAlignment,
    this.icon,
    this.leadingIcon,
    required this.height,
    this.textStyle,
    this.itemSpacing,
    this.isChildren = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: smallVersion ? 30 : height,
        alignment: Alignment.centerLeft,
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment:
          mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
          children: <Widget>[
            leadingIcon ?? Container(),
            leadingIcon != null
                ? SizedBox(
              width: 10,
            )
                : Container(),
            Text(
              title ?? '',
              style: textStyle ??

                    TextStyle(
                      color: Colors.black,
                      fontSize: smallVersion ? 10 : 12,
                      fontWeight: FontWeight.bold,

                  ),
            ),
            isChildren
                ? SizedBox(
              width: itemSpacing ?? 10,
            )
                : Container(),
            showArrow
                ? icon ??
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black87,
                  size: smallVersion ? 15 : 20,
                )
                : Container(),
          ],
        ),
      ),
    );
  }
}
