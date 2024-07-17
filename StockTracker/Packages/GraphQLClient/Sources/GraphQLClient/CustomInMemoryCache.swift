import Foundation
import Apollo

public final class CustomInMemoryCache: NormalizedCache {
    private var records: RecordSet

    public init(records: RecordSet = RecordSet()) {
        self.records = records
    }

    public func loadRecords(forKeys keys: Set<CacheKey>) throws -> [CacheKey: Record] {
        return keys.reduce(into: [:]) { result, key in
            result[key] = records[key]
        }
    }

    public func removeRecord(for key: CacheKey) throws {
        records.removeRecord(for: key)
    }

    public func merge(records newRecords: RecordSet) throws -> Set<CacheKey> {
        if newRecords.storage.count == 1,
           newRecords.storage.first?.value.fields.count == 1,
           newRecords.storage.first?.value.fields.values.first is NSNull {
            return .init()
        }
        return records.merge(records: newRecords)
    }

    public func removeRecords(matching pattern: CacheKey) throws {
        records.removeRecords(matching: pattern)
    }

    public func clear() {
        records.clear()
    }
}
