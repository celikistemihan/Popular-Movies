//
//  Movie.swift
//  MovieDBCollectionView
//
//  Created by İstemihan Çelik on 3.05.2021.
//

import Foundation

struct Movie: Codable {
    var title: String
    var release_date: String
    var poster_path: String
    var overview: String
    var backdrop_path: String
    var vote_average: Double
}
