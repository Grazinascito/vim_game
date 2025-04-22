import 'package:flutter/material.dart';

// Define um tipo para a função de callback, tornando o código mais legível.
// Esta função será chamada quando um modo for selecionado e passará
// o nome do modo (String) de volta para o widget pai (GameScreen).
typedef ModeSelectionCallback = void Function(String selectedMode);

class ModeSelectorDrawer extends StatelessWidget {
  final String currentMode;

  final ModeSelectionCallback onModeSelected;

  // Construtor do widget. Requer que 'currentMode' e 'onModeSelected'
  // sejam fornecidos ao criar uma instância deste widget.
  const ModeSelectorDrawer({
    required this.currentMode,
    required this.onModeSelected,
    super.key, // Chave opcional padrão para widgets Flutter
  });

  @override
  Widget build(BuildContext context) {
    // O conteúdo principal do Drawer é uma ListView,
    // ideal para listas verticais de itens.
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          // margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Color(0xFF313244),
          ),
          child: Text(
            'Training Modes',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        ListTile(
          // O texto principal do item.
          title: const Text('Navigation'),
          selected: currentMode == 'Navigation',
          onTap: () {
            onModeSelected('Navigation');
          },
        ),
        ListTile(
          title: const Text('Essential Commands'),
          selected: currentMode == 'Essential Commands',
          onTap: () {
            onModeSelected('Essential Commands');
          },
        ),
        ListTile(
          title: const Text('Insert Mode Practice'),
          selected: currentMode == 'Insert Mode Practice',
          onTap: () {
            onModeSelected('Insert Mode Practice');
          },
        ),
      ],
    );
  }
}
