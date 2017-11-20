//
//  RiotGameClasses.swift
//  APIRiotGame-LeagueOfLegends
//
//  Created by Alain on 17-11-20.
//  Copyright © 2017 Alain. All rights reserved.
//

import Foundation

struct Champion:Codable {
    var name:String
    var id:Int
    var image: Image?
}

struct Image:Codable{
    var full:String
    var sprite:String
}

