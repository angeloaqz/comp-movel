import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import '../services/pokemon_service.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final TextEditingController _controller = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final PokemonService _pokemonService = PokemonService();

  Pokemon? pokemon;
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    searchPokemon('1');
  }

  Future<void> searchPokemon(String term) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final result = await _pokemonService.fetchPokemon(term);
      setState(() {
        pokemon = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        pokemon = null;
        isLoading = false;
        errorMessage = 'Erro ao buscar Pokémon.';
      });
    }
  }

  Future<void> playCry() async {
    if (pokemon != null && pokemon!.cryUrl.isNotEmpty) {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(pokemon!.cryUrl));
    }
  }

  String formatName(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }

  void _anterior() {
    if (pokemon != null && pokemon!.id > 1) {
      searchPokemon((pokemon!.id - 1).toString());
    }
  }

  void _proximo() {
    if (pokemon != null) {
      searchPokemon((pokemon!.id + 1).toString());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex com API'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Digite o nome ou número do Pokémon',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) {
                        searchPokemon(value.trim());
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      searchPokemon(_controller.text.trim());
                    }
                  },
                  child: const Text('Buscar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isLoading) const CircularProgressIndicator(),
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  errorMessage,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
              ),
            if (!isLoading && pokemon != null)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formatName(pokemon!.name),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Número: ${pokemon!.id}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    if (pokemon!.imageUrl.isNotEmpty)
                      Image.network(
                        pokemon!.imageUrl,
                        height: 200,
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: playCry,
                      icon: const Icon(Icons.volume_up),
                      label: const Text('Tocar som'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: pokemon!.id > 1 ? _anterior : null,
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Anterior'),
                        ),
                        ElevatedButton.icon(
                          onPressed: _proximo,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Próximo'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
