import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(AppLogin());
}

class PerfilUsuario {
  final String nomeUsuario;
  final String email;

  PerfilUsuario({required this.nomeUsuario, required this.email});
}

class AppLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PaginaLogin(),
    );
  }
}

class PaginaLogin extends StatefulWidget {
  @override
  _EstadoPaginaLogin createState() => _EstadoPaginaLogin();
}

class _EstadoPaginaLogin extends State<PaginaLogin> {
  TextEditingController controladorEmail = TextEditingController();
  TextEditingController controladorSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: controladorEmail,
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
            ),
            SizedBox(height: 16.0),
            CampoSenha(controller: controladorSenha),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                String email = controladorEmail.text;
                String senha = controladorSenha.text;
                _realizarLogin(email, senha, context);
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginaCadastro(),
                  ),
                );
              },
              child: Text('Criar conta'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _realizarLogin(
      String email, String senha, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? emailSalvo = prefs.getString('email');
    String? senhaSalva = prefs.getString('senha');

    if (email == emailSalvo && senha == senhaSalva) {
      String nomeUsuario = prefs.getString('nomeUsuario') ?? '';
      PerfilUsuario usuario = PerfilUsuario(nomeUsuario: nomeUsuario, email: email);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaginaBoasVindas(usuario: usuario),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro de autenticação'),
            content: Text('E-mail ou senha incorretos.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fechar'),
              ),
            ],
          );
        },
      );
    }
  }
}

class PaginaCadastro extends StatefulWidget {
  @override
  _EstadoPaginaCadastro createState() => _EstadoPaginaCadastro();
}

class _EstadoPaginaCadastro extends State<PaginaCadastro> {
  TextEditingController controladorNomeUsuario = TextEditingController();
  TextEditingController controladorEmail = TextEditingController();
  TextEditingController controladorSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: controladorNomeUsuario,
                  decoration: InputDecoration(
                    labelText: 'Nome de usuário',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: controladorEmail,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                  ),
                ),
                SizedBox(height: 16.0),
                CampoSenha(controller: controladorSenha),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    String nomeUsuario = controladorNomeUsuario.text;
                    String email = controladorEmail.text;
                    String senha = controladorSenha.text;
                    _realizarCadastro(nomeUsuario, email, senha, context);
                  },
                  child: Text('Cadastrar'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _realizarCadastro(String nomeUsuario, String email, String senha,
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nomeUsuario', nomeUsuario);
    await prefs.setString('email', email);
    await prefs.setString('senha', senha);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Conta criada!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}

class PaginaBoasVindas extends StatelessWidget {
  final PerfilUsuario usuario;

  const PaginaBoasVindas({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo'),
      ),
      body: Center(
        child: Text(
          'Olá, ${usuario.nomeUsuario}!',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaginaListaLivros(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaginaPerfil(usuario: usuario),
              ),
            );
          }
        },
      ),
    );
  }
}

class PaginaPerfil extends StatelessWidget {
  final PerfilUsuario usuario;

  const PaginaPerfil({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nome de usuário: ${usuario.nomeUsuario}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'E-mail: ${usuario.email}',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}

class PaginaListaLivros extends StatelessWidget {
  final List<String> livros = [
    'Harry Potter',
    'One Piece',
    '1984',
    'Watchmen',
    'A Batalha do Labirinto',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Livros'),
      ),
      body: ListView.builder(
        itemCount: livros.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(livros[index]),
          );
        },
      ),
    );
  }
}

class CampoSenha extends StatefulWidget {
  final TextEditingController controller;

  const CampoSenha({Key? key, required this.controller}) : super(key: key);

  @override
  _CampoSenhaState createState() => _CampoSenhaState();
}

class _CampoSenhaState extends State<CampoSenha> {
  bool _senhaOculta = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _senhaOculta,
      decoration: InputDecoration(
        labelText: 'Senha',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _senhaOculta = !_senhaOculta;
            });
          },
          icon: Icon(
            _senhaOculta ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}
