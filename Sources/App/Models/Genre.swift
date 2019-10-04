import FluentSQLite
import Vapor

final class Genre: SQLiteModel {
    var id: Int?
    var name: String
    var films: [Film]?

    init(id: Int? = nil,
         name: String,
         films: [Film]? = nil) {
        self.id = id
        self.name = name
        self.films = films
    }
}

extension Genre: Migration { }

extension Genre: Content { }

extension Genre: Parameter { }


