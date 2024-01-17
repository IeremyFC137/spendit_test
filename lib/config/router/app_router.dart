import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spendit_test/config/router/app_router_notifier.dart';
import 'package:spendit_test/features/auth/presentation/screens/screens.dart';
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
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      GoRoute(
        path: '/login',
        name: LoginScreen.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/',
        name: HomeScreen.name,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/gastos',
        name: GastosScreen.name,
        builder: (context, state) => const GastosScreen(),
      ),
      GoRoute(
        path: '/rendicion',
        name: RendicionScreen.name,
        builder: (context, state) => const RendicionScreen(),
      ),
      GoRoute(
        path: '/revision',
        name: RevisionScreen.name,
        builder: (context, state) => const RevisionScreen(),
      ),
      GoRoute(
        path: '/fondos',
        name: FondosScreen.name,
        builder: (context, state) => const FondosScreen(),
      ),
      GoRoute(
        path: '/theme-changer',
        name: ThemeChangerScreen.name,
        builder: (context, state) => const ThemeChangerScreen(),
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

// GoRouter configuration
