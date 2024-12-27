import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({super.key, required this.activePage});
  final String activePage;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HeaderButton(
          activePage: widget.activePage,
          route: '/',
          title: 'Characters',
        ),
        HeaderButton(
          activePage: widget.activePage,
          route: '/episodes',
          title: 'Episodes',
        ),
        HeaderButton(
          activePage: widget.activePage,
          route: '/locations',
          title: 'Locations',
        ),
      ],
    );
  }
}

class HeaderButton extends StatefulWidget {
  const HeaderButton(
      {super.key,
      required this.activePage,
      required this.route,
      required this.title});

  final String route;
  final String title;
  final String activePage;

  @override
  State<HeaderButton> createState() => _HeaderButtonState();
}

class _HeaderButtonState extends State<HeaderButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, widget.route);
      },
      child: Container(
          height: 80,
          color: Colors.black,
          child: Center(
              child: Text(
            widget.title,
            style: TextStyle(
                color: widget.activePage == widget.title
                    ? Colors.yellow
                    : Colors.white),
          ))),
    ));
  }
}
