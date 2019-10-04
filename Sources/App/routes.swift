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
    router.post("films", use: filmController.create)
    router.delete("films", Film.parameter, use: filmController.delete)
}
