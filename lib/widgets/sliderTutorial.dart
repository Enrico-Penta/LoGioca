import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sizer/sizer.dart';

class TutorialSlider extends StatefulWidget {
  final void Function(int) setField;
  List<Widget> itemList;
  TutorialSlider({this.setField, this.itemList});

  @override
  TutorialSliderState createState() => TutorialSliderState();
}

class TutorialSliderState extends State<TutorialSlider> {
  int _current = 0;
  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    /*indice = widget.photoIndex;
    if (indice == -1 || indice >= widget.photoSlider.length) {
      indice = 0;
    }*/

    return Column(
      key: Key(DateTime.now().toString()),
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: CarouselSlider(
            carouselController: controller,
            options: CarouselOptions(
                initialPage: _current,
                autoPlay: false,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                  widget.setField(_current);
                }),
            items: widget.itemList,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.itemList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
