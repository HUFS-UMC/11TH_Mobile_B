import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import 'widgets/movie_log_text_form_field.dart';

// 피그마 회원가입 화면. 입력값과 Checkbox 상태가 변하므로 StatefulWidget을 쓴다.
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();

  // 피그마 시작 화면처럼 약관은 처음부터 선택된 상태로 보여 준다.
  bool _hasAgreed = true;
  bool _obscurePassword = true;

  // 가입 버튼은 세 입력값과 약관 동의가 모두 유효할 때만 활성화한다.
  bool get _canSignup {
    return _nicknameValidator(_nicknameController.text) == null &&
        _emailValidator(_emailController.text) == null &&
        _passwordValidator(_passwordController.text) == null &&
        _hasAgreed;
  }

  String? _nicknameValidator(String? value) {
    final nickname = value?.trim() ?? '';
    if (nickname.isEmpty) return '닉네임을 입력해 주세요.';
    if (nickname.length < 2) return '닉네임은 2글자 이상 입력해 주세요.';
    return null;
  }

  String? _emailValidator(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return '이메일 주소를 입력해 주세요.';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return '올바른 이메일 주소를 입력해 주세요.';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if ((value ?? '').isEmpty) return '비밀번호를 입력해 주세요.';
    if ((value ?? '').length < 8) return '비밀번호는 8자 이상 입력해 주세요.';
    return null;
  }

  @override
  void dispose() {
    // Controller와 FocusNode는 State가 사라질 때 반드시 정리한다.
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid || !_hasAgreed) return;

    // go는 회원가입 Route를 홈으로 교체한다. 뒤로 가도 회원가입으로 돌아가지 않는다.
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final screenHeight = screenSize.height;
    final isWideScreen = screenSize.width >= 700;

    return Scaffold(
      appBar: isWideScreen
          ? null
          : AppBar(
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.arrow_back),
                tooltip: '뒤로가기',
              ),
              title: const Text(
                '회원가입',
                style: TextStyle(
                  color: AppColors.violet,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // 700px 이상에서는 제공한 태블릿/웹 시안을 사용한다.
            final isWide = constraints.maxWidth >= 700;
            final wideTopSpacing = ((screenHeight - 600) / 2)
                .clamp(80, 300)
                .toDouble();

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(
                isWide ? 0 : 24,
                0,
                isWide ? 0 : 24,
                28,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (isWide) SizedBox(height: wideTopSpacing),
                        _WelcomeMessage(isWide: isWide),
                        SizedBox(height: isWide ? 42 : 25),
                        _SignupFields(
                          isWide: isWide,
                          nicknameController: _nicknameController,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          passwordFocusNode: _passwordFocusNode,
                          obscurePassword: _obscurePassword,
                          nicknameValidator: _nicknameValidator,
                          emailValidator: _emailValidator,
                          passwordValidator: _passwordValidator,
                          onChanged: (_) => setState(() {}),
                          onNicknameSubmitted: (_) =>
                              FocusScope.of(context).nextFocus(),
                          onEmailSubmitted: (_) =>
                              FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode),
                          onPasswordSubmitted: (_) => _submit(),
                          onPasswordVisibilityPressed: () {
                            setState(
                              () => _obscurePassword = !_obscurePassword,
                            );
                          },
                        ),
                        SizedBox(
                          height: isWide
                              ? 28
                              : screenHeight >= 760
                              ? 175
                              : 56,
                        ),
                        _AgreementSection(
                          hasAgreed: _hasAgreed,
                          onChanged: (value) {
                            setState(() => _hasAgreed = value ?? false);
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _canSignup ? _submit : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.violet,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor: AppColors.disabledButton,
                              disabledForegroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              '가입하기',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: isWide ? 24 : 38),
                        const _LoginPrompt(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _WelcomeMessage extends StatelessWidget {
  const _WelcomeMessage({required this.isWide});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: isWide
          ? const [
              Text(
                '회원가입',
                style: TextStyle(
                  color: AppColors.violet,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text('MovieLog에 오신 것을 환영합니다!', style: TextStyle(fontSize: 16)),
            ]
          : const [
              Text('환영합니다!', style: TextStyle(fontSize: 18)),
              SizedBox(height: 6),
              Text('간단한 정보만 입력하고 시작해보세요.', style: TextStyle(fontSize: 18)),
            ],
    );
  }
}

class _SignupFields extends StatelessWidget {
  const _SignupFields({
    required this.isWide,
    required this.nicknameController,
    required this.emailController,
    required this.passwordController,
    required this.passwordFocusNode,
    required this.obscurePassword,
    required this.nicknameValidator,
    required this.emailValidator,
    required this.passwordValidator,
    required this.onChanged,
    required this.onNicknameSubmitted,
    required this.onEmailSubmitted,
    required this.onPasswordSubmitted,
    required this.onPasswordVisibilityPressed,
  });

  final bool isWide;
  final TextEditingController nicknameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  final bool obscurePassword;
  final String? Function(String?) nicknameValidator;
  final String? Function(String?) emailValidator;
  final String? Function(String?) passwordValidator;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onNicknameSubmitted;
  final ValueChanged<String> onEmailSubmitted;
  final ValueChanged<String> onPasswordSubmitted;
  final VoidCallback onPasswordVisibilityPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MovieLogTextFormField(
          label: '닉네임',
          hintText: isWide ? '영화로운 닉네임을 입력하세요' : '닉네임을 입력해주세요',
          controller: nicknameController,
          validator: nicknameValidator,
          onChanged: onChanged,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: onNicknameSubmitted,
        ),
        SizedBox(height: isWide ? 24 : 12),
        MovieLogTextFormField(
          label: isWide ? '이메일 주소' : '이메일',
          hintText: isWide ? 'example@movielog.com' : '이메일 주소를 입력해주세요',
          controller: emailController,
          validator: emailValidator,
          onChanged: onChanged,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: onEmailSubmitted,
        ),
        SizedBox(height: isWide ? 24 : 12),
        MovieLogTextFormField(
          label: '비밀번호',
          hintText: isWide ? '영문, 숫자 포함 8자 이상' : '비밀번호를 입력해주세요',
          controller: passwordController,
          focusNode: passwordFocusNode,
          validator: passwordValidator,
          onChanged: onChanged,
          obscureText: obscurePassword,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: onPasswordSubmitted,
          suffixIcon: IconButton(
            onPressed: onPasswordVisibilityPressed,
            icon: Icon(
              obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            tooltip: obscurePassword ? '비밀번호 표시' : '비밀번호 숨기기',
          ),
        ),
      ],
    );
  }
}

class _AgreementSection extends StatelessWidget {
  const _AgreementSection({required this.hasAgreed, required this.onChanged});

  final bool hasAgreed;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: hasAgreed,
          onChanged: onChanged,
          activeColor: AppColors.violet,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(width: 4),
        const Text('필수 약관에 동의합니다', style: TextStyle(fontSize: 17)),
      ],
    );
  }
}

class _LoginPrompt extends StatelessWidget {
  const _LoginPrompt();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('이미 계정이 있나요?', style: TextStyle(fontSize: 16)),
          TextButton(
            onPressed: () => debugPrint('로그인 버튼을 눌렀습니다.'),
            child: const Text('로그인'),
          ),
        ],
      ),
    );
  }
}
