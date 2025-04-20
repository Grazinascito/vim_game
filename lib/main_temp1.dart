import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Usando tema escuro para similaridade
      home: const HomePageWithSidebar(),
    );
  }
}

class HomePageWithSidebar extends StatelessWidget {
  const HomePageWithSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. AppBar: A barra no topo
      appBar: AppBar(
        title: const Text('Exemplo de Sidebar'),
        backgroundColor: Colors.grey[850], // Cor similar
        elevation: 0,
      ),

      // 2. Drawer: A propriedade que define a sidebar esquerda
      // Este código vai dentro da propriedade 'drawer:' do seu Scaffold

      drawer: Drawer(
        backgroundColor: Colors.grey[900], // Cor de fundo da sidebar
        child: ListView(
          padding: EdgeInsets.zero, // Remove o padding padrão da ListView
          children: <Widget>[
            // Cabeçalho opcional (pode personalizar ou remover)
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[800], // Cor de fundo do cabeçalho
              ),
              child: const Text(
                'Modos de Treino',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            // --- Item para Modo Navegação (usando InkWell) ---
            InkWell(
              // Ação ao clicar
              onTap: () {
                setState(() {
                  // Muda o modo atual para Navegação
                  _currentMode = TrainingMode.Navigation;
                  // Reinicia o estado do jogo (score, sequência)
                  _resetGame(); // Você precisará criar esta função
                });
                // Fecha a sidebar
                Navigator.pop(context);
              },
              // Conteúdo clicável
              child: Padding(
                // Espaçamento interno para o texto
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 14.0),
                child: Text(
                  'Navegação (hjkl)', // Nome do modo
                  style: TextStyle(
                    // Muda a cor e o peso da fonte se este for o modo ativo
                    color: _currentMode == TrainingMode.Navigation
                        ? Colors.cyanAccent // Cor quando ativo
                        : Colors.white70, // Cor quando inativo
                    fontSize: 16,
                    fontWeight: _currentMode == TrainingMode.Navigation
                        ? FontWeight.bold // Negrito quando ativo
                        : FontWeight.normal, // Normal quando inativo
                  ),
                ),
              ),
            ),
            // Linha divisória para separar os itens
            Divider(
                color: Colors.grey[700], height: 1, indent: 16, endIndent: 16),

            // --- Item para Modo Controle IDE (usando InkWell) ---
            InkWell(
              onTap: () {
                setState(() {
                  _currentMode = TrainingMode.IdeControl;
                  _resetGame();
                });
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 14.0),
                child: Text(
                  'Controle IDE', // Nome do modo
                  style: TextStyle(
                    color: _currentMode == TrainingMode.IdeControl
                        ? Colors.cyanAccent
                        : Colors.white70,
                    fontSize: 16,
                    fontWeight: _currentMode == TrainingMode.IdeControl
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
            Divider(
                color: Colors.grey[700], height: 1, indent: 16, endIndent: 16),

            // --- Adicione mais InkWells aqui para futuros modos ---
            // Exemplo:
            // InkWell(
            //   onTap: () { /* Lógica para modo Edição */ },
            //   child: Padding( /* ... */ ),
            // ),
            // Divider( /* ... */ ),
          ],
        ),
      ),

      // Corpo principal da tela (pode ser qualquer coisa)
      body: const Center(
        child: Text(
          'Conteúdo Principal da Tela',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
