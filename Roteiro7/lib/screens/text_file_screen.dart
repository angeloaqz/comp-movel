import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/permission_service.dart';

class TextFileScreen extends StatefulWidget {
  const TextFileScreen({super.key});

  @override
  State<TextFileScreen> createState() => _TextFileScreenState();
}

class _TextFileScreenState extends State<TextFileScreen> {
  final PermissionService permissionService = PermissionService();
  final TextEditingController _textoController = TextEditingController();
  String _status = 'Digite um texto para salvar ou abra um arquivo .txt';

  Future<void> _salvarArquivo() async {
    final conteudo = _textoController.text;
    if (conteudo.isEmpty) {
      setState(() {
        _status = 'Digite algum texto antes de salvar.';
      });
      return;
    }

    var status = await permissionService.verificarArmazenamento();
    if (!status.isGranted && !status.isLimited) {
      await permissionService.solicitarArmazenamento();
    }

    final diretorio = await getApplicationDocumentsDirectory();
    final arquivo = File('${diretorio.path}/anotacao.txt');
    await arquivo.writeAsString(conteudo);

    setState(() {
      _status = 'Arquivo salvo em: ${arquivo.path}';
    });
  }

  Future<void> _abrirArquivo() async {
    final resultado = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (resultado != null && resultado.files.single.path != null) {
      final arquivo = File(resultado.files.single.path!);
      final conteudo = await arquivo.readAsString();
      setState(() {
        _textoController.text = conteudo;
        _status = 'Arquivo aberto: ${resultado.files.single.name}';
      });
    }
  }

  @override
  void dispose() {
    _textoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arquivos de Texto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _textoController,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: 'Conteúdo do arquivo .txt',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _salvarArquivo,
                  child: const Text('Salvar Arquivo'),
                ),
                ElevatedButton(
                  onPressed: _abrirArquivo,
                  child: const Text('Abrir Arquivo'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _status,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
