//
//  FilmTests.swift
//  App
//
//  Created by Deni Zakya on 06/10/19.
//

@testable import App

import Vapor
import FluentSQLite
import XCTest

final class FilmTests: XCTestCase {
    let filmURI = "/films/"
    var app: Application!
    var conn: SQLiteConnection!

    override func setUp() {
        super.setUp()

        app = try! Application.testable()
        conn = try! app.newConnection(to: .sqlite).wait()

        try! populateGenre()
    }

    private func populateGenre() throws {
        let genreURI = "/genre/"
        let genreName = "Thriller"
        let genre = Genre(name: genreName)
        let createdGenreResponse = try app.sendRequest(to: genreURI, method: .POST, body: genre)
        _ = try createdGenreResponse.content.decode(Genre.self).wait()
    }

    override func tearDown() {
        super.tearDown()

        conn.close()
    }

    func testAddFilm() throws {
        let receivedPostFilm = try createFilm()

        let body: EmptyBody? = nil
        let getFilmResponse = try app.sendRequest(to: filmURI, method: .GET, body: body)
        let receivedGetFilms = try getFilmResponse.content.decode([Film].self).wait()

        XCTAssertEqual(receivedGetFilms.count, 1)
        XCTAssertEqual(receivedGetFilms[0].title, "Rambo")
        XCTAssertEqual(receivedGetFilms[0].id, receivedPostFilm.id)
    }

    func testDeleteFilm() throws {
        _ = try createFilm()

        let body: EmptyBody? = nil
        let getFilmResponse = try app.sendRequest(to: filmURI + "1", method: .DELETE, body: body)

        XCTAssertEqual(getFilmResponse.http.status, .ok)
    }

    private func createFilm() throws -> Film {
        let film = Film(title: "Rambo",
                        playableUrl: "https://bitmovin-a.akamaihd.net/content/playhouse-vr/m3u8s/105560.m3u8",
                        imageUrl: "http://lorempixel.com/g/400/200/fashion/",
                        genreId: 1)
        let createdFilmResponse = try app.sendRequest(to: filmURI, method: .POST, body: film)
        return try createdFilmResponse.content.decode(Film.self).wait()
    }

    static let allTests = [
        ("testAddFilm", testAddFilm),
        ("testDeleteFilm", testDeleteFilm)
    ]
}
