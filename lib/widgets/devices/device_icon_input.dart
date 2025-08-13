import 'package:flutter/material.dart';
import 'package:smart_house_app/models/icon_model.dart';
import 'package:smart_house_app/theme/app_colors.dart';

class DeviceIconInput extends StatefulWidget {
  final void Function(int selectedIndex)? onChanged;

  const DeviceIconInput({
    super.key,
    required this.onChanged
  });

  @override
  State<DeviceIconInput> createState() => _DeviceIconInputState();
}

class _DeviceIconInputState extends State<DeviceIconInput> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.outline,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Ícone",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 80,
            child: Center(
              child: SizedBox(
                width: 288,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    bool isSelected = index == selectedIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        widget.onChanged?.call(selectedIndex);
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: isSelected ? AppColors.primary : AppColors.inputBackground,
                        child: Icon(
                          getIcon(index),
                          size: 32,
                          color: isSelected ? Colors.white : AppColors.gray,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
