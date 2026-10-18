import '../models/question.dart';

final Map<String, List<Question>> categoryQuestions = {
  // 1. Flutter Questions (10 questions)
  'flutter': [
    const Question(
      questionText: 'What is the main language used in Flutter development?',
      options: ['Java', 'Dart', 'Kotlin', 'Swift'],
      correctAnswerIndex: 1,
      categoryId: 'flutter',
    ),
    const Question(
      questionText: 'What is the output of this code?',
      codeSnippet: 'void main() {\n  print(1 + 2 + 3);\n}',
      options: ['6', '5', '3', '1'],
      correctAnswerIndex: 0,
      categoryId: 'flutter',
    ),
    const Question(
      questionText:
          'Which widget is best suited for creating a scrollable list of variable length items efficiently?',
      options: [
        'Column',
        'ListView.builder',
        'SingleChildScrollView',
        'Row'
      ],
      correctAnswerIndex: 1,
      categoryId: 'flutter',
    ),
    const Question(
      questionText:
          'Which method is called only once when a StatefulWidget is inserted into the widget tree?',
      options: ['build()', 'initState()', 'dispose()', 'setState()'],
      correctAnswerIndex: 1,
      categoryId: 'flutter',
    ),
    const Question(
      questionText:
          'What is the purpose of the pubspec.yaml file in a Flutter project?',
      options: [
        'Compile native C++ code',
        'Manage dependencies and project assets',
        'Define UI layouts directly',
        'Handle database migrations'
      ],
      correctAnswerIndex: 1,
      categoryId: 'flutter',
    ),
    const Question(
      questionText:
          'Which widget should you use to position a child widget relative to its parent edges with exact coordinates?',
      options: ['Positioned', 'SizedBox', 'Container', 'Padding'],
      correctAnswerIndex: 0,
      categoryId: 'flutter',
    ),
    const Question(
      questionText:
          'What is the command to create a new Flutter application from the terminal?',
      options: [
        'flutter start app',
        'flutter new app',
        'flutter create app',
        'flutter init app'
      ],
      correctAnswerIndex: 2,
      categoryId: 'flutter',
    ),
    const Question(
      questionText:
          'What is the primary difference between StatelessWidget and StatefulWidget?',
      options: [
        'StatelessWidget cannot have child widgets',
        'StatefulWidget can rebuild dynamically when state changes',
        'StatelessWidget has no BuildContext',
        'StatefulWidget runs on a background isolate'
      ],
      correctAnswerIndex: 1,
      categoryId: 'flutter',
    ),
    const Question(
      questionText:
          'Which widget provides standard Material Design visual structure like AppBar and FloatingActionButton?',
      options: ['Scaffold', 'MaterialApp', 'SafeArea', 'Card'],
      correctAnswerIndex: 0,
      categoryId: 'flutter',
    ),
    const Question(
      questionText:
          'In Flutter, what does Hot Reload do during application development?',
      options: [
        'Rebuilds the entire app from scratch',
        'Injects updated source code without losing app state',
        'Reinstalls the app binary on device',
        'Clears application memory and restarts'
      ],
      correctAnswerIndex: 1,
      categoryId: 'flutter',
    ),
  ],

  // 2. Dart Questions (10 questions)
  'dart': [
    const Question(
      questionText: 'What is the output of this code?',
      codeSnippet: 'void main() {\n  var name = \'Dart\';\n  print(name.length);\n}',
      options: ['3', '4', '5', 'null'],
      correctAnswerIndex: 1,
      categoryId: 'dart',
    ),
    const Question(
      questionText:
          'Which keyword is used to declare a variable whose value cannot be reassigned after initialization?',
      options: ['var', 'final', 'dynamic', 'static'],
      correctAnswerIndex: 1,
      categoryId: 'dart',
    ),
    const Question(
      questionText: 'What is the output of this null-aware expression?',
      codeSnippet:
          'void main() {\n  String? title;\n  print(title ?? \'Untitled\');\n}',
      options: ['null', 'Untitled', 'title', 'Compile error'],
      correctAnswerIndex: 1,
      categoryId: 'dart',
    ),
    const Question(
      questionText:
          'Which collection type in Dart contains only unique elements?',
      options: ['List', 'Set', 'Map', 'Queue'],
      correctAnswerIndex: 1,
      categoryId: 'dart',
    ),
    const Question(
      questionText:
          'What keyword is used in Dart to wait for an asynchronous Future to complete?',
      options: ['await', 'yield', 'defer', 'async'],
      correctAnswerIndex: 0,
      categoryId: 'dart',
    ),
    const Question(
      questionText: 'What is the output of this code?',
      codeSnippet:
          'void main() {\n  var list = [10, 20, 30];\n  print(list.reversed.first);\n}',
      options: ['10', '20', '30', 'null'],
      correctAnswerIndex: 2,
      categoryId: 'dart',
    ),
    const Question(
      questionText:
          'Which keyword is used to mix in code from another class in Dart?',
      options: ['implements', 'extends', 'with', 'mixin'],
      correctAnswerIndex: 2,
      categoryId: 'dart',
    ),
    const Question(
      questionText: 'What will this integer division code print?',
      codeSnippet: 'void main() {\n  int a = 10;\n  int b = 3;\n  print(a ~/ b);\n}',
      options: ['3.33', '3', '1', '3.0'],
      correctAnswerIndex: 1,
      categoryId: 'dart',
    ),
    const Question(
      questionText:
          'What does the late keyword indicate in Dart null safety?',
      options: [
        'The variable is always nullable',
        'The variable is initialized lazily before access',
        'The variable is constant at compile time',
        'The variable runs on a separate thread'
      ],
      correctAnswerIndex: 1,
      categoryId: 'dart',
    ),
    const Question(
      questionText:
          'Which constructor syntax creates an unmodifiable instance when combined with const?',
      options: [
        'Factory constructor',
        'Constant constructor',
        'Named constructor',
        'Redirecting constructor'
      ],
      correctAnswerIndex: 1,
      categoryId: 'dart',
    ),
  ],

  // 3. General Knowledge (10 questions)
  'general_knowledge': [
    const Question(
      questionText: 'Which planet in our solar system is known as the Red Planet?',
      options: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
      correctAnswerIndex: 1,
      categoryId: 'general_knowledge',
    ),
    const Question(
      questionText: 'What is the largest ocean on Earth by surface area?',
      options: [
        'Atlantic Ocean',
        'Indian Ocean',
        'Pacific Ocean',
        'Arctic Ocean'
      ],
      correctAnswerIndex: 2,
      categoryId: 'general_knowledge',
    ),
    const Question(
      questionText: 'Who painted the famous Renaissance portrait Mona Lisa?',
      options: [
        'Vincent van Gogh',
        'Leonardo da Vinci',
        'Pablo Picasso',
        'Claude Monet'
      ],
      correctAnswerIndex: 1,
      categoryId: 'general_knowledge',
    ),
    const Question(
      questionText: 'What is the capital city of Japan?',
      options: ['Kyoto', 'Osaka', 'Tokyo', 'Hiroshima'],
      correctAnswerIndex: 2,
      categoryId: 'general_knowledge',
    ),
    const Question(
      questionText: 'In which year did the famous passenger ship Titanic sink?',
      options: ['1910', '1912', '1915', '1920'],
      correctAnswerIndex: 1,
      categoryId: 'general_knowledge',
    ),
    const Question(
      questionText: 'What is the hardest naturally occurring substance on Earth?',
      options: ['Gold', 'Iron', 'Diamond', 'Platinum'],
      correctAnswerIndex: 2,
      categoryId: 'general_knowledge',
    ),
    const Question(
      questionText: 'Which country has the largest land area in the world?',
      options: ['Canada', 'China', 'Russia', 'United States'],
      correctAnswerIndex: 2,
      categoryId: 'general_knowledge',
    ),
    const Question(
      questionText: 'How many continents are there on planet Earth?',
      options: ['5', '6', '7', '8'],
      correctAnswerIndex: 2,
      categoryId: 'general_knowledge',
    ),
    const Question(
      questionText:
          'Who is recognized as the inventor of the World Wide Web (WWW)?',
      options: [
        'Bill Gates',
        'Tim Berners-Lee',
        'Steve Jobs',
        'Alan Turing'
      ],
      correctAnswerIndex: 1,
      categoryId: 'general_knowledge',
    ),
    const Question(
      questionText: 'What is the official currency of the United Kingdom?',
      options: ['Euro', 'US Dollar', 'Pound Sterling', 'Swiss Franc'],
      correctAnswerIndex: 2,
      categoryId: 'general_knowledge',
    ),
  ],

  // 4. Mathematics (10 questions)
  'mathematics': [
    const Question(
      questionText: 'What is the value of 7 multiplied by 8?',
      options: ['54', '56', '58', '62'],
      correctAnswerIndex: 1,
      categoryId: 'mathematics',
    ),
    const Question(
      questionText: 'What is the square root of 144?',
      options: ['10', '11', '12', '14'],
      correctAnswerIndex: 2,
      categoryId: 'mathematics',
    ),
    const Question(
      questionText: 'If 3x + 5 = 20, what is the value of x?',
      options: ['3', '5', '7', '15'],
      correctAnswerIndex: 1,
      categoryId: 'mathematics',
    ),
    const Question(
      questionText:
          'What is the sum of interior angles in any Euclidean triangle?',
      options: ['90°', '180°', '270°', '360°'],
      correctAnswerIndex: 1,
      categoryId: 'mathematics',
    ),
    const Question(
      questionText:
          'What is the next number in the Fibonacci sequence: 1, 1, 2, 3, 5, 8, ...?',
      options: ['11', '13', '15', '17'],
      correctAnswerIndex: 1,
      categoryId: 'mathematics',
    ),
    const Question(
      questionText: 'What is 25% of 200?',
      options: ['25', '40', '50', '75'],
      correctAnswerIndex: 2,
      categoryId: 'mathematics',
    ),
    const Question(
      questionText:
          'What is the perimeter of a rectangle with length 8 and width 5?',
      options: ['13', '26', '40', '28'],
      correctAnswerIndex: 1,
      categoryId: 'mathematics',
    ),
    const Question(
      questionText: 'What is the value of 2 to the power of 5 (2⁵)?',
      options: ['16', '25', '32', '64'],
      correctAnswerIndex: 2,
      categoryId: 'mathematics',
    ),
    const Question(
      questionText: 'Which of the following numbers is a prime number?',
      options: ['9', '15', '17', '21'],
      correctAnswerIndex: 2,
      categoryId: 'mathematics',
    ),
    const Question(
      questionText: 'What is the result of (15 ÷ 3) + (4 × 2)?',
      options: ['11', '13', '18', '26'],
      correctAnswerIndex: 1,
      categoryId: 'mathematics',
    ),
  ],

  // 5. English (10 questions)
  'english': [
    const Question(
      questionText: 'Which of the following is a synonym for Abundant?',
      options: ['Scarce', 'Plentiful', 'Tiny', 'Empty'],
      correctAnswerIndex: 1,
      categoryId: 'english',
    ),
    const Question(
      questionText: 'Choose the correct past tense of the verb sing:',
      options: ['Singed', 'Sang', 'Sung', 'Song'],
      correctAnswerIndex: 1,
      categoryId: 'english',
    ),
    const Question(
      questionText: 'What does the popular idiom Piece of cake mean?',
      options: [
        'Something very easy to do',
        'A delicious pastry',
        'A difficult challenge',
        'A special birthday celebration'
      ],
      correctAnswerIndex: 0,
      categoryId: 'english',
    ),
    const Question(
      questionText:
          'Identify the adjective in this sentence: "The red car drove quickly."',
      options: ['drove', 'quickly', 'red', 'car'],
      correctAnswerIndex: 2,
      categoryId: 'english',
    ),
    const Question(
      questionText: 'Which sentence is grammatically correct?',
      options: [
        'She don\'t like apples.',
        'She doesn\'t likes apples.',
        'She doesn\'t like apples.',
        'She not like apples.'
      ],
      correctAnswerIndex: 2,
      categoryId: 'english',
    ),
    const Question(
      questionText: 'What is the antonym (opposite) of Generous?',
      options: ['Kind', 'Selfish', 'Polite', 'Brave'],
      correctAnswerIndex: 1,
      categoryId: 'english',
    ),
    const Question(
      questionText: 'Choose the word with the correct English spelling:',
      options: [
        'Accommodate',
        'Acommodate',
        'Accomodate',
        'Acomodate'
      ],
      correctAnswerIndex: 0,
      categoryId: 'english',
    ),
    const Question(
      questionText: 'Which part of speech is the word Quickly?',
      options: ['Noun', 'Verb', 'Adverb', 'Adjective'],
      correctAnswerIndex: 2,
      categoryId: 'english',
    ),
    const Question(
      questionText: 'What is the plural form of the singular word Criterion?',
      options: ['Criterions', 'Criteria', 'Criterias', 'Criteries'],
      correctAnswerIndex: 1,
      categoryId: 'english',
    ),
    const Question(
      questionText:
          'Fill in the blank: "Neither John nor his friends ___ coming to the party."',
      options: ['is', 'are', 'was', 'has'],
      correctAnswerIndex: 1,
      categoryId: 'english',
    ),
  ],

  // 6. Science (10 questions)
  'science': [
    const Question(
      questionText: 'What is the chemical formula for pure Water?',
      options: ['O₂', 'H₂O', 'CO₂', 'NaCl'],
      correctAnswerIndex: 1,
      categoryId: 'science',
    ),
    const Question(
      questionText:
          'Which gas do green plants absorb from the air during photosynthesis?',
      options: ['Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'],
      correctAnswerIndex: 1,
      categoryId: 'science',
    ),
    const Question(
      questionText: 'What is the approximate speed of light in a vacuum?',
      options: [
        '300,000 km/s',
        '150,000 km/s',
        '1,000 km/s',
        '30,000 km/s'
      ],
      correctAnswerIndex: 0,
      categoryId: 'science',
    ),
    const Question(
      questionText:
          'Which cellular organelle is known as the powerhouse of the cell?',
      options: [
        'Nucleus',
        'Ribosome',
        'Mitochondria',
        'Endoplasmic Reticulum'
      ],
      correctAnswerIndex: 2,
      categoryId: 'science',
    ),
    const Question(
      questionText:
          'What is the dense center of an atom called, containing protons and neutrons?',
      options: ['Electron', 'Proton', 'Nucleus', 'Quark'],
      correctAnswerIndex: 2,
      categoryId: 'science',
    ),
    const Question(
      questionText:
          'Which planet in our solar system is closest to the Sun?',
      options: ['Mercury', 'Venus', 'Earth', 'Mars'],
      correctAnswerIndex: 0,
      categoryId: 'science',
    ),
    const Question(
      questionText: 'What is the standard SI unit of electrical resistance?',
      options: ['Volt', 'Ampere', 'Ohm', 'Watt'],
      correctAnswerIndex: 2,
      categoryId: 'science',
    ),
    const Question(
      questionText:
          'What type of blood cells fight infections and pathogens in the human body?',
      options: [
        'Red blood cells',
        'White blood cells',
        'Platelets',
        'Plasma cells'
      ],
      correctAnswerIndex: 1,
      categoryId: 'science',
    ),
    const Question(
      questionText: 'What is the chemical formula for common table salt?',
      options: ['KCl', 'NaCl', 'CaCl₂', 'NaOH'],
      correctAnswerIndex: 1,
      categoryId: 'science',
    ),
    const Question(
      questionText:
          'Which layer of Earth\'s atmosphere contains the ozone layer that absorbs UV rays?',
      options: [
        'Troposphere',
        'Stratosphere',
        'Mesosphere',
        'Thermosphere'
      ],
      correctAnswerIndex: 1,
      categoryId: 'science',
    ),
  ],
};

List<Question> getQuestionsForCategory(String categoryId) {
  return categoryQuestions[categoryId] ?? categoryQuestions['flutter']!;
}

// Backwards compatibility for any code using sampleQuestions
final List<Question> sampleQuestions = categoryQuestions['flutter']!;