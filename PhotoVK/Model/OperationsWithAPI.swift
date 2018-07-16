//
//  OperationsWithAPI.swift
//  PhotoVK
//
//  Created by Konstantin Mishukov on 10/06/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import Foundation

struct API {
    
    static let authURL = "https://oauth.vk.com/authorize?client_id=\(API.client_id)&display=page&redirect_uri=\(API.redirect_uri)/callback&scope=friends&response_type=token&v=\(version)&state=123456"
    
    static let client_id = "6497203"
    static let version = "5.78"
    static let redirect_uri = "https://oauth.vk.com/blank.html"

    
    mutating func getFriendsList(authorization: Authorization, completion: @escaping (GetFriendsObject?) -> Void ) {
        let methodURL = "https://api.vk.com/method/friends.get?user_id=\(authorization.user_id)&order=name&count=200&offset=1&fields=photo_100,bdate&name_case=nom&access_token=\(authorization.access_token)&v=\(API.version)"

        guard let url = URL(string: methodURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, responseData, error) in
            
            guard let recievedData = data else {
                print("Error: Did not recieve data.")
                return
            }
            guard error == nil else {
                print("URLSession Error.")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let newData =  try decoder.decode(GetFriendsObject.self, from: recievedData)
                completion(newData)
            } catch {
                print("Error trying to decode JSON")
                print(error)
                completion(nil)
            }
            
        }
        task.resume()
    }
    
    mutating func getPhotos(authorization: Authorization, profile_id: Int, completion: @escaping (GetProfilePhotosObject?) -> Void ) {
        let methodURL = "https://api.vk.com/method/photos.get?owner_id=\(profile_id)&album_id=profile&sizes=1&rev=1&extended=1&feed_type=photo&count=200&offset=1&access_token=\(authorization.access_token)&v=\(API.version)"

        guard let url = URL(string: methodURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, responseData, error) in
            
            guard let recievedData = data else {
                print("Error: Did not recieve data.")
                return
            }
            guard error == nil else {
                print("URLSession Error.")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let newData =  try decoder.decode(GetProfilePhotosObject.self, from: recievedData)
                completion(newData)
            } catch {
                print("Error trying to decode JSON")
                print(error)
                completion(nil)
            }
        }
        task.resume()
    }
}

