//
//  Autres.swift
//  Myo Cosplay Test api
//
//  Created by haseeb khalid on 26/07/2016.
//  Copyright © 2016 haseeb khalid. All rights reserved.
//

import Foundation
import UIKit

class Autres : UITableViewController {
    var names = [String] ()
    var n = [String] ()
    var id = [String]()

    override func viewDidLoad() {
        names = ["Connexion","Inscription", "Forum", "TEST"]
        n = ["Connexion","Inscription"]
        id = ["A","B", "C", "E"]
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return n.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let cel = tableView.dequeueReusableCell(withIdentifier: "Cel")
        
        cell?.textLabel?.text = names[(indexPath as NSIndexPath).row]
        cel?.textLabel?.text = n[(indexPath as NSIndexPath).row]
        return cell!
        //return cel!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcName = id[(indexPath as NSIndexPath).row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: vcName)
        self.navigationController?.pushViewController(viewController!, animated: true)
        
    }
}
