import Vapor

/** LRU のキャッシュ */
actor TutorialPageDataCache {
    
    private static let MAX_CACHE_COUNT = 20
    
    private struct Value {
        var age: Int
        var data: TutorialPageData
        
        mutating func increment() {
            age += 1
        }
        mutating func decrement() {
            age -= 1
        }
        mutating func reset() {
            age = 0
        }
    }
    
    private struct Key: Hashable, Equatable {
        var username: Username
        var repositoryName: RepositoryName
    }
    
    private var caches: [Key: Value] = [:]
    
    func cache(_ username: Username, _ repositoryName: RepositoryName, _ data: TutorialPageData) {
        increment()
        caches[.init(username: username, repositoryName: repositoryName)] = .init(age: 0, data: data)
        clean()
    }
    
    /** 使用されたもの以外の*/
    func find(_ username: Username, _ repositoryName: RepositoryName) -> TutorialPageData? {
        let key = Key(username: username, repositoryName: repositoryName)
        guard let value = caches[key] else { return nil }
        if value.age == 0 { return value.data }
        increment(lessThan: value.age)
        caches[key]?.reset()
        return value.data
    }
    
    func remove(_ username: Username, _ repositoryName: RepositoryName) {
        let key = Key(username: username, repositoryName: repositoryName)
        guard let value = caches[key] else { return }
        decrement(moreThan: value.age)
        caches[key] = nil
    }
    
    private func increment(lessThan: Int = MAX_CACHE_COUNT) {
        for (key, value) in caches {
            guard value.age < lessThan else { continue }
            caches[key]?.increment()
        }
    }
    
    private func decrement(moreThan: Int) {
        for (key, value) in caches {
            guard value.age > moreThan else { continue }
            caches[key]?.decrement()
        }
    }
    
    private func clean() {
        caches = caches.filter { $0.value.age < Self.MAX_CACHE_COUNT }
    }
}
