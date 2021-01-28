import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';

/// Scaffold.
class MpScaffold extends StatelessWidget {
  final Widget appBar;
  final Widget body;
  final Widget bottomNavigationBar;

  MpScaffold({this.appBar, @required this.body, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.appBar,
      body: this.body,
      bottomNavigationBar: this.bottomNavigationBar,
    );
  }
}

/// Page router.
PageRoute mpPageRoute({Widget Function(BuildContext) builder}) {
  return MaterialPageRoute(
    builder: builder,
  );
}

/// AppBar.
class MpAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget button;

  @override
  final Size preferredSize;

  MpAppBar({
    this.title,
    this.button,
    this.preferredSize = const Size.fromHeight(56.0),
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: [
        (button != null) ? button : SizedBox(),
      ],
    );
  }
}

/// Button.
class MpButton extends StatelessWidget {
  MpButton({this.label, this.onPressed});
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
    );
  }
}

/// Link button.
class MpLinkButton extends StatelessWidget {
  MpLinkButton({this.label, this.onPressed});
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(label),
      onPressed: onPressed,
    );
  }
}

/// Round button with icon.
class RoundIconButton extends StatelessWidget {
  RoundIconButton({
    this.icon,
    this.fillColor,
    @required this.onPressed,
  });

  final IconData icon;
  final Function onPressed;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      onPressed: onPressed,
      elevation: 0.0,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: this.fillColor,
    );
  }
}

/// FlatButton.
class MpFlatButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final EdgeInsetsGeometry padding;
  final Widget child;

  MpFlatButton({
    this.label,
    this.onPressed,
    this.padding,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: padding,
      onPressed: onPressed,
      child: child,
    );
  }
}

/// Text field.
class MpTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final List<TextInputFormatter> inputFormatters;
  final bool readOnly;

  MpTextField({
    @required this.controller,
    this.labelText,
    this.inputFormatters,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
      ),
      inputFormatters: inputFormatters,
      readOnly: readOnly,
    );
  }
}

/// Switch.
class MpSwitch extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Function onTap;

  MpSwitch(
      {@required this.title,
      @required this.value,
      @required this.onChanged,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
      onTap: onTap,
    );
  }
}

/// Validation message.
class MpValidationMessage extends StatelessWidget {
  final String message;

  MpValidationMessage({@required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            this.message,
            textScaleFactor: 0.8,
            style: TextStyle(color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}

/// Radio selector
// ignore: todo
//TODO: Delete it.
Widget mpSelectFromTwo({
  BuildContext context,
  @required dynamic value1,
  @required dynamic value2,
  @required dynamic groupValue,
  @required void Function(dynamic) onChanged,
  @required String itemText1,
  @required String itemText2,
}) {
  return Row(
    children: [
      Radio(
        value: value1,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
      Text(itemText1),
      Radio(
        value: value2,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
      Text(itemText2),
    ],
  );
}

/// GroupSelect(Radio)
/// class NativeGroupSelect<T> from native_widgets
class MpGroupSelect<T> extends StatelessWidget {
  final ValueChanged<T> onValueChanged;
  final Map<T, Widget> children;
  final T groupValue;

  MpGroupSelect({
    Key key,
    this.onValueChanged,
    @required this.groupValue,
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: children.entries
            .map((MapEntry<T, Widget> item) => RadioListTile<T>(
                  title: item?.value,
                  value: item?.key,
                  groupValue: groupValue,
                  onChanged: onValueChanged,
                ))
            .toList());
  }
}

// ListTile
class MpListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final Function onTap;
  final Function onLongPress;

  MpListTile({
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb && (Platform.isMacOS || Platform.isIOS)) {
      return CupertinoListTile(
        leading: this.leading,
        title: this.title,
        subtitle: this.subtitle,
        trailing: this.trailing,
        onTap: this.onTap,
        onLongPress: this.onLongPress,
      );
    } else {
      return ListTile(
        leading: this.leading,
        title: this.title,
        subtitle: this.subtitle,
        trailing: this.trailing,
        onTap: this.onTap,
        onLongPress: this.onLongPress,
      );
    }
  }
}

Future<T> mpModalPopup<T>({
  BuildContext context,
  Widget child,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) => child,
  );
}
