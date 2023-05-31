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
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
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
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
            ),
            SizedBox(height: 16.0),
            PasswordTextField(onChanged: (String value) {  },), // Utilizando o novo widget PasswordTextField
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CadastroPage(),
                  ),
                );
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CadastroPage(),
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
}

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  double _tamanhoFonte = 20.0;
  double _tamanhoFonteMin = 10.0;
  double _tamanhoFonteMax = 30.0;
  String _email = '';
  String _senha = '';
  String _generoSelecionado = '';
  bool _notificacoesEmail = false;
  bool _notificacoesCelular = false;
  bool _exibirSenha = false; // Variável para controlar a exibição da senha

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
                Slider(
                  value: _tamanhoFonte,
                  min: _tamanhoFonteMin,
                  max: _tamanhoFonteMax,
                  divisions: (_tamanhoFonteMax - _tamanhoFonteMin).round(),
                  label: _tamanhoFonte.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _tamanhoFonte = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'Exemplo de texto',
                  style: TextStyle(fontSize: _tamanhoFonte),
                ),
                SizedBox(height: 24.0),
                Text(
                  'Gênero',
                  style: TextStyle(fontSize: _tamanhoFonte),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Masculino',
                          style: TextStyle(fontSize: _tamanhoFonte),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: _generoSelecionado == 'Masculino'
                              ? Colors.blue
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Feminino',
                          style: TextStyle(fontSize: _tamanhoFonte),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: _generoSelecionado == 'Feminino'
                              ? Colors.blue
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Outro',
                          style: TextStyle(fontSize: _tamanhoFonte),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: _generoSelecionado == 'Outro'
                              ? Colors.blue
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.0),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                  ),
                ),
                SizedBox(height: 16.0),
                PasswordTextField(
                  onChanged: (value) {
                    setState(() {
                      _senha = value;
                    });
                  },
                  exibirSenha: _exibirSenha,
                ), // Utilizando o novo widget PasswordTextField
                SizedBox(height: 24.0),
                CheckboxListTile(
                  value: _notificacoesEmail,
                  onChanged: (value) {
                    setState(() {
                      _notificacoesEmail = value ?? false;
                    });
                  },
                  title: Text(
                    'Notificações por e-mail',
                    style: TextStyle(fontSize: _tamanhoFonte),
                  ),
                ),
                CheckboxListTile(
                  value: _notificacoesCelular,
                  onChanged: (value) {
                    setState(() {
                      _notificacoesCelular = value ?? false;
                    });
                  },
                  title: Text(
                    'Notificações por celular',
                    style: TextStyle(fontSize: _tamanhoFonte),
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    // Realize a funcionalidade de cadastro aqui
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
}

class PasswordTextField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final bool exibirSenha;

  const PasswordTextField({
    Key? key,
    required this.onChanged,
    this.exibirSenha = false,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _ocultarSenha = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      obscureText: _ocultarSenha,
      decoration: InputDecoration(
        labelText: 'Senha',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _ocultarSenha = !_ocultarSenha;
            });
          },
          icon: Icon(
            _ocultarSenha ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}
