import 'package:flutter/material.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PaginaPrincipal(),
    );
  }
}

class PaginaPrincipal extends StatefulWidget {
  @override
  _PaginaPrincipalState createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  int _indiceSelecionado = 0;
  List<Widget> _paginas = [
    TelaLogin(),
    TelaCadastro(),
  ];

  void _aoItemSelecionado(int indice) {
    setState(() {
      _indiceSelecionado = indice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App de Login'),
      ),
      body: _paginas[_indiceSelecionado],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceSelecionado,
        onTap: _aoItemSelecionado,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Cadastro',
          ),
        ],
      ),
    );
  }
}

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  TextEditingController _controladorEmail = TextEditingController();
  TextEditingController _controladorSenha = TextEditingController();

  void _fazerLogin() {
    String email = _controladorEmail.text;
    String senha = _controladorSenha.text;
    // TODO: Implementar a lógica de login aqui
    print('Login: Email - $email, Senha - $senha');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controladorEmail,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controladorSenha,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _fazerLogin,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  TextEditingController _controladorEmail = TextEditingController();
  TextEditingController _controladorSenha = TextEditingController();
  TextEditingController _controladorConfirmarSenha = TextEditingController();

  bool _receberNotificacoes = false;
  String _generoSelecionado = 'Masculino';

  void _fazerCadastro() {
    String email = _controladorEmail.text;
    String senha = _controladorSenha.text;
    String confirmarSenha = _controladorConfirmarSenha.text;
    // TODO: Implementar a lógica de cadastro aqui
    print('Cadastro: Email - $email, Senha - $senha, Confirmar Senha - $confirmarSenha');
    print('Receber notificações: $_receberNotificacoes');
    print('Gênero selecionado: $_generoSelecionado');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controladorEmail,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controladorSenha,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _controladorConfirmarSenha,
              decoration: InputDecoration(
                labelText: 'Confirmar Senha',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Receber notificações:',
                  style: TextStyle(fontSize: 16.0),
                ),
                Checkbox(
                  value: _receberNotificacoes,
                  onChanged: (valor) {
                    setState(() {
                      _receberNotificacoes = valor ?? false;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Gênero:',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(width: 16.0),
                DropdownButton<String>(
                  value: _generoSelecionado,
                  onChanged: (valor) {
                    setState(() {
                      _generoSelecionado = valor ?? 'Masculino';
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 'Masculino',
                      child: Text('Masculino'),
                    ),
                    DropdownMenuItem(
                      value: 'Feminino',
                      child: Text('Feminino'),
                    ),
                    DropdownMenuItem(
                      value: 'Outro',
                      child: Text('Outro'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _fazerCadastro,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
