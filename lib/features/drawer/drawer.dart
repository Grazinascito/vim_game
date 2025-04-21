import 'package:flutter/material.dart';

// Define um tipo para a função de callback, tornando o código mais legível.
// Esta função será chamada quando um modo for selecionado e passará
// o nome do modo (String) de volta para o widget pai (GameScreen).
typedef ModeSelectionCallback = void Function(String selectedMode);

// Um widget sem estado (StatelessWidget) porque ele apenas exibe informações
// (a lista de modos e qual está selecionado) e delega a ação de mudança
// de estado para o widget pai através do callback.
class ModeSelectorDrawer extends StatelessWidget {
  // Variável final para receber o nome do modo atualmente selecionado.
  // Isso é necessário para saber qual ListTile destacar (selected: true).
  final String currentMode;

  // Variável final para receber a função de callback que será chamada
  // quando um item do drawer for tocado (onTap).
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
      // Remove qualquer padding padrão da ListView para que o DrawerHeader
      // e os ListTiles ocupem toda a largura/altura disponível.
      padding: EdgeInsets.zero,
      children: [
        // --- Bloco 1: Cabeçalho do Drawer ---
        // Um widget padrão para exibir uma área de cabeçalho no topo do Drawer.
        // Útil para títulos ou informações gerais.
        const DrawerHeader(
          // Decoração para dar um fundo e estilo ao cabeçalho.
          decoration: BoxDecoration(
            // Usando uma cor de exemplo (ajuste conforme seu tema)
            color: Color(0xFF313244),
          ),
          // O conteúdo do cabeçalho, neste caso, um simples texto.
          child: Text(
            'Training Modes',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white, // Cor do texto do cabeçalho
            ),
          ),
        ),

        // --- Bloco 2: Item do Modo Navegação ---
        // ListTile é o widget padrão para itens em listas ou drawers.
        // Ele organiza ícones, texto e ações de forma consistente.
        ListTile(
          // Ícone opcional exibido à esquerda do texto.
          leading: const Icon(Icons.navigation_outlined),
          // O texto principal do item.
          title: const Text('Vim Navigation'),
          // Define se este item deve ser visualmente destacado como selecionado.
          // Compara o nome deste modo ('Vim Navigation') com o 'currentMode'
          // que foi passado para este widget. Se forem iguais, fica selecionado.
          selected: currentMode == 'Vim Navigation',
          // A função que será executada quando este ListTile for tocado.
          onTap: () {
            // 1. Chama a função de callback 'onModeSelected' que foi passada
            //    pelo widget pai, enviando de volta a string 'Vim Navigation'.
            //    É assim que o GameScreen saberá que este modo foi escolhido.
            onModeSelected('Vim Navigation');
            // 2. Fecha o Drawer programaticamente após a seleção.
            Navigator.pop(context);
          },
        ),

        // --- Bloco 3: Item do Modo Comandos Essenciais ---
        // Outro ListTile, seguindo o mesmo padrão do anterior, mas para
        // o modo 'Essential Commands'.
        ListTile(
          leading: const Icon(Icons.code),
          title: const Text('Essential Commands'),
          // Compara com 'Essential Commands' para definir se está selecionado.
          selected: currentMode == 'Essential Commands',
          onTap: () {
            // Chama o callback passando 'Essential Commands'.
            onModeSelected('Essential Commands');
            // Fecha o Drawer.
            Navigator.pop(context);
          },
        ),

        // --- Bloco 4: Futuros Modos (Comentado) ---
        // Você pode adicionar mais ListTiles aqui para outros modos
        // que criar no futuro, seguindo o mesmo padrão.
        // ListTile(
        //   leading: const Icon(Icons.edit),
        //   title: const Text('Insert Mode Practice'),
        //   selected: currentMode == 'Insert Mode Practice',
        //   onTap: () {
        //     onModeSelected('Insert Mode Practice');
        //     Navigator.pop(context);
        //   },
        // ),
      ],
    );
  }
}
