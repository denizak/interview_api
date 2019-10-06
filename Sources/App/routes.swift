import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    router.get { req in
        return "It works!"
    }

    filmRoute(router)
    genreRoute(router)
}

private func genreRoute(_ router: Router) {
    let genreController = GenreController()

    router.get("genre", use: genreController.index)
    router.get("filmsWithGenreId", Int.parameter) { req -> Future<[Film]> in
        let genreId = try req.parameters.next(Int.self)
        return try genreController.getFilms(req, genreId: genreId)
    }
    router.get("genre", Int.parameter) { req -> Future<Genre> in
        let genreId = try req.parameters.next(Int.self)
        return try genreController.fetch(req, genreId: genreId)
    }

    router.post("genre", use: genreController.create)
    router.delete("genre", Genre.parameter, use: genreController.delete)
}

private func filmRoute(_ router: Router) {
    let filmController = FilmController()
    router.get("films", use: filmController.index)
    router.get("film", Int.parameter) { req -> Future<Film> in
        let filmId = try req.parameters.next(Int.self)
        return try filmController.fetch(req, filmId: filmId)
    }

    router.post("films", use: filmController.create)
    router.delete("films", Film.parameter, use: filmController.delete)
}
