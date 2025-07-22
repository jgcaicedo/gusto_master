# Gusto Master

Gusto Master es una aplicación Flutter que permite a los usuarios crear, listar, ver detalles y eliminar gustos personalizados, asociando cada gusto a un Pokémon obtenido desde la PokéAPI. Utiliza Hive para almacenamiento local y Bloc/Cubit para la gestión de estados.

## Características principales
- Listado de gustos guardados
- Creación de gustos personalizados
- Selección de Pokémon desde la PokéAPI
- Visualización de detalles de cada gusto
- Eliminación de gustos
- Manejo de estados de carga y error
- Diseño responsivo para móvil y tablet

## Estructura del proyecto
- **lib/core/**: Utilidades y constantes (temas, responsividad)
- **lib/data/**: Modelos, repositorios y fuentes de datos
- **lib/logic/**: Cubits y estados para la gestión de gustos y API
- **lib/presentation/**: Páginas y widgets de la interfaz de usuario
- **test/**: Pruebas unitarias y de widgets

## Instalación y ejecución
1. Clona el repositorio:
   ```sh
   git clone https://github.com/jgcaicedo/gusto_master.git
   ```
2. Instala dependencias:
   ```sh
   flutter pub get
   ```
3. Ejecuta la app:
   ```sh
   flutter run
   ```

## Pruebas
Para ejecutar las pruebas:
```sh
flutter test
```

## Tecnologías utilizadas
- Flutter
- Hive
- Bloc/Cubit
- GoRouter
- PokéAPI

## Autores
- Juan Caicedo

## Licencia
Este proyecto está bajo la licencia MIT.
