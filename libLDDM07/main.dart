import 'package:flutter/material.dart';
import 'dart:core';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => PaginaLogin(),
        '/listaLivros': (context) => PaginaListaLivros(),
      },
    );
  }
}

class PaginaLogin extends StatefulWidget {
  @override
  _PaginaLoginState createState() => _PaginaLoginState();
}

class _PaginaLoginState extends State<PaginaLogin> {
  TextEditingController _controladorEmail = TextEditingController();
  TextEditingController _controladorSenha = TextEditingController();

  void _fazerLogin() {
    String email = _controladorEmail.text;
    String senha = _controladorSenha.text;

    if (email == 'eu@gmail.com' && senha == '1234') {
      Navigator.pushNamed(context, '/listaLivros');
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Dados inválidos'),
            content: Text('Usuário e/ou senha incorreto(a).'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App de Login'),
      ),
      body: Center(
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
      ),
    );
  }
}

class Livro {
  final String titulo;
  final String autor;

  Livro(this.titulo, this.autor);
}

class PaginaListaLivros extends StatelessWidget {
  final List<String> livros = [
    'Harry Potter',
    'Watchmen',
    '1984',
    'One Piece',
    'JoJo',
    'Senhor dos Anéis',
    'Percy Jackson',
    'Dom Quixote',
    'Cem Anos de Solidão',
    'Crime e Castigo',
    'Orgulho e Preconceito',
    'O Grande Gatsby',
    'Ulisses',
    'Os Miseráveis',
    'Moby Dick',
    'O Conde de Monte Cristo',
    'O Pequeno Príncipe',
    'A Guerra dos Tronos',
    'O Senhor das Moscas',
    'A Revolução dos Bichos',
  ];

  void _exibirAlerta(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: Text('Você clicou no item ${index + 1}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Não'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Sim'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo(a), Usuário'),
      ),
      body: ListView.builder(
        itemCount: livros.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(livros[index]),
            onTap: () => _exibirAlerta(context, index),
          );
        },
      ),
    );
  }
}
