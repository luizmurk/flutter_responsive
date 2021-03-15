import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../constants.dart';
import 'counter_badge.dart';

class SideMenuItem extends StatefulWidget {
  const SideMenuItem({
    Key key,
    this.isActive,
    this.activeTitle,
    this.itemCount,
    this.showBorder = false,
    @required this.iconSrc,
    @required this.title,
    @required this.press,
  }) : super(key: key);

  final int itemCount;
  final String iconSrc, title, activeTitle;
  final VoidCallback press;
  final bool isActive, showBorder;

  @override
  _SideMenuItemState createState() => _SideMenuItemState();
}

class _SideMenuItemState extends State<SideMenuItem> {
  bool isHover;
  bool activeHover;
  bool activated;
  //String activeTitle;

  @override
  Widget build(BuildContext context) {
    (widget.title == widget.activeTitle) ? activated = true : activated = false;
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: InkWell(
        onTap: widget.press,
        onHover: (activeHover) {
          if (activeHover) {
            //The mouse is hovering.
            //print(activeHover);
            setState(() {
              //print('hovering');
              isHover = true;
            });
          } else {
            //The mouse is no longer hovering.
            setState(() {
              // print('Done hovering');
              isHover = false;
            });
          }
        },
        hoverColor: kTextColor,
        child: Row(
          children: [
            (widget.isActive || isHover)
                ? WebsafeSvg.asset(
                    "assets/Icons/Angle right.svg",
                    width: 15,
                  )
                : SizedBox(width: 15),
            SizedBox(width: kDefaultPadding / 4),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 15, right: 5),
                decoration: widget.showBorder
                    ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFDFE2EF)),
                        ),
                      )
                    : null,
                child: Row(
                  children: [
                    Container(
                      //margin: EdgeInsets.all(100.0),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color:
                              (activated || isHover) ? kTextColor : kGrayColor,
                          shape: BoxShape.circle),
                    ),
                    SizedBox(width: kDefaultPadding * 0.75),
                    Text(widget.title,
                        style: TextStyle(
                          color:
                              (activated || isHover) ? kTextColor : kGrayColor,
                          fontFamily: 'Varela Round',
                          fontSize: (activated || isHover) ? 15 : 13,
                        )),
                    Spacer(),
                    if (widget.itemCount != null)
                      CounterBadge(count: widget.itemCount)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
