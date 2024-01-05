import 'package:go_router/go_router.dart';
import 'package:spendit_test/features/auth/presentation/screens/screens.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
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
);
