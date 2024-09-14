//
//  StarshipsVC.swift
//  StarWarsLexicon
//
//  Created by Özgün Yildiz on 12.09.24.
//

import UIKit

class StarshipsVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var manufacturerLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var lengthLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var crewLbl: UILabel!
    @IBOutlet weak var passengerLbl: UILabel!
    @IBOutlet weak var previousLbl: UIButton!
    @IBOutlet weak var nextLbl: UIButton!
    
 
    var person: Person!
    var starshipsApi = StarshipApi()
    var starships = [String]()
    var currentStarship = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        starships = person.starships
        nextLbl.isEnabled = starships.count > 1
        previousLbl.isEnabled = false
        guard let firstStarship = starships.first else { return }
        self.getStarship(url: firstStarship)
        
    }
    
    func getStarship(url: String) {
        starshipsApi.getStarship(url: url) { (starship) in
            if let starship = starship {
                self.setUpUI(starship: starship)
            }
        }
    }
    
  
    func setUpUI(starship: Starship) {
        self.nameLbl.text = starship.name
        self.modelLbl.text = starship.model
        self.manufacturerLbl.text = starship.manufacturer
        self.costLbl.text = starship.costInCredits
        self.lengthLbl.text = starship.length
        self.speedLbl.text = starship.maxSpeed
        self.crewLbl.text = starship.crew
        self.passengerLbl.text = starship.passengers

    }
    
    @IBAction func previousBtn(_ sender: Any) {
        currentStarship -= 1
        setButtonState()
    }
    
    
    @IBAction func nextBtn(_ sender: Any) {
        currentStarship += 1
        setButtonState()
    }
    
    
    func setButtonState() {
        
        if currentStarship == 0 {
            previousLbl.isEnabled = false
        } else {
            previousLbl.isEnabled = true
        }
        
        if currentStarship == starships.count - 1 {
            nextLbl.isEnabled = false
        } else {
            nextLbl.isEnabled = true
        }
        
        getStarship(url: starships[currentStarship])
        
    }
    
    
}
