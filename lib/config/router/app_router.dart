import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spendit_test/config/router/app_router_notifier.dart';
import 'package:spendit_test/features/auth/presentation/screens/screens.dart';
import 'package:spendit_test/features/gastos/domain/domain.dart';
import 'package:spendit_test/features/gastos/presentation/screen/screens.dart';
import '../../features/auth/presentation/providers/providers.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: '/splash',
        name: CheckAuthStatusScreen.name,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const CheckAuthStatusScreen(),
        ),
      ),
      GoRoute(
        path: '/login',
        name: LoginScreen.name,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: '/',
        name: HomeScreen.name,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: '/gastos',
        name: GastosScreen.name,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const GastosScreen(),
        ),
      ),
      GoRoute(
          path: '/gastos/ingreso-manual',
          name: IngresoManualScreen.name,
          pageBuilder: (context, state) {
            final gastoLike = state.extra as GastoLike?;
            return _fadeTransitionPage(
              key: state.pageKey,
              child: IngresoManualScreen(gastoLike: gastoLike),
            );
          }),
      GoRoute(
        path: '/gastos/scanit',
        name: ScanitScreen.name,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const ScanitScreen(),
        ),
      ),
      GoRoute(
        path: '/gastos/qr-scanner',
        name: QRScannerScreen.name,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const QRScannerScreen(),
        ),
      ),
      GoRoute(
        path: '/gastos/:id',
        name: GastoScreen.name,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: GastoScreen(gastoId: state.pathParameters['id'] ?? "0"),
        ),
      ),
      GoRoute(
        path: '/rendicion',
        name: RendicionScreen.name,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const RendicionScreen(),
        ),
      ),
      GoRoute(
        path: '/revision',
        name: RevisionScreen.name,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const RevisionScreen(),
        ),
      ),
      GoRoute(
        path: '/fondos',
        name: FondosScreen.name,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const FondosScreen(),
        ),
      ),
      GoRoute(
        path: '/theme-changer',
        name: ThemeChangerScreen.name,
        pageBuilder: (context, state) => _fadeTransitionPage(
          key: state.pageKey,
          child: const ThemeChangerScreen(),
        ),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login') return null;

        return '/login';
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/splash') {
          return '/';
        }
      }

      return null;
    },
  );
});

CustomTransitionPage<void> _fadeTransitionPage({
  required LocalKey key,
  required Widget child,
  Duration duration =
      const Duration(milliseconds: 300), // Duración personalizada
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: duration, // Estableciendo la duración de la transición
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
