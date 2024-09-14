//
//  StarshipsAPI.swift
//  StarWarsLexicon
//
//  Created by Özgün Yildiz on 12.09.24.
//

import Foundation
import Alamofire

class StarshipApi {
    
    
    func getStarship(url: String, completion: @escaping (Starship?) -> ()) {
        guard let url = URL(string: url) else { return }
        
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion(nil)
                    return
                }

                let jsonDecoder = JSONDecoder()
                
                do {
                    let model = try jsonDecoder.decode(Starship.self, from: data)
                    DispatchQueue.main.async {
                        completion(model)
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

    
}
