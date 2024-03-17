import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/entities/todo_color.dart';
import 'package:todo_app/application/pages/create_todo_collection/bloc/cubit/create_todo_collection_page_cubit.dart';

class ToDoCollectionColorPicker extends StatefulWidget {
  ToDoCollectionColorPicker({super.key});

  final Map<ColorSwatch<Object>, String> customSwatches = {
    for (var color in ToDoColor.predefinedColors.map(
      (color) => ColorTools.createPrimarySwatch(color),
    ))
      color: color.toString()
  };

  @override
  State<ToDoCollectionColorPicker> createState() =>
      _ToDoCollectionColorPickerState();
}

class _ToDoCollectionColorPickerState extends State<ToDoCollectionColorPicker> {
  Color toDoCollectionPickerColor = Colors.red;
  late Color toDoCollectionSelectColor;

  final Map<ColorSwatch<Object>, String> customSwatches =
      <ColorSwatch<Object>, String>{
    const MaterialColor(0xFFfae738, <int, Color>{
      50: Color(0xFFfffee9),
      100: Color(0xFFfff9c6),
      200: Color(0xFFfff59f),
      300: Color(0xFFfff178),
      400: Color(0xFFfdec59),
      500: Color(0xFFfae738),
      600: Color(0xFFf3dd3d),
      700: Color(0xFFdfc735),
      800: Color(0xFFcbb02f),
      900: Color(0xFFab8923),
    }): 'Alpine',
    ColorTools.createPrimarySwatch(const Color(0xFFBC350F)): 'Rust',
    ColorTools.createAccentSwatch(const Color(0xFFB062DB)): 'Lavender',
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ListTile(
            title: const Text(
              'Select one of the colors below to change this color',
            ),
            subtitle: Text(
                '${ColorTools.materialNameAndCode(toDoCollectionPickerColor)} '
                'aka ${ColorTools.nameThatColor(toDoCollectionPickerColor)}'),
            trailing: ColorIndicator(
              width: 44,
              height: 44,
              borderRadius: 22,
              color: toDoCollectionPickerColor,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Card(
                elevation: 2,
                child: ColorPicker(
                  color: toDoCollectionPickerColor,
                  enableShadesSelection: false,
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.both: false,
                    ColorPickerType.primary: false,
                    ColorPickerType.accent: false,
                    ColorPickerType.bw: false,
                    ColorPickerType.custom: true,
                    ColorPickerType.wheel: false,
                  },
                  width: 44,
                  height: 44,
                  borderRadius: 22,
                  heading: Text(
                    'Select color',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onColorChanged: (Color color) {
                    setState(() => toDoCollectionPickerColor = color);
                    context
                        .read<CreateToDoCollectionPageCubit>()
                        .colorChanged(color);
                  },
                  customColorSwatchesAndNames: widget.customSwatches,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
