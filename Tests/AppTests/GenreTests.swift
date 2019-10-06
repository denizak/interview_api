//
//  GenreTests.swift
//  App
//
//  Created by Deni Zakya on 06/10/19.
//

@testable import App

import Vapor
import FluentSQLite
import XCTest

final class GenreTests: XCTestCase {
    let genreURI = "/genre/"
    var app: Application!
    var conn: SQLiteConnection!

    override func setUp() {
        super.setUp()

        app = try! Application.testable()
        conn = try! app.newConnection(to: .sqlite).wait()
    }

    override func tearDown() {
        super.tearDown()

        conn.close()
    }

    func testAddGenre() throws {
        let genreName = "Thriller"
        let genre = Genre(name: genreName)
        let createdGenreResponse = try app.sendRequest(to: genreURI, method: .POST, body: genre)
        let receivedPostGenre = try createdGenreResponse.content.decode(Genre.self).wait()

        XCTAssertEqual(receivedPostGenre.name, genreName)
        XCTAssertNotNil(receivedPostGenre.id)

        let body: EmptyBody? = nil
        let getGenreResponse = try app.sendRequest(to: genreURI, method: .GET, body: body)
        let receivedGetGenres = try getGenreResponse.content.decode([Genre].self).wait()

        XCTAssertEqual(receivedGetGenres.count, 1)
        XCTAssertEqual(receivedGetGenres[0].name, genreName)
        XCTAssertEqual(receivedGetGenres[0].id, receivedPostGenre.id)
    }

    func testDeleteGenre() throws {
        let genreName = "Thriller"
        let genre = Genre(name: genreName)
        let createdGenreResponse = try app.sendRequest(to: genreURI, method: .POST, body: genre)
        let receivedPostGenre = try createdGenreResponse.content.decode(Genre.self).wait()

        XCTAssertEqual(receivedPostGenre.name, genreName)
        XCTAssertNotNil(receivedPostGenre.id)

        let body: EmptyBody? = nil
        let getGenreResponse = try app.sendRequest(to: genreURI + "1", method: .DELETE, body: body)

        XCTAssertEqual(getGenreResponse.http.status, .ok)
    }

    static let allTests = [
        ("testAddGenre", testAddGenre),
        ("testDeleteGenre", testDeleteGenre)
    ]
}
