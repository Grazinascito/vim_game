import 'package:flutter/material.dart';
import 'package:vim_game/features/TargetSequence/TargetSequenceController.dart';
import 'package:vim_game/features/drawer/drawer.dart';

// --- Cores baseadas na referência visual (image.png) ---
const Color primaryTextColor = Colors.white;
const Color backgroundColor = Color(0xFF1A1A1A); // Cinza bem escuro
const Color accentColor = Color(0xFF67D8EF); // Ciano/Azul claro
const Color dimTextColor = Color(0xFF888888); // Cinza para texto/ícones futuros
const Color headerGrayColor =
    Color(0xFF303030); // Cinza para texto/ícones futuros
// --- Fim das Cores ---

void main() {
  runApp(const VimGameApp());
}

// Widget raiz do aplicativo
class VimGameApp extends StatelessWidget {
  const VimGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vim_game',
      // Tema básico escuro inspirado na imagem
      //TODO: mover para um arquivo especifico de tema
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: accentColor,
        fontFamily: 'Roboto', // Ou outra fonte
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: primaryTextColor),
          // Estilos para Score e Hint podem ser definidos aqui ou in-line
          headlineMedium: TextStyle(
            // Exemplo para Score
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
          ),
          titleLarge: TextStyle(
            // Exemplo para Hint
            fontSize: 24,
            color: accentColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        // Tema para Ícones (pode ser útil depois)
        iconTheme: const IconThemeData(
          color: primaryTextColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const GameScreen(), // Tela principal
    );
  }
}

// Tela principal do jogo (Stateful, pois terá estado)
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Chave para controlar o Scaffold e abrir o Drawer programaticamente
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

// its like useState("Navigation") basically
  String _currentMode = "Navigation";

  void _handleModeSelection(String mode) {
    setState(() {
      _currentMode = mode;

      print("Mode changed to: $_currentMode");
    });

    Navigator.pop(context); //fecha o drawer depois da seleção
  }

  @override
  Widget build(BuildContext context) {
    print("GameScreen build called. Current mode: $_currentMode");
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: headerGrayColor,
        title: Text(
          'Score: 0', // Score ainda é fixo, vamos lidar depois
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: const Icon(Icons.menu),
            tooltip: 'Open navigation menu'),
      ),
      drawer: Drawer(
        child: ModeSelectorDrawer(
          // Usando diretamente (ou envolto em Drawer)
          currentMode: _currentMode,
          onModeSelected: _handleModeSelection,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Text(
              'Mode: $_currentMode', // Exibe o modo atual
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 40), // Espaço aumentado

            // Substitua o Expanded/Container/Text placeholder por isto:
            TargetSequenceController(
              currentMode: _currentMode, // Passa o modo atual
            ),

            // Mantém um espaço flexível abaixo
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
