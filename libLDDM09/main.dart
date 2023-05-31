import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PaginaLogin(),
    );
  }
}

class PaginaLogin extends StatelessWidget {
  final dbHelper = DatabaseHelper();

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
            CampoSenha(onChanged: (String value) {}),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginaCadastro(dbHelper: dbHelper),
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
                    builder: (context) => PaginaCadastro(dbHelper: dbHelper),
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

class PaginaCadastro extends StatefulWidget {
  final DatabaseHelper dbHelper;

  PaginaCadastro({required this.dbHelper});

  @override
  _PaginaCadastroState createState() => _PaginaCadastroState();
}

class _PaginaCadastroState extends State<PaginaCadastro> {
  double _tamanhoFonte = 20.0;
  double _tamanhoFonteMin = 10.0;
  double _tamanhoFonteMax = 30.0;
  String _email = '';
  String _senha = '';
  String _generoSelecionado = '';
  bool _notificacoesEmail = false;
  bool _notificacoesCelular = false;
  bool _exibirSenha = false;

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
                CampoSenha(
                  onChanged: (value) {
                    setState(() {
                      _senha = value;
                    });
                  },
                  exibirSenha: _exibirSenha,
                ),
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
                    _cadastrar();
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

  void _cadastrar() async {
    await widget.dbHelper.initDatabase(); // Inicializa o banco de dados

    final novoUsuario = Usuario(
      email: _email,
      senha: _senha,
      genero: _generoSelecionado,
      notificacoesEmail: _notificacoesEmail,
      notificacoesCelular: _notificacoesCelular,
    );

    await widget.dbHelper.inserirUsuario(novoUsuario); // Insere o novo usuário no banco de dados

    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(content: Text('Usuário cadastrado com sucesso!')),
    );
  }
}

class CampoSenha extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final bool exibirSenha;

  const CampoSenha({
    Key? key,
    required this.onChanged,
    this.exibirSenha = false,
  }) : super(key: key);

  @override
  _CampoSenhaState createState() => _CampoSenhaState();
}

class _CampoSenhaState extends State<CampoSenha> {
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

class Usuario {
  final String email;
  final String senha;
  final String genero;
  final bool notificacoesEmail;
  final bool notificacoesCelular;

  Usuario({
    required this.email,
    required this.senha,
    required this.genero,
    required this.notificacoesEmail,
    required this.notificacoesCelular,
  });
}

class DatabaseHelper {
  static final _databaseName = "cadastro.db";
  static final _databaseVersion = 1;

  static final table = 'usuarios';

  static final columnId = '_id';
  static final columnEmail = 'email';
  static final columnSenha = 'senha';
  static final columnGenero = 'genero';
  static final columnNotificacoesEmail = 'notificacoes_email';
  static final columnNotificacoesCelular = 'notificacoes_celular';

  late Database _database;

  Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: _databaseVersion,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnEmail TEXT,
            $columnSenha TEXT,
            $columnGenero TEXT,
            $columnNotificacoesEmail INTEGER,
            $columnNotificacoesCelular INTEGER
          )
        ''');
      },
    );
  }

  Future<void> inserirUsuario(Usuario usuario) async {
    await _database.insert(
      table,
      {
        columnEmail: usuario.email,
        columnSenha: usuario.senha,
        columnGenero: usuario.genero,
        columnNotificacoesEmail: usuario.notificacoesEmail ? 1 : 0,
        columnNotificacoesCelular: usuario.notificacoesCelular ? 1 : 0,
      },
    );
  }
}
