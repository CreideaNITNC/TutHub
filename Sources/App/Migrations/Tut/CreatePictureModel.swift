import Vapor
import Fluent

extension PictureModel {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {


            let extensionEnum = try await PictureFileExtension.allCases
                .reduce(database.enum("picture_extensions_type")) { builder, value in
                    builder.case(value.rawValue)
                }
                .create()
            
            let sample = PictureModel()
            
            try await database.schema(PictureModel.schema)
                .id()
                .field(sample.$filename.key, .string, .required)
                .field(sample.$extension.field.key, extensionEnum, .required)
                .field(sample.$bin.key, .data, .required)
                .field(sample.$number.key, .uint8, .required)
                .field(sample.$commit.$id.key, .uuid, .required, .references(CommitModel.schema, CommitModel().$id.key, onDelete: .cascade))
                .field(sample.$createdAt.$timestamp.key, .datetime, .required)
                .field(sample.$updatedAt.$timestamp.key, .datetime, .required)
                .unique(on: sample.$commit.$id.key, sample.$number.key)
                .create()
        }
        
        func revert(on database: FluentKit.Database) async throws {
            try await database.schema(PictureModel.schema).delete()
            try await database.enum("picture_extensions_type").delete()
        }
    }
}
