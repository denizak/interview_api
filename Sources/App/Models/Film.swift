import FluentSQLite
import Vapor

final class Film: SQLiteModel {
    var id: Int?
    var title: String
    var playableUrl: String
    var imageUrl: String

    init(id: Int? = nil,
         title: String,
         playableUrl: String,
         imageUrl: String) {
        self.id = id
        self.title = title
        self.playableUrl = playableUrl
        self.imageUrl = imageUrl
    }
}

extension Film: Migration { }

extension Film: Content { }

extension Film: Parameter { }
