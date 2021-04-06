import 'package:flutter/material.dart';

class MyTextField {
  MyTextField({
    this.validator,
    this.enabled = true,
    this.autoCorrect = true,
    this.keyboardType = TextInputType.text,
    this.autoFocus = false,
    this.isTextArea = false,
    this.obscureText = false,
    this.maxLength,
  });

  final bool autoCorrect;
  final bool autoFocus;
  bool enabled;
  final FocusNode focusNode = FocusNode();
  final bool isTextArea;
  final TextInputType keyboardType;
  final int maxLength;
  final bool obscureText;

  final TextEditingController _controller = TextEditingController();

  final String Function(String) validator;
  final GlobalKey toolKey = new GlobalKey();

  Widget build({
    IconData icon,
    @required BuildContext context,
    FocusNode next,
    @required String labelText,
    String toolTip,
    bool iconLeft = true,
    Function(String) onChanged,
    bool disabled = false,
  }) {
    List<Widget> iconToolTip = [];
    if (toolTip != null)
      iconToolTip.add(
        IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            final dynamic tooltip = toolKey.currentState;
            tooltip.ensureTooltipVisible();
          },
        ),
      );

    ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
              iconLeft && icon != null
                  ? Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        icon,
                        color: theme.brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    )
                  : Container(),
              Expanded(
                child: Tooltip(
                  margin: EdgeInsets.only(left: 45, right: 60),
                  padding: EdgeInsets.all(5),
                  key: toolKey,
                  message: toolTip ?? "",
                  child: TextFormField(
                    cursorWidth: 3,
                    cursorColor: theme.primaryColor,
                    controller: _controller,
                    focusNode: focusNode,
                    onChanged: (value) {
                      if (onChanged != null) onChanged(value);
                    },
                    validator: (value) => validator(value),
                    enabled: enabled && !disabled,
                    onEditingComplete: () {
                      if (onChanged != null) onChanged(_controller.text);
                    },
                    maxLines: isTextArea ? null : 1,
                    autocorrect: autoCorrect,
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(),
                      labelText: labelText,
                    ),
                    autofocus: autoFocus,
                    obscureText: obscureText,
                    maxLength: maxLength,
                    textInputAction: next == null
                        ? TextInputAction.done
                        : TextInputAction.next,
                    onFieldSubmitted: (val) {
                      focusNode.unfocus();
                      if (next != null)
                        FocusScope.of(context).requestFocus(next);
                    },
                  ),
                ),
              ),
              iconLeft
                  ? Container()
                  : Icon(
                      icon,
                      color: theme.primaryColor,
                    )
            ] +
            iconToolTip,
      ),
    );
  }

  String get text => _controller.text;

  set text(String text) => _controller.text = text;
}
