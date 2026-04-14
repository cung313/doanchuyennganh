import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const AuthLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1000;
    final isTablet = width >= 700 && width < 1000;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0B1220),
              Color(0xFF0F172A),
              Color(0xFF111827),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: isDesktop
              ? Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 56,
                          vertical: 40,
                        ),
                        child: _buildBrandPanel(),
                      ),
                    ),
                    SizedBox(
                      width: 520,
                      child: Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          child: _buildCard(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                )
              : Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 40 : 18,
                      vertical: 24,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: _buildCard(showBrandOnTop: true),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildBrandPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'SAMCO Admin',
          style: TextStyle(
            color: Colors.white,
            fontSize: 52,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: 620,
          child: Text(
            'Nền tảng quản lý bán hàng, tồn kho, khách hàng và đơn hàng cho doanh nghiệp vừa và nhỏ.',
            style: TextStyle(
              color: Color(0xFFCBD5E1),
              fontSize: 18,
              height: 1.7,
            ),
          ),
        ),
        SizedBox(height: 36),
        _FeatureItem('Quản lý sản phẩm, danh mục, tồn kho'),
        _FeatureItem('Theo dõi đơn hàng, khách hàng, công nợ'),
        _FeatureItem('Dashboard trực quan, dễ sử dụng'),
      ],
    );
  }

  Widget _buildCard({bool showBrandOnTop = false}) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(15, 23, 42, 0.28),
            blurRadius: 40,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showBrandOnTop) ...[
            const Text(
              'SAMCO Admin',
              style: TextStyle(
                color: Color(0xFF0F172A),
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Giải pháp quản trị hiện đại cho doanh nghiệp.',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
          ],
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 34,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          child,
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;

  const _FeatureItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 11,
            height: 11,
            decoration: const BoxDecoration(
              color: Color(0xFF38BDF8),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFFE2E8F0),
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}