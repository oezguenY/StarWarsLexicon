//
//  VehiclesAPI.swift
//  StarWarsLexicon
//
//  Created by Özgün Yildiz on 12.09.24.
//

import Foundation
import Alamofire

class VehiclesApi {
    
    func getVehicle(url: String, completion: @escaping (Vehicle?) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion(nil)
                    return
                }

                let jsonDecoder = JSONDecoder()
                do {
                    let vehicle = try jsonDecoder.decode(Vehicle.self, from: data)
                    DispatchQueue.main.async {
                        completion(vehicle)
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

