import Vapor
import Fluent

extension Application {
    
    private static var _seeders: Seeders = .init()
    
    var seeders: Seeders {
        Self._seeders
    }
    
    func seedersSeed() async throws {
        try await Self._seeders.seed(db)
    }
    
    func seedersRevert() async throws {
        try await Self._seeders.revert(db)
        Self._seeders = .init()
    }
}

protocol Seedable {
    func seed(_ db: Database) async throws
    
    func revert(_ db: Database) async throws
}

class Seeders {
    
    var seeders: [Seedable] = []
    
    func add(_ seeder: Seedable) {
        seeders.append(seeder)
    }
    
    func seed(_ db: Database) async throws {
        for seeder in seeders {
            try await seeder.seed(db)
        }
    }
    
    func revert(_ db: Database) async throws {
        for seeder in seeders.reversed() {
            try await seeder.revert(db)
        }
    }
    
    func of<T>(_: T.Type) -> T {
        seeders.first { seeder in
            type(of: seeder) == T.self
        }! as! T
    }
}
