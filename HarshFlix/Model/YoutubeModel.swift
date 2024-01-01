//
//  YoutubeSearch.swift
//  Harshflix
//
//  Created by My Mac Mini on 20/12/23.
//

import Foundation

struct YoutubeModel: Codable {
    let items: [YoutubeVideo]
}


struct YoutubeVideo: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
 

