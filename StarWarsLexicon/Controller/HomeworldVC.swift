//
//  HomeworldVC.swift
//  StarWarsLexicon
//
//  Created by Özgün Yildiz on 12.09.24.
//

import UIKit

class HomeworldVC: UIViewController {
    
    var person: Person!
    let api = HomeworldApi()
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var climateLbl: UILabel!
    @IBOutlet weak var terrainLbl: UILabel!
    @IBOutlet weak var populationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.getHomeworld(url: person.homeWorld) { (homeworld) in
            if let homeworld = homeworld {
                self.setUpUI(homeworld: homeworld)
            }
        }
    }
    
    func setUpUI(homeworld: Homeworld) {
        nameLbl.text = homeworld.name
        climateLbl.text = homeworld.climate
        terrainLbl.text = homeworld.terrain
        populationLbl.text = homeworld.population
    }
    


}
