import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    router.get { req in
        return "It works!"
    }

    filmRoute(router)
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
