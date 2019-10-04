import Vapor

final class FilmController {

    func index(_ req: Request) throws -> Future<[Film]> {
        return Film.query(on: req).all()
    }

    func fetch(_ req: Request, filmId: Int) throws -> Future<Film> {
        return Film.find(filmId, on: req)
            .map { film -> Film in
                guard let film = film else {
                    throw Abort(.notFound, reason: "No film with id \(filmId)")
                }
                return film
        }
    }

    func create(_ req: Request) throws -> Future<Film> {
        return try req.content.decode(Film.self).flatMap { film in
            return film.save(on: req)
        }
    }

    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Film.self).flatMap { film in
            return film.delete(on: req)
        }.transform(to: .ok)
    }
}
