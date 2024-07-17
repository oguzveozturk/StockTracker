import Foundation
import ArgumentParser
import ApolloCodegenLib

@main
struct ModelGenerator: AsyncParsableCommand {
    static var configuration: CommandConfiguration = CommandConfiguration(abstract: "A Swift CLI to generate API from Apollo schema.")

    @Argument(help: "Use 'download' to download and update the schema. Or 'generate' to update API.")
    var action: CommandAction = .all

    @Option(help: "Add access token if you needed")
    var token: String = ""
    
    @Option(help: "The target to generate code for.")
    var targetName: String = "ApolloModels"
    
    func run() async throws {
        
        let sourceRootURL = URL(fileURLWithPath: #filePath.description)
            .deletingLastPathComponent()
            .parentFolderURL()
            .parentFolderURL()
        
        switch action {
        case .all:
            await download(with: sourceRootURL)
            await generate(from: sourceRootURL)
        case .download:
            await download(with: sourceRootURL)
        case .generate:
            await generate(from: sourceRootURL)
        }
    }

    private func generate(from sourceRootURL: URL) async {
        print("📦 Generating...")
        let input = ApolloCodegenConfiguration.FileInput(
            schemaSearchPaths: ["\(sourceRootURL)/**/**/*.graphqls"],
            operationSearchPaths: ["\(sourceRootURL)/**/**/*.graphql"]
        )

        let packagesPath = sourceRootURL.parentFolderURL()
        
        let outputPath = packagesPath
            .childFolderURL(folderName: targetName)
            .childFolderURL(folderName: "Sources")
            .childFolderURL(folderName: "ApolloModels")

        let output = ApolloCodegenConfiguration.FileOutput(
            schemaTypes: ApolloCodegenConfiguration.SchemaTypesFileOutput(
                path: outputPath.path,
                moduleType: .other),
            operations: .absolute(path: outputPath.path, accessModifier: .public),
            testMocks: .none
        )

        let options: ApolloCodegenConfiguration.OutputOptions = ApolloCodegenConfiguration.OutputOptions(
            schemaDocumentation: .include,
            pruneGeneratedFiles: true
        )
        
        let configuration = ApolloCodegenConfiguration(
            schemaNamespace: "ApolloModels",
            input: input,
            output: output,
            options: options
        )

        do {
            try await ApolloCodegen.build(with: configuration)
            print("✅ Generated at \(outputPath.path)")
        } catch {
            print("Failed to generate: \(error.localizedDescription)")
        }
    }

    private func download(with sourceRootURL: URL) async {
        print("🚀 Downloading...")

        do {
            let endpointURL: URL = URL(string: "https://your-api-url.com/")!
            let outputPath = try sourceRootURL
                .childFolderURL(folderName: "Schema")
                .childFileURL(fileName: "schema.graphqls")
            let configuration = ApolloSchemaDownloadConfiguration(
                using: .introspection(endpointURL: endpointURL, outputFormat: .SDL),
                headers: [.init(
                    key: "Authorization",
                    value: "bearer \(token)"
                )],
                outputPath: outputPath.path
            )
            try await ApolloSchemaDownloader.fetch(configuration: configuration)
            print("✅ Downloaded schema at \(outputPath.path)")
        } catch {
            print("Failed to download: \(error.localizedDescription)")
        }
    }
}

enum CommandAction: ExpressibleByArgument {
    case all
    case download
    case generate

    public init?(argument: String) {
        switch argument.lowercased() {
        case "all":
            self = .all
        case "download":
            self = .download
        case "generate":
            self = .generate
        default:
            return nil
        }
    }
}
