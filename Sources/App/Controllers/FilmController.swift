import Vapor

final class FilmController {
    
    func index(_ req: Request) throws -> Future<[Film]> {
        return Film.query(on: req).all()
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
