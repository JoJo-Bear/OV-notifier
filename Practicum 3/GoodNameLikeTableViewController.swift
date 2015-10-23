//
//  GoodNameLikeTableViewController.swift
//  Practicum 3
//
//  Created by Joey Geraeds on 01-10-15.
//  Copyright © 2015. All rights reserved.
//

import UIKit
import Alamofire
import SWXMLHash


class GoodNameLikeTableViewController: UITableViewController {
    
    
    @IBOutlet weak var textveld: UITextField!
    @IBOutlet var ovTableView: UITableView!
    
    @IBAction func textchange(sender: AnyObject) {
        
        treinen = []
        loadXMLData()
        
    }

    
    var treinen = [treininfo]()
    
    func loadXMLData()
    {
        
        
        let user = "joeygeraeds@msn.com"
        let password = "VeZuTWdrv0ma9Ygx16yJS1VjUP-_uPfHIPR6NWHJcmFOf7fFCUEZTw"
        
        let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        var link = textveld.text!.stringByReplacingOccurrencesOfString(" ", withString: "")
        print(link)
        
        Alamofire.request(.GET, "http://webservices.ns.nl/ns-api-avt?station=\(link)", headers: headers).response { (request, response, data, error) in
                print(data) // if you want to check XML data in debug window.
                var xml = SWXMLHash.parse(data!)
            
            var vertraagd: String
            var spoor: String
            var route: String
            
            for elem in xml["ActueleVertrekTijden"]["VertrekkendeTrein"]{
                if elem["VertrekVertragingTekst"].element?.text == nil{
                    vertraagd = "0"
                }
                else{
                    vertraagd = elem["VertrekVertragingTekst"].element!.text!
                
                }
                if elem["VertrekSpoor"].element?.text == nil{
                    spoor = "Geen"
                }
                else{
                    spoor = elem["VertrekSpoor"].element!.text!
                }
                if elem["RouteTekst"].element?.text == nil{
                    route = "Geen stop"
                }
                else{
                    route = elem["RouteTekst"].element!.text!
                }
                var timestring = elem["VertrekTijd"].element!.text!
                var timesplit = timestring.componentsSeparatedByString("T")
                var time = timesplit[1].componentsSeparatedByString("+")
                var tijd = time[0]
                
                var newTrein = treininfo(
                    spoor: spoor,
                    vertrektijd: tijd,
                    bestemming: elem["EindBestemming"].element!.text!,
                    vertraging: vertraagd,
                    trein: elem["TreinSoort"].element!.text!,
                    route: route
                )
                self.treinen.append(newTrein);
                print(elem)
                
            }
            
            self.tableView.reloadData()
        }
    
        
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadXMLData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return treinen.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        as UITableViewCell
        let currentRow = indexPath.row
        let currentTrein = self.treinen[currentRow]

        // Configure the cell...
        cell.textLabel?.text = "\(currentTrein.bestemming) Vertrek: \(currentTrein.vertrektijd)"
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let selectedRow = self.tableView.indexPathForSelectedRow!
        let selectedTrein = self.treinen[selectedRow.row]
        
        let controller = segue.destinationViewController as! DetailsViewController
        controller.selectedTrein = selectedTrein
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
