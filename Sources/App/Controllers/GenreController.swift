import Vapor

final class GenreController {

    func index(_ req: Request) throws -> Future<[Genre]> {
        return Genre.query(on: req).all()
    }

    func fetch(_ req: Request, genreId: Int) throws -> Future<Genre> {
        return Genre.find(genreId, on: req)
            .map { genre -> Genre in
                guard let genre = genre else {
                    throw Abort(.notFound, reason: "No Genre with id \(genreId)")
                }
                return genre
        }
    }

    func getFilms(_ req: Request, genreId: Int) throws -> Future<[Film]> {
        return try Genre.find(genreId, on: req)
            .flatMap { 
                guard let genre = $0 else {
                    throw Abort(.notFound, reason: "No Genre with id \(genreId)")
                }
                return try genre.films.query(on: req).all()
        }
    }

    func create(_ req: Request) throws -> Future<Genre> {
        return try req.content.decode(Genre.self).flatMap { genre in
            return genre.save(on: req)
        }
    }

    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Genre.self).flatMap { genre in
            return genre.delete(on: req)
        }.transform(to: .ok)
    }
}
