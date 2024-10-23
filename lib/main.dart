import 'package:flut_8pr/api.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Рецепты',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RecipeListScreen(),
    );
  }
}

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({Key? key}) : super(key: key);

  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final Dio _dio = Dio();
  final String _apiUrl = 'https://api.api-ninjas.com/v1/recipe';
  final String _apiKey = API;

  List<dynamic> _recipes = [];
  bool _isLoading = false;

  Future<void> fetchRecipes(String query) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await _dio.get(
        _apiUrl,
        queryParameters: {'query': query},
        options: Options(
          headers: {'X-Api-Key': _apiKey},
        ),
      );
      setState(() {
        _recipes = response.data;
      });
    } catch (e) {
      print('Ошибка при получении рецептов: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Рецепты'),
      ),
      body: Column(
        children: [
          // Прокручиваемый ряд изображений
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMtt3aOrfYZ1KnQq4GK0vf9gkNBC07f72UWQ&s',
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    height: 150,
                    width: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: 'https://images.theconversation.com/files/607554/original/file-20240717-17-a2w33d.jpg?ixlib=rb-4.1.0&rect=46%2C34%2C3811%2C2533&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip',
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    height: 150,
                    width: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: 'https://media.cnn.com/api/v1/images/stellar/prod/220511094011-01-body-fried-foods-churros.jpg?q=w_1110,c_fill',
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    height: 150,
                    width: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: 'https://i0.wp.com/www.drdavidludwig.com/wp-content/uploads/2017/01/1-RIS_6IbCLYv1X3bzYW1lmA.jpeg?fit=800%2C552&ssl=1',
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    height: 150,
                    width: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTG5hxs8nAQLFk0DQ-nmREiLyQKy2GuL_sozw&s',
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    height: 150,
                    width: 150,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Поиск рецептов',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (query) {
                fetchRecipes(query);
              },
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index) {
                final recipe = _recipes[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            recipe['title'] ?? 'Без названия',
                            textAlign: TextAlign.start,
                          ),
                          subtitle: Text(
                            recipe['ingredients']?.replaceAll('|', '\n') ?? 'Нет ингредиентов',
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
