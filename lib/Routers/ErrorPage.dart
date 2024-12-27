import 'package:flutter/cupertino.dart';

import '../presentation/common_widget/common_widget.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: reausabletext("No Router Found"),);
  }
}
