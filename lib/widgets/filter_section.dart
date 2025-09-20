import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:smart_house_app/widgets/badge_button.dart';

class FilterSection extends StatefulWidget {
  final List<String> filters;
  final ValueChanged<int>? onSelected;

  const FilterSection({
    super.key,
    required this.filters,
    this.onSelected,
  });

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.all(4),
        child: Row(
            spacing: 4,
            children: [
              Icon(
                CupertinoIcons.color_filter,
                color: Colors.grey[300],
              ),
              Text(
                "Filtros",
                style: TextStyle(
                    color: Colors.grey[300]
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: AnimationLimiter(
            child: Row(
              children: List.generate(widget.filters.length, (index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 250),
                  child: SlideAnimation(
                    horizontalOffset: 20.0,
                    child: FadeInAnimation(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: BadgeButton(
                          selected: selectedIndex == index,
                          label: widget.filters[index],
                          onClick: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            if (widget.onSelected != null) {
                              widget.onSelected!(index);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          )
        )
      ],
    );
  }
}