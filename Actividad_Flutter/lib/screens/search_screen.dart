import 'package:flutter/material.dart';

// Creamos la clase StatefulWidget
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  // Creamos el estado
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

/// Creamos la clase que hereda el estado
class _SearchScreenState extends State<SearchScreen> {
  // Creamos las variables
  bool _isFilterActive = false;
  int _searchType = 0;
  String _category = 'General';
  DateTime _searchDate = DateTime.now();

  // Controlador de texto
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Buscar')),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TextFiled
                TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Buscar contenido',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

                // Checkbox
                CheckboxListTile(
                    title: const Text("Incluir resultados "),
                    value: _isFilterActive,
                    onChanged: (val) => setState(() => _isFilterActive = val!)),

                // RadioButtons de Tipo de Busqueda
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Tipo de busqueda",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                RadioListTile<int>(
                    title: const Text("Exacta"),
                    value: 0,
                    groupValue: _searchType,
                    onChanged: (val) => setState(() => _searchType = val!)),
                RadioListTile<int>(
                    title: const Text("Relacionada"),
                    value: 1,
                    groupValue: _searchType,
                    onChanged: (val) => setState(() => _searchType = val!)),

                // DropDown
                DropdownButtonFormField<String>(
                    value: _category,
                    decoration: const InputDecoration(
                        labelText: 'Categoria de Busqueda'),
                    items: ['General', 'Noticias', 'Imagenes', 'Videos']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) => setState(() => _category = val!)),

                const SizedBox(height: 20),

                //DateTimePicker
                const Text(" Filtrar desde: "),
                TextButton.icon(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _searchDate,
                          firstDate: DateTime(2010),
                          lastDate: DateTime.now());
                      if (picked != null) setState(() => _searchDate = picked);
                    },
                    icon: const Icon(Icons.date_range),
                    label: Text("${_searchDate.day}/${_searchDate.month}/${_searchDate.year}")),
                const SizedBox(height: 20),

                // ElevatedButton
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => print("Buscando: ${_searchController.text}"),
                    child: const Text('INICIAR BÚSQUEDA'),
                  ),
                ),
              ],
            )));
  }
}