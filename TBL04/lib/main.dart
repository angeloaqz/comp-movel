import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'services/background_service.dart';
import 'services/notification_service.dart';
import 'viewmodels/app_viewmodel.dart';
import 'views/home_view.dart';
import 'views/pedido_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final backgroundService = BackgroundService();
  await backgroundService.inicializar();
  await backgroundService.registrarSincronizacaoPeriodica();

  final viewModel = AppViewModel();

  try {
    await Firebase.initializeApp();
    final notificationService = NotificationService();
    await notificationService.configurar(
      onAbrirPedido: (pedidoId) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (_) => PedidoView(pedidoId: pedidoId),
          ),
        );
      },
      onMensagemForeground: (titulo, corpo) {
        viewModel.receberMensagemForeground(titulo, corpo);
      },
    );
  } catch (_) {}

  runApp(MyApp(viewModel: viewModel));
}

class MyApp extends StatelessWidget {
  final AppViewModel viewModel;

  const MyApp({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: HomeView(viewModel: viewModel),
    );
  }
}
