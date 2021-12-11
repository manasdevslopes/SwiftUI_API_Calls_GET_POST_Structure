//
//  Result.swift
//  APICalling
//
//  Created by MANAS VIJAYWARGIYA on 09/12/21.
//

import Foundation
import SwiftUI

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
    var artworkUrl100: String
}

struct Response: Codable {
    var results: [Result]
}
