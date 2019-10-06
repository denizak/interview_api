import FluentSQLite
import Vapor

final class Film: SQLiteModel {
    var id: Int?
    var title: String
    var playableUrl: String
    var imageUrl: String
    var genreId: Int

    init(id: Int? = nil,
         title: String,
         playableUrl: String,
         imageUrl: String,
         genreId: Int) {
        self.id = id
        self.title = title
        self.playableUrl = playableUrl
        self.imageUrl = imageUrl
        self.genreId = genreId
    }
}

extension Film: Migration { }

extension Film: Content { }

extension Film: Parameter { }
