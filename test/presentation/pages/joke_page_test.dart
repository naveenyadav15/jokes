import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jokes/presentation/cubit/random_joke/random_joke.cubit.dart';
import 'package:jokes/presentation/cubit/search_joke/search_joke.cubit.dart';
import 'package:jokes/presentation/pages/joke_page.dart';
import 'package:mocktail/mocktail.dart';

class MockRandomJokeCubit extends Mock implements RandomJokeCubit {}

class MockSearchJokeCubit extends Mock implements SearchJokeCubit {}

void main() {
  late MockRandomJokeCubit mockRandomJokeCubit;
  late MockSearchJokeCubit mockSearchJokeCubit;

  setUp(() {
    mockRandomJokeCubit = MockRandomJokeCubit();
    mockSearchJokeCubit = MockSearchJokeCubit();
  });

  Widget createWidgetUnderTest() {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: mockRandomJokeCubit),
        BlocProvider.value(value: mockSearchJokeCubit),
      ],
      child: const MaterialApp(
        home: JokePage(),
      ),
    );
  }

  testWidgets('renders Random Joke section', (WidgetTester tester) async {
    when(() => mockRandomJokeCubit.state).thenReturn(RandomJokeLoading());
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders Search Joke section', (WidgetTester tester) async {
    when(() => mockSearchJokeCubit.state).thenReturn(SearchJokeLoading());
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
