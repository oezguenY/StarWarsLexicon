//
//  Constants.swift
//  StarWarsLexicon
//
//  Created by Özgün Yildiz on 12.09.24.
//

import UIKit

let BLACK_BG = #colorLiteral(red: 0.9972793932, green: 1, blue: 0.9537276191, alpha: 0.1546882478).cgColor

let URL_BASE = "https://swapi.dev/api/"

let PERSON_URL = URL_BASE + "people/"

typealias HomeworldResponseCompletion = (Homeworld?) -> Void
