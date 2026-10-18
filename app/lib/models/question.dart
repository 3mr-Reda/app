class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;
  final String? codeSnippet;
  final String? categoryId;

  const Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
    this.codeSnippet,
    this.categoryId,
  });
}