import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late bool? isAnfitrion = false;

  @override
  void initState() {
    super.initState();
    emailController.text = '';
    passwordController.text = '';
    getMode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void getMode() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        isAnfitrion = prefs.getBool("setIsAnfitrion");
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo es requerido';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Ingresa un correo válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus(); // Cerrar teclado
      context.read<AuthBloc>().add(AuthLoginEvent(
        emailController.text.trim(),
        passwordController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(75),
      //   child: CustomAppbar(
      //     centertext: "",
      //     ActionIcon: null,
      //     bgcolor: theme.colorScheme.surface,
      //   ),
      // ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height - 150, // Altura mínima para el contenido
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header con logo y título
                      _buildHeader(context),
                      
                      const SizedBox(height: 40),
                      
                      // Formulario
                      _buildForm(context, theme),
                      
                      const SizedBox(height: 16),
                      
                      // Forgot password link
                      _buildForgotPasswordLink(theme),
                      
                      const Spacer(), // Empuja el botón hacia abajo
                      
                      // Botón de login y registro
                      _buildBottomSection(context, theme),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // Logo con sombra y mejor presentación
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/logos/logo-samay.JPG',
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Título mejorado
        Text(
          "¡Bienvenido de vuelta!",
          style: TextStyle(
            fontSize: 28,
            fontFamily: "Gilroy Bold",
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 8),
        
        Text(
          "Inicia sesión en tu cuenta",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Gilroy Medium",
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Email field
        Text(
          "Correo Electrónico",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Gilroy Medium",
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: _validateEmail,
          decoration: InputDecoration(
            hintText: 'Ingresa tu correo electrónico',
            prefixIcon: Icon(
              Icons.email_outlined, 
              color: theme.colorScheme.primary,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.outline.withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.error),
            ),
            filled: true,
            fillColor: theme.colorScheme.surface,
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Password field
        Text(
          "Contraseña",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Gilroy Medium",
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        
        TextFormField(
          controller: passwordController,
          obscureText: _obscureText,
          textInputAction: TextInputAction.done,
          validator: _validatePassword,
          onFieldSubmitted: (_) => _handleLogin(),
          decoration: InputDecoration(
            hintText: 'Ingresa tu contraseña',
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                "assets/images/password.png",
                height: 20,
                width: 20,
                color: theme.colorScheme.primary,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: theme.colorScheme.primary,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.outline.withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.error),
            ),
            filled: true,
            fillColor: theme.colorScheme.surface,
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordLink(ThemeData theme) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          context.push('/forgot-password'); // Navega a la pantalla de recuperación
        },
        child: Text(
          "¿Olvidaste tu contraseña?",
          style: TextStyle(
            fontSize: 15,
            color: theme.colorScheme.primary,
            fontFamily: "Gilroy Medium",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        const SizedBox(height: 20),
        
        // Login button con BlocConsumer
        BlocConsumer<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                ),
                child: isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            theme.colorScheme.onPrimary,
                          ),
                        ),
                      )
                    : Text(
                        "Iniciar Sesión",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Gilroy Bold",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            );
          },
          listener: (context, state) {
            if (state is AuthLoginSuccess) {
              if (isAnfitrion == null || isAnfitrion == false) {
                context.pushReplacement('/menu-viajero');
              } else {
                context.pushReplacement('/menu-anfitrion');
              }
            } else if (state is AuthLoginError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(child: Text(state.message)),
                    ],
                  ),
                  backgroundColor: theme.colorScheme.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }
          },
        ),
        
        const SizedBox(height: 24),
        
        // Divider con texto
        Row(
          children: [
            Expanded(child: Divider(color: theme.colorScheme.outline.withOpacity(0.3))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "o",
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                  fontFamily: "Gilroy Medium",
                ),
              ),
            ),
            Expanded(child: Divider(color: theme.colorScheme.outline.withOpacity(0.3))),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Register link mejorado
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "¿No tienes una cuenta? ",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Gilroy Medium",
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.push('/create-account');
              },
              child: Text(
                "Regístrate",
                style: TextStyle(
                  fontSize: 15,
                  color: theme.colorScheme.primary,
                  fontFamily: "Gilroy Bold",
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 20),
      ],
    );
  }
}