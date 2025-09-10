import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _nameError = false;
  bool _emailError = false;
  bool _passwordError = false;
  bool _confirmPasswordError = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _register() {
    setState(() {
      _nameError = _nameController.text.isEmpty;
      _emailError = _emailController.text.isEmpty;
      _passwordError = _passwordController.text.isEmpty;
      _confirmPasswordError = _confirmPasswordController.text.isEmpty ||
          _confirmPasswordController.text != _passwordController.text;
    });

    if (!_nameError &&
        !_emailError &&
        !_passwordError &&
        !_confirmPasswordError) {
      Navigator.pushReplacementNamed(context, '/loading');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF00294F),
              Color(0xFF001426),
              Color(0xFF010A12),
              Color(0xFF00294F)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      48,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Image.asset(
                      'assets/images/skateparks/logo-branca.png',
                      height: 234,
                      width: 234,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Junte-se à comunidade skate',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF08243E),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          TextField(
                            controller: _nameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Nome completo',
                              prefixIcon: const Icon(
                                Icons.person_outlined,
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: _nameError ? Colors.red : Colors.white,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: _nameError ? Colors.red : Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: _nameError ? Colors.red : Colors.black,
                                  width: 2,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: _nameError ? Colors.red : Colors.white70,
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                            ),
                            textCapitalization: TextCapitalization.words,
                            onChanged: (value) {
                              if (_nameError && value.isNotEmpty) {
                                setState(() {
                                  _nameError = false;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _emailController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: const Icon(Icons.email_outlined,
                                  color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color:
                                      _emailError ? Colors.red : Colors.white,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color:
                                      _emailError ? Colors.red : Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color:
                                      _emailError ? Colors.red : Colors.black,
                                  width: 2,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color:
                                    _emailError ? Colors.red : Colors.white70,
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              errorText: _emailError &&
                                      _emailController.text.isNotEmpty
                                  ? 'Email inválido'
                                  : null,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              if (_emailError && value.isNotEmpty) {
                                setState(() {
                                  _emailError = false;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _passwordController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              prefixIcon: const Icon(Icons.lock_outlined,
                                  color: Colors.white),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: _passwordError
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: _passwordError
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: _passwordError
                                      ? Colors.red
                                      : Colors.black,
                                  width: 2,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: _passwordError
                                    ? Colors.red
                                    : Colors.white70,
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                            ),
                            obscureText: _obscurePassword,
                            onChanged: (value) {
                              if (_passwordError && value.isNotEmpty) {
                                setState(() {
                                  _passwordError = false;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _confirmPasswordController,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Confirmar senha',
                              prefixIcon: const Icon(Icons.lock_outlined,
                                  color: Colors.white),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: _confirmPasswordError
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: _confirmPasswordError
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: _confirmPasswordError
                                      ? Colors.red
                                      : Colors.black,
                                  width: 2,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: _confirmPasswordError
                                    ? Colors.red
                                    : Colors.white70,
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.1),
                              errorText: _confirmPasswordError &&
                                      _confirmPasswordController.text.isNotEmpty
                                  ? 'As senhas não coincidem'
                                  : null,
                            ),
                            obscureText: _obscureConfirmPassword,
                            onChanged: (value) {
                              setState(() {
                                _confirmPasswordError = value.isNotEmpty &&
                                    value != _passwordController.text;
                              });
                            },
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _register,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              child: Text(
                                'Cadastrar',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Já tem conta? Faça login',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
