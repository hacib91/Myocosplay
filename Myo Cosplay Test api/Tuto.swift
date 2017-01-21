//
//  Tuto.swift
//  Myo Cosplay Test api
//
//  Created by haseeb khalid on 16/10/2016.
//  Copyright © 2016 haseeb khalid. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class Tuto : UIViewController,  UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
 
    @IBOutlet weak var imageView: UIImageView!
    //@IBOutlet weak var imageView: UIImageView!

    
    
    var newArray: [String] = []
    var IDArray: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.downloadAndUpdate()
        print("Calling...")
    }
    func downloadAndUpdate() {
        self.newArray.removeAll()
        self.IDArray.removeAll()
        
        Alamofire.request("https://myocosplayeip.herokuapp.com/tuto", method: .get) .responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                print(json)
                for (_, item) in json["Tuto"].arrayValue.enumerated() {
                    let tuto_name = item["titre"].stringValue
                    let ID = item["id"].intValue
                    let image = item["img_pres"].stringValue
                    
                    print("String is \(tuto_name)")
                    print("String is \(image)")
                    self.newArray.append(tuto_name)
                    self.IDArray.append(ID)
                    self.newArray.append(image)
                    
                }
                self.tableView.reloadData()
                
            case .failure(let error):
                let json = JSON(response.data!)
                print(json)
                
                print("Request failed with error: \(error)")
            }
            debugPrint(response.result)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        
        cell.textLabel?.text = self.newArray[(indexPath as NSIndexPath).row]
        //let mainImageView = cell.viewWithTag(2) as! UIImageView
        
       // mainImageView.image = newArray[indexPath.row].mainImage
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("ID is \(self.IDArray[(indexPath as NSIndexPath).row])")
            
           // Alamofire.request("https://myocosplayeip.herokuapp.com/tuto\(self.IDArray[(indexPath as NSIndexPath).row])", method: .delete)
            
            self.downloadAndUpdate()
            // Delete the row from the data source
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


