//
//  PersonAPI.swift
//  StarWarsLexicon
//
//  Created by Özgün Yildiz on 12.09.24.
//

import Foundation
import Alamofire
import SwiftyJSON


class PersonApi {
    
    func getRandomPersonAlamo(id: Int, completion: @escaping (Person?) -> Void) {
        guard let url = URL(string: "\(PERSON_URL)\(id)") else { return }
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion(nil)
                    return
                }

                let jsonDecoder = JSONDecoder()
                do {
                    let person = try jsonDecoder.decode(Person.self, from: data)
                    DispatchQueue.main.async {
                        completion(person)
                    }
                } catch {
                    debugPrint("Decoding error: \(error.localizedDescription)")
                    completion(nil)
                }
                
            case .failure(let error):
                debugPrint("Request error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }

    func getRandomPersonUrlSession(id: Int, completion: @escaping (Person?) -> Void) {
        guard let url = URL(string: "\(PERSON_URL)\(id)") else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                debugPrint(error!.localizedDescription)
                completion(nil)
                return
            }

            guard let data = data else { return }

            do {
                let jsonAny = try JSONSerialization.jsonObject(with: data, options: [])
                guard let json = jsonAny as? [String:Any] else { return }
                let person = self.parsePersonManual(json: json)
                DispatchQueue.main.async {
                    completion(person)
                }
            } catch {
                debugPrint(error.localizedDescription)
                return
            }
        }
        task.resume()
    }
    
    
    func parsePersonManual(json:[String:Any]) -> Person {
      let name = json["name"] as? String ?? ""
      let height = json["height"] as? String ?? ""
      let mass = json["mass"] as? String ?? ""
      let hair = json["hair_color"] as? String ?? ""
      let birthYear = json["birth_year"] as? String ?? ""
      let gender = json["gender"] as? String ?? ""
      let homeworldUrl = json["homeworld"] as? String ?? ""
      let filmUrls = json["films"] as? [String] ?? [String]()
      let vehicleUrls = json["films"] as? [String] ?? [String]()
      let starshipUrls = json["starships"] as? [String] ?? [String]()


      let person = Person(name: name, gender: gender, birthYear: birthYear, mass: mass, height: height, hair: hair, homeWorld: homeworldUrl, films: filmUrls, vehicles: vehicleUrls, starships: starshipUrls)
      return person

  }

    private func parsePersonSwifty(json: JSON) -> Person {
        let name = json["name"].stringValue
        let height = json["height"].stringValue
        let mass = json["mass"].stringValue
        let hair = json["hair_color"].stringValue
        let birthYear = json["birth_year"].stringValue
        let gender = json["gender"].stringValue
        let homeworldUrl = json["homeworld"].stringValue
        let filmUrls = json["films"].arrayValue.map ({ $0.stringValue })
        let vehicleUrls = json["films"].arrayValue.map ({ $0.stringValue })
        let starshipUrls = json["starships"].arrayValue.map ({ $0.stringValue })


        let person = Person(name: name, gender: gender, birthYear: birthYear, mass: mass, height: height, hair: hair, homeWorld: homeworldUrl, films: filmUrls, vehicles: vehicleUrls, starships: starshipUrls)
        return person
}
}

