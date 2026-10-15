import 'package:flutter_test/flutter_test.dart';
import 'package:app/main.dart';
import 'package:app/screens/profile_screen.dart';

void main() {
  testWidgets('App loads ProfileScreen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(MyApp), findsOneWidget);
    expect(find.byType(ProfileScreen), findsOneWidget);
  });
}
