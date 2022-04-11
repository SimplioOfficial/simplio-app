import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simplio_app/config/projects.dart';

import 'package:simplio_app/view/widgets/project_toggle_item.dart';

void main() {
  testWidgets('Toggle item test', (WidgetTester tester) async {
    const testWidget = ProjectToggleItem(
      project: Projects.bitcoin,
      toggled: false,
    );

    await tester.pumpWidget(wrap(child: wrap2(child: testWidget)));
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Switch && widget.value == false),
        findsOneWidget);
    expect(find.text('Bitcoin'), findsOneWidget);
    expect(find.text('Solana'), findsNothing);

    // Try with another coin
    const testWidget2 = ProjectToggleItem(
      project: Projects.solana,
      toggled: true,
    );
    await tester.pumpWidget(wrap(child: wrap2(child: testWidget2)));
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Switch && widget.value == true),
        findsOneWidget);
    expect(find.text('Solana'), findsOneWidget);
  });
}

Widget wrap({Widget? child}) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: MediaQuery(
      data: const MediaQueryData(),
      child: Center(child: child),
    ),
  );
}

Widget wrap2({Widget? child}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Material(
          child: Center(child: child),
        );
      },
    ),
  );
}
