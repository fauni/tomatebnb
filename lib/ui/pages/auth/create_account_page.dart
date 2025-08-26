import 'package:flutter/material.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/models/user/user_request_modelp.dart';
import 'package:tomatebnb/utils/customwidget.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> with TickerProviderStateMixin {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  // Focus nodes para mejor UX
  final _nameFocus = FocusNode();
  final _lastnameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    _nameFocus.dispose();
    _lastnameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // Validadores
  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El nombre es requerido';
    }
    if (value.trim().length < 2) {
      return 'El nombre debe tener al menos 2 caracteres';
    }
    return null;
  }

  String? _validateLastname(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Los apellidos son requeridos';
    }
    if (value.trim().length < 2) {
      return 'Los apellidos deben tener al menos 2 caracteres';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El correo es requerido';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value.trim())) {
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
    if (!value.contains(RegExp(r'[A-Za-z]'))) {
      return 'La contraseña debe contener al menos una letra';
    }
    return null;
  }

  void _handleCreateAccount() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(AuthCreateEvent(
        UserRequestModelp(
          name: nameController.text.trim(),
          lastname: lastnameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: CustomAppbar(
          centertext: "",
          ActionIcon: null,
          bgcolor: colorScheme.surface,
          actioniconcolor: colorScheme.onSurface,
          leadingiconcolor: colorScheme.onSurface,
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height - 150,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Header
                        _buildHeader(context),
                        
                        const SizedBox(height: 32),
                        
                        // Form Fields
                        _buildFormFields(context),
                        
                        const Spacer(),
                        
                        // Bottom Section
                        _buildBottomSection(context),
                      ],
                    ),
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
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título principal
        Text(
          "¡Únete a SAMAY!",
          style: TextStyle(
            fontSize: 32,
            fontFamily: "Gilroy Bold",
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Subtítulo
        Text(
          "Crea tu cuenta y comienza tu aventura",
          style: TextStyle(
            fontSize: 16,
            color: colorScheme.onSurface.withOpacity(0.7),
            fontFamily: "Gilroy Medium",
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Indicador de progreso
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Nombre
        _buildInputField(
          label: "Nombre",
          controller: nameController,
          focusNode: _nameFocus,
          nextFocus: _lastnameFocus,
          validator: _validateName,
          prefixIcon: Icons.person_outline,
          hint: "Ingresa tu nombre",
          textInputAction: TextInputAction.next,
        ),
        
        const SizedBox(height: 20),
        
        // Apellidos
        _buildInputField(
          label: "Apellidos",
          controller: lastnameController,
          focusNode: _lastnameFocus,
          nextFocus: _emailFocus,
          validator: _validateLastname,
          prefixIcon: Icons.person_outline,
          hint: "Ingresa tus apellidos",
          textInputAction: TextInputAction.next,
        ),
        
        const SizedBox(height: 20),
        
        // Email
        _buildInputField(
          label: "Correo Electrónico",
          controller: emailController,
          focusNode: _emailFocus,
          nextFocus: _passwordFocus,
          validator: _validateEmail,
          prefixIcon: Icons.email_outlined,
          hint: "Ingresa tu correo electrónico",
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        
        const SizedBox(height: 20),
        
        // Contraseña
        _buildPasswordField(),
        
        const SizedBox(height: 16),
        
        // Indicaciones de seguridad
        _buildPasswordRequirements(),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocus,
    required String? Function(String?) validator,
    required IconData prefixIcon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.done,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Gilroy Medium",
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        
        const SizedBox(height: 8),
        
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onFieldSubmitted: (_) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            } else {
              _handleCreateAccount();
            }
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.5),
            ),
            prefixIcon: Icon(
              prefixIcon,
              color: colorScheme.primary,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
            filled: true,
            fillColor: colorScheme.surface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontFamily: "Gilroy Medium",
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contraseña",
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Gilroy Medium",
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        
        const SizedBox(height: 8),
        
        TextFormField(
          controller: passwordController,
          focusNode: _passwordFocus,
          obscureText: _obscureText,
          validator: _validatePassword,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _handleCreateAccount(),
          decoration: InputDecoration(
            hintText: "Ingresa tu contraseña",
            hintStyle: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.5),
            ),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: colorScheme.primary,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                color: colorScheme.primary,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.error, width: 2),
            ),
            filled: true,
            fillColor: colorScheme.surface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontFamily: "Gilroy Medium",
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordRequirements() {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            size: 16,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "La contraseña debe tener al menos 6 caracteres y contener letras",
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.primary,
                fontFamily: "Gilroy Medium",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      children: [
        const SizedBox(height: 24),
        
        // Botón de crear cuenta
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthCreateSuccess) {
              _showSuccessBottomSheet(state.responseAuth.email ?? 'Correo no disponible');
            }
            if (state is AuthCreateError) {
              _showErrorSnackBar(state.message);
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthCreateLoading;
            return SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleCreateAccount,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
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
                            colorScheme.onPrimary,
                          ),
                        ),
                      )
                    : Text(
                        "Crear Cuenta",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Gilroy Bold",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            );
          },
        ),
        
        const SizedBox(height: 24),
        
        // Divider
        Row(
          children: [
            Expanded(child: Divider(color: colorScheme.outline)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "o",
                style: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.7),
                  fontFamily: "Gilroy Medium",
                ),
              ),
            ),
            Expanded(child: Divider(color: colorScheme.outline)),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Link de login
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "¿Ya tienes una cuenta? ",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Gilroy Medium",
                color: colorScheme.onSurface,
              ),
            ),
            GestureDetector(
              onTap: () {
                context.replace('/login');
              },
              child: Text(
                "Inicia Sesión",
                style: TextStyle(
                  fontSize: 15,
                  color: colorScheme.primary,
                  fontFamily: "Gilroy Bold",
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 20),
      ],
    );
  }

  void _showErrorSnackBar(String message) {
    final colorScheme = Theme.of(context).colorScheme;
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: colorScheme.onError),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showSuccessBottomSheet(String email) {
    final colorScheme = Theme.of(context).colorScheme;
    
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      backgroundColor: colorScheme.surface,
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Handle indicator
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Success illustration
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  size: 60,
                  color: colorScheme.primary,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Success title
              Text(
                "¡Cuenta Creada!",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Gilroy Bold",
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              
              // Success message
              Text(
                "¡Felicidades! Tu cuenta ha sido creada exitosamente.",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Gilroy Medium",
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              // Email info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Te enviaremos un código de verificación a $email",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Gilroy Medium",
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              // Action buttons
              Column(
                children: [
                  // Send verification button
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is VerificationCodeCreateError) {
                        _showErrorSnackBar(state.message);
                      }
                      if (state is VerificationCodeCreateSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(Icons.check_circle, color: colorScheme.onPrimary),
                                const SizedBox(width: 8),
                                Text("Código de verificación enviado"),
                              ],
                            ),
                            backgroundColor: colorScheme.primary,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                        Navigator.pop(context);
                        context.replace('/verificate_email', extra: email);
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is VerificationCodeCreateLoading;
                      return SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : () {
                            context.read<AuthBloc>().add(VerificationCodeCreateEvent(email));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
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
                                      colorScheme.onPrimary,
                                    ),
                                  ),
                                )
                              : Text(
                                  "Enviar Código de Verificación",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Gilroy Bold",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Skip to login button
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.replace('/login');
                    },
                    child: Text(
                      "Iniciar Sesión Directamente",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Gilroy Medium",
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}