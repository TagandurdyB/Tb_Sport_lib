import 'package:flutter/material.dart';
import '/ViewModel/Providers/provider_theme.dart';

import 'my_container.dart';

class ActionTeam {
  final Function? func;
  final String text;
  final bool canPop;
  final Widget? child;
  ActionTeam({
    this.func,
    this.child,
    this.text = "",
    this.canPop = true,
  });
}

class MyPopUpp {
  final double? width;
  final double? height;
  final double? shape;
  Color? bgColor;
  final String title;
  final bool centerTitle;
  final Widget? content;
  final List<ActionTeam>? actions;
  MyPopUpp({
    this.content,
    this.centerTitle = true,
    this.width,
    this.height,
    this.title = "Title",
    this.shape,
    this.bgColor,
    this.actions,
  });
  late BuildContext context;
  void pop(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        bgColor = bgColor ?? DistributorTheme(context).colors.myPop;
        this.context = context;
        return Center(child: buildPop());
      });

  Widget buildPop() => MyContainer(
      shape: shape ?? 0,
      width: width,
      height: height,
      color: bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              color: Colors.transparent,
              child: Text(
                title,
                textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                style: DistributorTheme(context).styles.popTitle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(color: bgColor, child: content ?? const SizedBox()),
          ),
          PopBtns(actions: actions),
        ],
      ));
}

// ignore: must_be_immutable
class PopBtns extends StatelessWidget {
  final List<ActionTeam>? actions;
  final bool isPopEnable;
  PopBtns({super.key, this.actions, this.isPopEnable = true});
  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return buildBtns();
  }

  Widget buildBtns() => actions == null || actions!.isEmpty
      ? const SizedBox()
      : Row(
          children: List.generate(actions!.length,
              (index) => Expanded(child: buildBtn(actions![index]))));

  Widget buildBtn(ActionTeam obj) {
    if (obj.child != null) {
      return GestureDetector(onTap: () => _tabFunc(obj), child: obj.child!);
    } else if (obj.text != "") {
      return MaterialButton(
          onPressed: () => _tabFunc(obj),
          child: Text(
            obj.text,
            style: DistributorTheme(context).styles.popAction,
          ));
    } else {
      return const SizedBox();
    }
  }

  void _tabFunc(ActionTeam obj) {
    if (obj.func != null) {
      obj.func!();
    }
    if (isPopEnable && obj.canPop) {
      Navigator.pop(context);
    }
  }
}
