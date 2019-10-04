import FluentSQLite
import Vapor

final class Film: SQLiteModel {
    var id: Int?
    var title: String

    init(id: Int? = nil, title: String) {
        self.id = id
        self.title = title
    }
}

extension Film: Migration { }

extension Film: Content { }

extension Film: Parameter { }
