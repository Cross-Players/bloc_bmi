import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/core/widgets/custom_text.dart';

class CustomDrop extends StatelessWidget {
  const CustomDrop({
    super.key,
    required this.items,
    required this.onChanged,
    required this.value,
  });
  final List<String> items;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final Offset offset = box.localToGlobal(Offset.zero);
        final selected = await showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(
            offset.dx,
            offset.dy + box.size.height,
            offset.dx + box.size.width,
            offset.dy,
          ),
          items:
              items
                  .map((e) => PopupMenuItem<String>(value: e, child: Text(e)))
                  .toList(),
        );
        if (selected != null) {
          onChanged(selected);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        width: width / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 0,
              blurRadius: 6,
              offset: const Offset(0, -1), // Shadow phía trên
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomText(text: value),
            SizedBox(width: 5),
            FaIcon(FontAwesomeIcons.caretDown, size: 15),
          ],
        ),
      ),
    );
  }
}
