import XCTest
@testable import AppTests

XCTMain([
  testCase(GenreTests.allTests),
  testCase(FilmTests.allTests),
])