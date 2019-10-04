import FluentSQLite
import Vapor

final class Film: SQLiteModel {
    var id: Int?
    var title: String
    var playableUrl: String
    var imageUrl: String
    var genre: Genre?

    init(id: Int? = nil,
         title: String,
         playableUrl: String,
         imageUrl: String,
         genre: Genre? = nil) {
        self.id = id
        self.title = title
        self.playableUrl = playableUrl
        self.imageUrl = imageUrl
        self.genre = genre
    }
}

extension Film: Migration { }

extension Film: Content { }

extension Film: Parameter { }
