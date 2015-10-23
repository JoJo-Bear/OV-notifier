//
//  DetailsViewController.swift
//  Practicum 3
//
//  Created by Joey Geraeds on 01-10-15.
//  Copyright © 2015. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var selectedTrein: treininfo?
    
    @IBOutlet weak var Eindbestemming: UILabel!
    
    
    @IBOutlet weak var route: UILabel!
    
    @IBOutlet weak var Spoor: UILabel!
    
    @IBOutlet weak var trein: UILabel!
    
    @IBOutlet weak var vertraging: UILabel!
    
    @IBOutlet weak var vertrektijd: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Eindbestemming.text = self.selectedTrein?.bestemming
        self.Spoor.text = self.selectedTrein?.spoor
        self.trein.text = self.selectedTrein?.trein
        self.vertraging.text = self.selectedTrein?.vertraging
        self.vertrektijd.text = self.selectedTrein?.vertrektijd
        self.route.text = self.selectedTrein?.route
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
