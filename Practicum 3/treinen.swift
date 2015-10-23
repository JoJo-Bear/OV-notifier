//
//  pirate.swift
//  Practicum 3
//
//  Created by Joey Geraeds on 01-10-15.
//  Copyright © 2015. All rights reserved.
//

import Foundation

class treininfo{

    var spoor: String
    var vertrektijd: String
    var bestemming: String
    var vertraging: String
    var trein: String
    var route: String
    
    init(spoor: String, vertrektijd: String, bestemming: String, vertraging: String, trein: String, route: String){
    
        self.trein = trein
        self.spoor = spoor
        self.vertrektijd = vertrektijd
        self.bestemming = bestemming
        self.vertraging = vertraging
        self.route = route
        
    }
    

    
    
}