import 'package:flutter_test/flutter_test.dart';
import 'package:aswat_al_quloob/app.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const AswatAlQuloobApp());
    await tester.pump();
    // The root page should show either onboarding or settings.
    expect(find.byType(AswatAlQuloobApp), findsOneWidget);
  });
}
