import Vapor
import Entity
import Presentation

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
    
    /** キャッシュが残っていれば何もしない。追加されたキャッシュの年齢は0である。 O(n) */
    func cache(_ username: Username, _ repositoryName: RepositoryName, _ data: TutorialPageData) {
        let key = Key(username: username, repositoryName: repositoryName)
        guard caches[key] == nil else { return }
        increment()
        caches[key] = .init(age: 0, data: data)
        clean()
    }
    
    /** キャッシュを探す O(n) */
    func find(_ username: Username, _ repositoryName: RepositoryName) -> TutorialPageData? {
        let key = Key(username: username, repositoryName: repositoryName)
        guard let value = caches[key] else { return nil }
        if value.age == 0 { return value.data }
        increment(lessThan: value.age)
        caches[key]?.reset()
        return value.data
    }
    
    /** 指定されたキャッシュを破棄する。その際、整合性の修正を行う O(nlogn) */
    func remove(_ username: Username, _ repositoryName: RepositoryName) {
        let key = Key(username: username, repositoryName: repositoryName)
        guard let value = caches[key] else { return }
        decrement(moreThan: value.age)
        caches[key] = nil
        adjust()
    }
    
    /**
     引数で渡された年齢よりも小さいキャッシュの年齢を一つ上げる。
     引数が渡されなかった場合、すべてのキャッシュの年齢を1つ上げる。
     O(n)
     */
    private func increment(lessThan: Int = MAX_CACHE_COUNT) {
        for (key, value) in caches {
            guard value.age < lessThan else { continue }
            caches[key]?.increment()
        }
    }
    
    /** 引数で渡された年齢よりも大きいキャッシュの年齢を下げる。 O(n) */
    private func decrement(moreThan: Int) {
        for (key, value) in caches {
            guard value.age > moreThan else { continue }
            caches[key]?.decrement()
        }
    }
    
    /** 最大年齢以上のキャッシュを破棄する。 O(n) */
    private func clean() {
        caches = caches.filter { $0.value.age < Self.MAX_CACHE_COUNT }
    }
    
    /** 整合性修正  O(nlogn) */
    private func adjust() {
        let sorted = caches.sorted { $0.value.age < $1.value.age }
        for (index, (key, _)) in sorted.enumerated() {
            caches[key]?.age = index
        }
        clean()
    }
}
