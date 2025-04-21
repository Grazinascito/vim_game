import 'package:flutter/material.dart';

// --- Cores baseadas na referência visual (image.png) ---
const Color primaryTextColor = Colors.white;
const Color backgroundColor = Color(0xFF1A1A1A); // Cinza bem escuro
const Color accentColor = Color(0xFF67D8EF); // Ciano/Azul claro
const Color dimTextColor = Color(0xFF888888); // Cinza para texto/ícones futuros
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Associar a chave ao Scaffold
      // Sem AppBar para seguir o layout da imagem

      // Drawer (Placeholder - estrutura mínima)
      // A lógica interna (ListTiles, setState) será adicionada depois
      drawer: const Drawer(
        child: Center(
            child: Text("Mode Selection Placeholder")), // Placeholder simples
      ),

      // Corpo principal com a estrutura visual da imagem
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center, // Ajustar depois
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
                height: 40), // Espaço no topo (simulando ausência da AppBar)

            // 1. Score Display (Placeholder)
            Text(
              'Score: 0', // Valor estático por enquanto
              // Usando estilo definido no tema
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),

            // 2. Hint Text (Placeholder)
            Text(
              'Hint Text', // Texto estático por enquanto
              // Usando estilo definido no tema
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),

            // 3. Target Sequence Area (Placeholder)
            Expanded(
              // Usa o espaço restante
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  '[Target Sequence Row Placeholder]',
                  style: TextStyle(color: dimTextColor),
                ),
              ),
            ),

            // Botão temporário para abrir o Drawer (já que não temos AppBar)
            // Pode ser removido/movido depois
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                child: const Text('Open Drawer (Temp)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
