import 'dart:math'; // Required for Random
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for RawKeyboardListener
import 'package:collection/collection.dart'; // For firstWhereOrNull

void main() {
  runApp(const VimSequencePracticeApp());
}

// Enum to represent directions
enum Direction { up, down, left, right }

// Enum for feedback state
enum FeedbackState { none, correct, incorrect }

class VimSequencePracticeApp extends StatelessWidget {
  const VimSequencePracticeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vim Sequence Practice',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: const VimSequenceGame(),
    );
  }
}

class VimSequenceGame extends StatefulWidget {
  const VimSequenceGame({super.key});

  @override
  State<VimSequenceGame> createState() => _VimSequenceGameState();
}

enum TrainingMode {
  navigation,
  textEditingControl,
}

class _VimSequenceGameState extends State<VimSequenceGame> {
  final List<Direction> _sequence = [];
  final int _sequenceLength = 7;
  FeedbackState _feedbackState = FeedbackState.none;
  int _feedbackIndex = -1;
  int _score = 0;
  final Random _random = Random();
  TrainingMode _currentMode = TrainingMode.navigation; // Começa em Navegação
  final Map<Direction, String> _directionToKey = {
    Direction.up: 'k',
    Direction.down: 'j',
    Direction.left: 'h',
    Direction.right: 'l',
  };
  final Map<String, Direction> _keyToDirection = {
    'k': Direction.up,
    'j': Direction.down,
    'h': Direction.left,
    'l': Direction.right,
  };
  final Map<Direction, String> _directionToText = {
    Direction.up: 'Up',
    Direction.down: 'Down',
    Direction.left: 'Left',
    Direction.right: 'Right',
  };

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _sequenceLength; i++) {
      _addRandomDirectionToSequence();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _addRandomDirectionToSequence() {
    final int randomIndex = _random.nextInt(Direction.values.length);
    _sequence.add(Direction.values[randomIndex]);
  }

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent && _sequence.isNotEmpty) {
      String keyPressed = event.logicalKey.keyLabel.toLowerCase();
      Direction? targetDirection = _sequence.firstOrNull;

      if (targetDirection != null && _keyToDirection.containsKey(keyPressed)) {
        Direction pressedDirection = _keyToDirection[keyPressed]!;
        bool correctPress = (pressedDirection == targetDirection);

        setState(() {
          _feedbackIndex = 0;
          if (correctPress) {
            _feedbackState = FeedbackState.correct;
            _score++;
            _sequence.removeAt(0);
            _addRandomDirectionToSequence();
          } else {
            _feedbackState = FeedbackState.incorrect;
            _score = 0;
          }

          Future.delayed(const Duration(milliseconds: 250), () {
            if (mounted) {
              setState(() {
                _feedbackState = FeedbackState.none;
                _feedbackIndex = -1;
              });
            }
          });
        });
      }
    }
  }

  // --- Widget for Individual Arrow in the Sequence ---
  // REMOVED direction text from inside the card
  Widget _buildSequenceArrow(Direction direction, int index, bool isTarget) {
    final IconData iconData;
    final String keyLabel = _directionToKey[direction]!;
    // final String directionText = _directionToText[direction]!; // Removed

    switch (direction) {
      case Direction.up:
        iconData = Icons.arrow_upward;
        break;
      case Direction.down:
        iconData = Icons.arrow_downward;
        break;
      case Direction.left:
        iconData = Icons.arrow_back;
        break;
      case Direction.right:
        iconData = Icons.arrow_forward;
        break;
    }

    Color cardBackgroundColor = Colors.black.withOpacity(0.3);
    if (index == _feedbackIndex) {
      switch (_feedbackState) {
        case FeedbackState.correct:
          cardBackgroundColor = Colors.green.shade700.withOpacity(0.8);
          break;
        case FeedbackState.incorrect:
          cardBackgroundColor = Colors.red.shade700.withOpacity(0.8);
          break;
        case FeedbackState.none:
          break;
      }
    }

    final Color targetColor = Colors.cyanAccent.shade100;
    final Color upcomingColor = Colors.grey.shade600;
    final Color contentColor = isTarget ? targetColor : upcomingColor;
    final double size = isTarget ? 55 : 40;
    final double keyFontSize = isTarget ? 15 : 13;
    // final double directionFontSize = isTarget ? 12 : 10; // Removed
    final FontWeight keyFontWeight =
        isTarget ? FontWeight.bold : FontWeight.normal;
    final Border? border = isTarget
        ? Border.all(color: targetColor.withOpacity(0.8), width: 2.0)
        : Border.all(color: Colors.grey.shade800, width: 1.0);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      padding: const EdgeInsets.symmetric(
          vertical: 12.0, horizontal: 10.0), // Adjusted padding
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: border,
      ),
      child: Column(
        // Content is now just Icon and Key Label
        mainAxisSize: MainAxisSize.min,
        children: [
          // Removed Direction Text Widget from here
          Icon(iconData, size: size, color: contentColor),
          const SizedBox(height: 6), // Adjusted spacing
          Text(
            keyLabel,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: keyFontSize,
              color: contentColor.withOpacity(0.9),
              fontWeight: keyFontWeight,
            ),
          )
        ],
      ),
    );
  }
  // --- End of Sequence Arrow Widget ---

  @override
  Widget build(BuildContext context) {
    // Determine the current target direction text
    String currentTargetText = '';
    if (_sequence.isNotEmpty) {
      currentTargetText = _directionToText[_sequence.first] ?? '';
    }

    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: _handleKeyPress,
      child: Scaffold(
        backgroundColor: const Color(0xFF1a1a1a),
        body: Column(
          children: [
            // Score display at the top
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Score: $_score',
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const Spacer(), // Push sequence area down

            // --- Sequence Display Area ---
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 20.0), // Reduced vertical padding
              child: Column(
                // Use Column to place text above the Row
                mainAxisSize: MainAxisSize.min, // Take minimum vertical space
                children: [
                  // ADDED: Text widget for the target direction name
                  SizedBox(
                    // Use SizedBox to control height and prevent layout shifts
                    height: 30, // Give it a fixed height
                    child: Text(
                      currentTargetText, // Display the target direction text
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.cyanAccent
                            .withOpacity(0.8), // Match target color
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15), // Spacing between text and arrows

                  // Row containing the sequence arrow.
                  // Why not just use listView here?
                  // R: there are just 7 card sequences been rendering,
                  //  it is trivial and does need the ListView lazy loading feature
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _sequence.mapIndexed((index, direction) {
                        return _buildSequenceArrow(
                            direction, index, index == 0);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            // --- End of Sequence Display Area ---

            const Spacer(), // Push sequence area up a bit
          ],
        ),
      ),
    );
  }
}

// Helper extension for mapIndexed (remains the same)
extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E e) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}
