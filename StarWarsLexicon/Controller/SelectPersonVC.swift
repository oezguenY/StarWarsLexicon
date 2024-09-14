//
//  SelectPersonVC.swift
//  StarWarsLexicon
//
//  Created by Özgün Yildiz on 12.09.24.
//

import UIKit

class SelectPersonVC: UIViewController {

    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var massLbl: UILabel!
    @IBOutlet weak var hairLbl: UILabel!
    @IBOutlet weak var birthYear: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var homeworldButton: UIButton!
    @IBOutlet weak var vehiclesButton: UIButton!
    @IBOutlet weak var starshipsButton: UIButton!
    @IBOutlet weak var filmsButton: UIButton!
    
    var personApi = PersonApi()
    var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func randomClicked(_ sender: Any) {
        
        let random = Int.random(in: 1...87)
            self.personApi.getRandomPersonAlamo(id: random) { person in
                    if let person = person {
                        self.setUpView(person: person)
                        self.person = person
                    }
        }
       
    }
    
    
    func setUpView(person: Person) {
        nameLbl.text = person.name
        heightLbl.text = person.height
        massLbl.text = person.mass
        hairLbl.text = person.hair
        birthYear.text = person.birthYear
        genderLbl.text = person.gender
        
        homeworldButton.isEnabled = !person.homeWorld.isEmpty
        starshipsButton.isEnabled = !person.starships.isEmpty
        vehiclesButton.isEnabled = !person.vehicles.isEmpty
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toHomeworld" {
            if let destination = segue.destination as? HomeworldVC {
                destination.person = person
            }
        } else if segue.identifier == "toVehicles" {
            if let destination = segue.destination as? VehiclesVC {
                destination.person = person
            }
            
        } else if segue.identifier == "toStarships" {
            if let destination = segue.destination as? StarshipsVC {
                destination.person = person
            }
        }
    }
    
    
    }
