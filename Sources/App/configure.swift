import FluentSQLite
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    try registerProvider(&services)
    try registerRouter(&services)
    registerMiddleware(&services)
    try registerDatabase(&services)
    configureMigration(&services)
}

private func registerProvider(_ services: inout Services) throws {
    try services.register(FluentSQLiteProvider())
}

private func registerRouter(_ services: inout Services) throws {
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
}

private func registerMiddleware(_ services: inout Services) {
    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)
}

private func registerDatabase(_ services: inout Services) throws {
    let sqlite = try SQLiteDatabase(storage: .memory)
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    services.register(databases)
}

private func configureMigration(_ services: inout Services) {
    var migrations = MigrationConfig()
    migrations.add(model: Film.self, database: .sqlite)
    migrations.add(model: Genre.self, database: .sqlite)
    services.register(migrations)
}