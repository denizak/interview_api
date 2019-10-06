import FluentSQLite
import Vapor

final class Genre: SQLiteModel {
    var id: Int?
    var name: String

    init(id: Int? = nil,
         name: String) {
        self.id = id
        self.name = name
    }
}

extension Genre {
    var films: Children<Genre, Film> { 
        return children(\.genreId)
    }
}

extension Genre: Migration { }

extension Genre: Content { }

extension Genre: Parameter { }


