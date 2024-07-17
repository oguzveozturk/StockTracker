# StockTracker

StockTracker is an iOS application that tracks stock market data and provides detailed visualizations. The app is built using Swift and employs the MVVM-C (Model-View-ViewModel-Coordinator) architectural pattern. It utilizes GraphQL for data fetching and integrates with various modules to display stock information.

## Project Structure

The project is organized into several packages and modules to maintain a clean and scalable codebase. Here is a breakdown of the main components:

### App

- **AppCoordinator**: Main coordinator that initializes and manages child coordinators.

### Packages

- **ApolloModels**: Contains GraphQL models and related data handling code.

- **Base**: Includes base classes and protocols used across the app.

- **CommonView**: Houses common UI components used throughout the app.

- **Coordinator**: Contains the Coordinator protocol and related classes to handle navigation.

- **Entity**: Contains models that are mapped from Apollo generated models.

- **Extension**: Holds various extensions for different classes and utilities.

- **GraphQLClient**: Manages GraphQL client setup and configurations.

- **ModelGenerator**: Contains tools and scripts for generating models.

- **Modules**: Includes the main feature modules of the app.

- **StockDetailModule**: Handles the stock detail feature.

- **StockListModule**: Manages the stock list feature.

- **STChart**: Manages chart rendering and related functionalities.

- **UIExtension**: Contains extensions for UIKit components.

### Resources

- **Resources**: Contains app resources such as images, storyboards, and asset catalogs.

### Products

- **Products**: Compiled products and binaries.

### Frameworks

- **Frameworks**: External frameworks and libraries integrated into the project.

## ApolloCodeGen Scheme

The project uses Apollo GraphQL for data fetching. If you want to generate new GraphQL models, follow these steps::

1. Open the project in Xcode.

2. Change the scheme to `ApolloCodeGen` and set the run destination to `My Mac`.

3. Add your `.graphql` files to the `ModelGenerator` package.

4. Build the project. This will regenerate the models and place them in the `ApolloModels` folder.

## Usage

Once the app is installed and running, you can:

- View a list of stocks.

- Select a stock to view detailed information and visualizations.

- Navigate through different stock details using the coordinator pattern.

## Contributing

Contributions are welcome! If you have any suggestions or improvements, please create a pull request or open an issue.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
  
## Acknowledgements

- Special thanks to the creators of the open-source libraries used in this project.
