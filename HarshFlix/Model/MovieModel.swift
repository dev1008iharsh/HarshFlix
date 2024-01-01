//
//  Movies.swift
//  Harshflix
//
//  Created by My Mac Mini on 20/12/23.
//

import Foundation

struct TitleShowResponcse : Codable{
    let results : [MovieModel]
}

struct MovieModel : Codable {
    var id : Int
    let media_type : String?
    var original_name : String?
    var original_title : String?

    let release_date : String?
    let vote_average : Double
}

 
