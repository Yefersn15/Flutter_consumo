import 'package:flutter/material.dart';
import 'counter_example.dart';
import 'todo_example.dart';
import 'column_demo.dart';
import 'scaffold_demo.dart';
import 'text_demo.dart';
import 'row_demo.dart';
import 'container_demo.dart';
import 'imagenes_demo.dart';
import 'imagen_text.dart';
import 'actividad1.dart';
import 'scrollbar_demo.dart';
import 'drawer_routes_demo.dart';
import 'simple_routes_demo.dart';
import 'checkbox_demo.dart';
import 'radiobutton_demo.dart';
import 'slider_demo.dart';
import 'textfield_demo.dart';
import 'elevatedbutton_demo.dart';
import 'floatingactionbutton_demo.dart';
import 'datetimepicker_demo.dart';
import 'bottomnavigation_demo.dart';
import 'search_screen.dart';
import 'nav_demo.dart';
import 'globalkey_textformfield_screen.dart';
import 'simple_email_form_validation_screen.dart';
import 'multifield_form_with_data_display_screen.dart';
// user_crud_page y email_page ahora están en el Drawer de home_page.dart

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  int _selectedIndex = 0;

  // Títulos de las pestañas (ahora solo 3)
  static const List<String> _tabTitles = ['Widgets', 'StatefullWidgets', 'Formularios'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menú de ejemplos - ${_tabTitles[_selectedIndex]}'),
      ),
        body: _selectedIndex == 0
          ? _buildWidgetsList(context)
          : _selectedIndex == 1
            ? _buildStatefulWidgetsList(context)
            : _buildFormsList(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        unselectedItemColor: Colors.grey, // Iconos no seleccionados en gris
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets),
            label: 'Widgets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.touch_app),
            label: 'StatefullWidgets', // Nombre cambiado
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Formularios',
          ),
          // Eliminado el ítem de Servicios
        ],
      ),
      persistentFooterButtons: [
        Center(
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text('Adios', style: TextStyle(fontSize: 16)),
            ),
          ),
        ),
      ],
    );
  }

  // Lista de la primera pestaña (Widgets)
  ListView _buildWidgetsList(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.add_circle_outline),
          title: const Text('Contador'),
          subtitle: const Text('Incrementar, decrementar y resetear'),
          onTap: () => _navigateTo(context, const CounterExample()),
        ),
        ListTile(
          leading: const Icon(Icons.checklist),
          title: const Text('Lista de tareas'),
          subtitle: const Text('TODO simple'),
          onTap: () => _navigateTo(context, const TodoExample()),
        ),
        ListTile(
          leading: const Icon(Icons.view_column),
          title: const Text('Column'),
          subtitle: const Text('Demostración de Column'),
          onTap: () => _navigateTo(context, const Column_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.layers),
          title: const Text('Scaffold'),
          subtitle: const Text('Demostración de Scaffold'),
          onTap: () => _navigateTo(context, const Scaffold_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.text_fields),
          title: const Text('Text'),
          subtitle: const Text('Ejemplo de estilo de texto'),
          onTap: () => _navigateTo(context, const Text_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.view_stream),
          title: const Text('Row'),
          subtitle: const Text('Demostración de Row'),
          onTap: () => _navigateTo(context, const Row_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.crop_square),
          title: const Text('Container'),
          subtitle: const Text('Demostración de Container'),
          onTap: () => _navigateTo(context, const Container_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text('Image'),
          subtitle: const Text('Mostrar imagen desde URL'),
          onTap: () => _navigateTo(context, const Imagenes_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.rotate_right),
          title: const Text('Image de pruebas'),
          subtitle: const Text('Rotación de imagen (pruebas)'),
          onTap: () => _navigateTo(context, const ImageRotationText()),
        ),
        ListTile(
          leading: const Icon(Icons.assignment),
          title: const Text('Actividad1'),
          subtitle: const Text('Actividad con filas y columnas'),
          onTap: () => _navigateTo(context, const Actividad1()),
        ),
        ListTile(
          leading: const Icon(Icons.drag_handle),
          title: const Text('Scrollbar personalizado'),
          subtitle: const Text('Barra de desplazamiento gruesa con colores'),
          onTap: () => _navigateTo(context, const Scrollbar_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.menu_open),
          title: const Text('Drawer y navegación'),
          subtitle: const Text('Ejemplo de menú lateral con rutas'),
          onTap: () => _navigateTo(context, const DrawerRoutesDemo()),
        ),
        ListTile(
          leading: const Icon(Icons.swap_horiz),
          title: const Text('Navegación simple'),
          subtitle: const Text('FirstRoute / SecondRoute'),
          onTap: () => _navigateTo(context, const SimpleRoutesDemo()),
        ),
      ],
    );
  }

  // Lista de la segunda pestaña (StatefullWidgets)
  ListView _buildStatefulWidgetsList(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.check_box),
          title: const Text('Checkbox'),
          subtitle: const Text('Ejemplo de Checkbox'),
          onTap: () => _navigateTo(context, const Checkbox_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.radio_button_checked),
          title: const Text('Radio'),
          subtitle: const Text('Ejemplo de Radio buttons'),
          onTap: () => _navigateTo(context, const Radio_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.linear_scale),
          title: const Text('Slider'),
          subtitle: const Text('Ejemplo de Slider'),
          onTap: () => _navigateTo(context, const Slider_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.keyboard),
          title: const Text('TextField'),
          subtitle: const Text('Ejemplo de TextField'),
          onTap: () => _navigateTo(context, const TextField_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.radio_button_on),
          title: const Text('ElevatedButton'),
          subtitle: const Text('Ejemplo de ElevatedButton'),
          onTap: () => _navigateTo(context, const ElevatedButton_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('FloatingActionButton'),
          subtitle: const Text('Ejemplo de FAB'),
          onTap: () => _navigateTo(context, const Fab_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.date_range),
          title: const Text('DateTimePicker'),
          subtitle: const Text('Seleccionar fecha con DatePicker'),
          onTap: () => _navigateTo(context, const DateTimePicker_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.menu),
          title: const Text('BottomNavigationBar'),
          subtitle: const Text('Ejemplo de BottomNavigationBar'),
          onTap: () => _navigateTo(context, const BottomNavigation_Demo()),
        ),
        ListTile(
          leading: const Icon(Icons.search),
          title: const Text('Buscador avanzado'),
          subtitle: const Text('Pantalla de búsqueda con filtros'),
          onTap: () => _navigateTo(context, const SearchScreen()),
        ),
        ListTile(
          leading: const Icon(Icons.navigation),
          title: const Text('Demo navegación'),
          subtitle: const Text('Ejemplo de BottomNavigation interno'),
          onTap: () => _navigateTo(context, const NavDemoPage()),
        ),
      ],
    );
  }

  // Lista de la tercera pestaña (Formularios)
  ListView _buildFormsList(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text('GlobalKey & TextFormField'),
          subtitle: const Text('Uso de GlobalKey y TextFormField'),
          onTap: () => _navigateTo(context, const GlobalKeyTextFormFieldScreen()),
        ),
        ListTile(
          leading: const Icon(Icons.email),
          title: const Text('Validación email simple'),
          subtitle: const Text('Formulario simple de email con validación'),
          onTap: () => _navigateTo(context, const SimpleEmailFormValidationScreen()),
        ),
        ListTile(
          leading: const Icon(Icons.list),
          title: const Text('Formulario múltiple con datos'),
          subtitle: const Text('Múltiples campos + vista de datos guardados'),
          onTap: () => _navigateTo(context, const MultiFieldFormWithDataDisplayScreen()),
        ),
      ],
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}