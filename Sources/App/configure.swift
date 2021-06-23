//
// configure.swift
// Copyright (c) 2021 Paul Schifferer.
//

import Fluent
import FluentMongoDriver
import Vapor
import Redis
import Common
import ServiceDiscovery


public func configure(_ app : Application) throws {
    app.logger.logLevel = app.environment == .development ? .debug : .info

//    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    app.middleware.use(app.sessions.middleware)
    app.middleware.use(LogRequestMiddleware())

    guard let dbUrl = Environment.get("DATABASE_URL") else {
        fatalError("DATABASE_URL is not set in environment")
    }
    app.logger.debug("DATABASE_URL: \(dbUrl)")
    try app.databases.use(.mongo(connectionString: dbUrl), as: .mongo)

    let redisHostname = Environment.get("REDIS_HOSTNAME") ?? "localhost"
    let redisConfig = try RedisConfiguration(hostname: redisHostname)
    app.redis.configuration = redisConfig

    try migrations(app)

    app.sessions.use(.redis)
    app.caches.use(.fluent)

    try routes(app)

//    app.sendgrid.initialize()
    try app.autoMigrate().wait()

    // register with service discovery
    guard let serviceDiscoveryUrlString = Environment.get("SERVICE_DISCOVERY_URL"),
          let serviceDiscoveryUrl = URL(string: serviceDiscoveryUrlString) else {
        fatalError("SERVICE_DISCOVERY_URL missing or invalid")
    }
    app.logger.debug("SERVICE_DISCOVERY_URL: \(serviceDiscoveryUrl.absoluteString)")
    let sdConfig = ConsulServiceDiscovery<String, ConsulServiceDefinition>.Configuration(url: serviceDiscoveryUrl)
    let thisInstance = ConsulServiceDefinition(id: Constants.serviceName,
            name: app.http.server.configuration.hostname,
            port: app.http.server.configuration.port,
            check: ConsulServiceDefinition.Check(name: "ping check",
                    args: ["ping", "-c1", app.http.server.configuration.hostname],
                    interval: "30s",
                    status: "passing"))
    ConsulServiceDiscovery(configuration: sdConfig).register(Constants.serviceName, instances: [thisInstance])
}
