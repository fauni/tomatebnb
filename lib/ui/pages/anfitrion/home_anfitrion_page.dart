import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomatebnb/provider/navigation_provider.dart';

class HomeAnfitrionPage extends StatefulWidget {
  const HomeAnfitrionPage({super.key});

  @override
  State<HomeAnfitrionPage> createState() => _HomeAnfitrionPageState();
}

class _HomeAnfitrionPageState extends State<HomeAnfitrionPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          // AppBar personalizado con logo
          SliverAppBar(
            backgroundColor: theme.colorScheme.surface,
            surfaceTintColor: theme.colorScheme.surface,
            pinned: true,
            floating: true,
            expandedHeight: size.height * 0.18,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              centerTitle: false,
              title: Row(
                children: [
                  Image.asset(
                    'assets/logos/logo-samay.JPG', // Ruta de tu logo
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 12),
                  // Text(
                  //   "Inicio",
                  //   style: TextStyle(
                  //     fontSize: 22,
                  //     fontFamily: "Gilroy Bold",
                  //     color: theme.colorScheme.onSurface,
                  //   ),
                  // ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: theme.colorScheme.surfaceVariant,
                  child: IconButton(
                    icon: Image.asset(
                      "assets/images/notification.png",
                      height: 22,
                      color: theme.colorScheme.onSurface,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),

          // Contenido principal
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Banner de bienvenida
                _buildWelcomeCard(theme, size),
                const SizedBox(height: 30),

                // Anuncio PRO destacado
                _buildProAnnouncement(theme),
                const SizedBox(height: 30),

                // Sección de acciones rápidas
                _buildQuickActions(theme),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(ThemeData theme, Size size) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¡Franz Ronald, te damos la bienvenida!',
              style: TextStyle(
                fontFamily: "Gilroy Bold",
                fontSize: 24,
                color: theme.colorScheme.onSurface,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Los huéspedes pueden reservar tu alojamiento 24 horas después de que publiques tu anuncio. Te explicamos cómo prepararlo.',
              style: TextStyle(
                fontFamily: "Gilroy Light",
                fontSize: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProAnnouncement(ThemeData theme) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primaryContainer,
            theme.colorScheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                "assets/logos/logo-samay.JPG",
                height: 120,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "SAMAY",
                        style: TextStyle(
                          fontFamily: "Gilroy Bold",
                          fontSize: 12,
                          color: theme.colorScheme.onPrimary,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  "Panel de Anfitrión",
                  style: TextStyle(
                    fontFamily: "Gilroy Bold",
                    fontSize: 22,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "En este módulo puedes crear, editar y administrar todos tus anuncios con herramientas profesionales para optimizar tus publicaciones.",
                  style: TextStyle(
                    fontFamily: "Gilroy Medium",
                    fontSize: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: InkWell(
                    onTap: () {
                      navigationProvider.setPageAnfitrion(2);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Crear nuevo anuncio",
                          style: TextStyle(
                            fontFamily: "Gilroy Bold",
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.add_circle_outline, size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Acciones rápidas",
          style: TextStyle(
            fontFamily: "Gilroy Bold",
            fontSize: 18,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 15),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.2,
          children: [
            _buildActionCard(
              theme,
              Icons.home_work_outlined,
              "Mis anuncios",
              theme.colorScheme.primaryContainer,
            ),
            _buildActionCard(
              theme,
              Icons.calendar_today,
              "Reservas",
              theme.colorScheme.secondaryContainer,
            ),
            _buildActionCard(
              theme,
              Icons.analytics,
              "Estadísticas",
              theme.colorScheme.tertiaryContainer,
            ),
            _buildActionCard(
              theme,
              Icons.settings,
              "Configuración",
              theme.colorScheme.surfaceVariant,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    ThemeData theme,
    IconData icon,
    String title,
    Color color,
  ) {
    return Card(
      elevation: 0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 28, color: theme.colorScheme.onSurface),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontFamily: "Gilroy Bold",
                  fontSize: 16,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}