// lib/features/game/presentation/widgets/target_sequence_controller.dart
import 'package:flutter/material.dart';
import 'package:vim_game/features/TargetSequence/TargetSequenceDisplay.dart';

// após o parent reconstruir
class TargetSequenceController extends StatefulWidget {
  final String currentMode;

  const TargetSequenceController({
    required this.currentMode,
    super.key,
  });

  @override
  State<TargetSequenceController> createState() =>
      _TargetSequenceControllerState();
}

// Esta classe contém o estado mutável e a lógica do widget
class _TargetSequenceControllerState extends State<TargetSequenceController> {
  // -- CONTROLANDO ESTADO DA SEQUENCIA --

  // --- ESTADO INTERNO VIRÁ AQUI (Passo 1) ---
  List<String> _targetSequence = [];
  int _currentIndex = 0;

  // --- LÓGICA DE GERAÇÃO VIRÁ AQUI  ---

  //TODO: o nome dessa função está ok?
  void _generateNewSequence() {
    final currentMode = widget.currentMode; //recebe o modo atual prop

    setState(() {
      if (currentMode == "Navigation") {
        _targetSequence = ['h', 'j', 'k', 'l', 'h', 'l', 'j', 'k'];
      } else if (currentMode == "Essential Commands") {
        _targetSequence = [':', 'w', 'q', '!', 'd', 'd', 'p'];
      } else {
        _targetSequence = []; // Limpa se o modo for desconhecido
      }
      _currentIndex = 0; // Reseta o índice
    });
    print(
        "New sequence generated in Controller: $_targetSequence for mode: $currentMode");
  }

  // --- initState VIRÁ AQUI (Passo 3) ---
  @override
  void initState() {
    super.initState(); // É importante chamar super.initState() primeiro. PQ????
    print(
        "TargetSequenceController initState called. Generating initial sequence.");
    _generateNewSequence(); // Chama a função para gerar a primeira sequência
  }

  // --- didUpdateWidget VIRÁ AQUI (Passo 4) ---
  @override
  void didUpdateWidget(covariant TargetSequenceController oldWidget) {
    // covariant TargetSequenceController oldWidget????
    super.didUpdateWidget(oldWidget); // Chamar super é importante. PQ??
    // Compara o modo atual (vindo do widget atualizado) com o modo antigo
    if (widget.currentMode != oldWidget.currentMode) {
      print(
          "TargetSequenceController didUpdateWidget: Mode changed from ${oldWidget.currentMode} to ${widget.currentMode}. Regenerating sequence.");
      _generateNewSequence(); // Regenera a sequência se o modo mudou
    }
  }

  // O método build é responsável por desenhar a UI deste widget
  @override
  Widget build(BuildContext context) {
    return TargetSequenceDisplay(
      sequence: _targetSequence,
      currentIndex: _currentIndex,
    );
  }
}
