import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExpandableListWidget extends StatefulWidget {
  final Widget title;
  final BoxDecoration borderDecoration;
  final Color headerColor;
  final Color headerBackColor;
  final int validItemCount;
  final double rowHeight;
  final List<Widget> listItems;

  const ExpandableListWidget({Key key, 
    this.title, 
    this.borderDecoration,
    this.headerColor, 
    this.headerBackColor, 
    this.validItemCount = 1, 
    this.rowHeight,
    this.listItems}) : super(key: key);

  @override
  _ExpandableListWidgetState createState() => _ExpandableListWidgetState();
}

class _ExpandableListWidgetState extends State<ExpandableListWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            decoration: widget.borderDecoration,
            height: widget.rowHeight,
            color: widget.headerBackColor,
            padding: EdgeInsets.only(left: 10, right: 5),
            child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  widget.title,
                  Container(
                    width: 25,
                    height: 25,
                    margin: EdgeInsets.only(right: 10),
                    alignment: Alignment.bottomCenter,
                    child: Icon(_expanded ? Icons.expand_more : Icons.expand_less, 
                      color: widget.headerColor, 
                      size: 25.0),
                  ),
                ],
              ),
              onTap: () => setState(() =>  _expanded = !_expanded),
            )
          ),
          _ExpandableContainer(
            expanded: _expanded,
            rowHeight: widget.rowHeight,
            itemCount: widget.validItemCount,
            child: ListView(
              children: widget.listItems,
            )
          )
        ],
      ),
    );
  }
}

class _ExpandableContainer extends StatelessWidget {
  final Widget child;
  final bool expanded;
  final int itemCount;
  final double rowHeight;

  _ExpandableContainer({
    @required this.child,
    this.expanded = true,
    this.itemCount,
    this.rowHeight = 50,
  });

  @override
  Widget build(BuildContext context) {
    double _collapsedHeight = 0;
    double _expandedHeight = this.itemCount * rowHeight + this.itemCount;

    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? _expandedHeight : _collapsedHeight,
      child: Container(
        child: child,
      ),
    );
  }
}