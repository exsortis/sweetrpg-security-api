//
// 20210620_CreateUserTable.swift
// Copyright (c) 2021 Paul Schifferer.
//

import Fluent


struct CreateUserTable : Migration {
    func prepare(on database : Database) -> EventLoopFuture<Void> {
        database.schema(User.v20210620.schemaName)
                .id()
                .field(User.v20210620.name, .string, .required)
                .field(User.v20210620.username, .string, .required)
                //                .field("password", .string, .required)
                .field(User.v20210620.thirdPartyAuth, .string)
                .field(User.v20210620.thirdPartyAuthId, .string)
                .field(User.v20210620.email, .string, .required)
                .field(User.v20210620.profilePicture, .string)
                .unique(on: User.v20210620.username)
                .unique(on: User.v20210620.email)
                .create()
    }

    func revert(on database : Database) -> EventLoopFuture<Void> {
        database.schema(User.v20210620.schemaName)
                .delete()
    }
}

// extension User {
//     enum v20210601 {
//         static let schemaName = "users"
//         static let id = FieldKey(stringLiteral: "id")
//         static let name = FieldKey(stringLiteral: "name")
//         static let username = FieldKey(stringLiteral: "username")
//         static let thirdPartyAuth = FieldKey(stringLiteral: "thirdPartyAuth")
//         static let thirdPartyAuthId = FieldKey(stringLiteral: "thirdPartyAuthId")
//         static let email = FieldKey(stringLiteral: "email")
//         static let profilePicture = FieldKey(stringLiteral: "profilePicture")
//     }
// }
