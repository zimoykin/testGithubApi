//
//  Helper.swift
//  testGithubApi
//
//  Created by Дмитрий on 07.09.2020.
//  Copyright © 2020 DZ. All rights reserved.
//

import Foundation


struct Session: Codable {
    
    var login: String
    var id: Int
    var name: String
    var node_id: String
    var type: String
    
}


struct UserSearch: Codable {
    
    var total_count: Int
    var items: [UserGitHub]
    
}


struct UserGitHub: Codable {
    
    var login: String?
    var type: String
    var id: Int?
    var avatar_url: String
    var name: String?
    var location: String?
    var created_at: String?
    var public_repos: Int?
    
    //https://api.github.com/users/"login"
    
}


struct Repo: Codable {
    
    var name: String
    var updated_at: String
    var stargazers_count: Int
    var language: String?
    
}


struct MessageApi: Codable {
    var message: String
}
