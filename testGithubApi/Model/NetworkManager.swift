//
//  NetworkManager.swift
//  testGithubApi
//
//  Created by Дмитрий on 07.09.2020.
//  Copyright © 2020 DZ. All rights reserved.
//

import Foundation

struct NetworkManager {
    
    static var apiAddress = "https://api.github.com/"
   
    static func checkAccessGitHub (_ login: String, _ password: String, _ closure: @escaping (Bool) -> Void) {
        
        let url = URL(string: apiAddress + "authorizations")!
        var request = URLRequest(url: url)
        
        addAuthInURLRequest(req: &request, login: login, password: password)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print(error!)
                closure(false)
            }
            
            if let data = data {
                
                let session = try? JSONDecoder().decode(Session.self, from: data)
                
                if session != nil {
                    
                    UserDefaults.standard.set (session!.login, forKey: "login")
                    UserDefaults.standard.set (password, forKey: "password")
                    
                    closure(true)
                    
                } else {
                    closure(false)
                }
            }
        
        }.resume()
        
    }
    
    static func addAuthInURLRequest (req: inout URLRequest, login: String, password: String) -> Void {
        
        let userPasswordData = "\(login):\(password)".data(using: .utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString()
        let authString = "Basic \(base64EncodedCredential)"
        
        req.addValue(authString, forHTTPHeaderField: "Authorization")
        
    }
    
    static func searchInfoFromServer (key: String, _ count: Int, _ part:Int = 15, _ closure: @escaping (Int, UserSearch?) -> Void) {
        
        guard let url = URL(string: apiAddress + "search/users?q=\(key)&page=\(count)&per_page=\(part)") else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard data != nil else  {
                return
            }
            
            let searched = try? JSONDecoder().decode(UserSearch.self, from: data!)
            
            if searched != nil {
                closure(searched!.total_count, searched)
                print (searched!.total_count)
            }
            
        }.resume()
        
        
    }
    
    static func getfullInfoAccountGitHub (_ login: String, _ closure: @escaping (UserGitHub?) -> Void) {
        
        let url = URL(string: apiAddress + "users/\(login)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard data != nil else  {
                return
            }
            
            let userGithub = try? JSONDecoder().decode(UserGitHub.self, from: data!)
            
            if userGithub != nil {
                closure(userGithub!)
            }
            else {
                
                print ("error here!")
                let mesApi = try? JSONDecoder().decode(MessageApi.self, from: data!)
                if mesApi != nil {
                    print (mesApi!.message)
                }
                closure(nil)
            }
            
        }.resume()
        
    }
    
    static func getUserRepo (_ login: String, page: Int, _ closure: @escaping ([Repo]) -> Void) {
        
        let url = URL(string: apiAddress + "users/\(login)/repos?page=\(page)&per_page=15")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard data != nil else  {
                return
            }
            
            let userGithub = try? JSONDecoder().decode([Repo].self, from: data!)
            
            if userGithub != nil {
                closure(userGithub!)
            } else {
                
                print ("error here!")
                let mesApi = try? JSONDecoder().decode(MessageApi.self, from: data!)
                if mesApi != nil {
                    print (mesApi!.message)
                }
            }
            
        }.resume()
        
        
    }


}
