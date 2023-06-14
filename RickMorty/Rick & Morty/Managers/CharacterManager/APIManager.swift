//
//  ApiManager.swift
//  Rick & Morty
//
//  Created by Admin on 06.06.2023.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    let urlStringToCharacter = "https://rickandmortyapi.com/api/character"
    let urlStringToEpisods = "https://rickandmortyapi.com/api/episode"
    let urlStringToLocation = "https://rickandmortyapi.com/api/location"
    
    func getDataCharacter(completion: @escaping ([Result]) -> Void) {
        let url = URL(string: urlStringToCharacter)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data,response,error in
            guard let data else {
                return
            }
            if let ourData = try? JSONDecoder().decode(CharacterData.self, from: data) {
                completion(ourData.results)
            }
            else {
                print("Fail")
            }
           
        }
        task.resume()
    }
    
    func getDataEpisode(completion: @escaping ([ResultEp]) -> Void) {
        let url = URL(string: urlStringToEpisods)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data,response,error in
            guard let data else {
                return
            }
            if let ourData = try? JSONDecoder().decode(EpisodeModel.self, from: data) {
                completion(ourData.results)
            }
            else {
                print("Fail")
            }
           
        }
        task.resume()
    }
    func getDataLocation(completion: @escaping ([ResultLocation]) -> Void) {
        let url = URL(string: urlStringToLocation)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data,response,error in
            guard let data else {
                return
            }
            if let ourData = try? JSONDecoder().decode(LocationModel.self, from: data) {
                completion(ourData.results)
            }
            else {
                print("Fail")
            }
           
        }
        task.resume()
    }
    
    
    
}
