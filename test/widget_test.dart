import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jokes/main.dart';

void main() {
  testWidgets('JokePage has a title and displays a joke',
      (WidgetTester tester) async {
    // Build the JokePage widget
    await tester.pumpWidget(const MyApp());

    // Verify the title is displayed
    expect(find.text('Random Joke'), findsOneWidget);

    // Verify that initial state shows the text for pressing the button to get a joke
    expect(find.text('Press the button to get a joke!'), findsOneWidget);

    // Tap the FloatingActionButton to fetch a random joke
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    // Check if the CircularProgressIndicator is shown while loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
