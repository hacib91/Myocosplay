//
//  ViewController.swift
//  Myo Cosplay Test api
//
//  Created by haseeb khalid on 28/06/2016.
//  Copyright © 2016 haseeb khalid. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Persei

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var img: UIImageView!
    
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!

    
    var newArray: [String] = []
    var testArray: [String] = []
    var IDArray: [Int] = []
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageArray = [#imageLiteral(resourceName: "slider1"),#imageLiteral(resourceName: "slider2")]
        
        for i in 0..<imageArray.count {
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.view.frame.width, height: self.scrollView.frame.height)
            
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)
        }

        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.downloadAndUpdate()
        print("Calling...")
    }
    
    func downloadAndUpdate() {
        self.newArray.removeAll()
        self.testArray.removeAll()
        self.IDArray.removeAll()
        
        Alamofire.request("https://myocosplayeip.herokuapp.com/users", method: .get) .responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                print(json)
                for (_, item) in json["Users"].arrayValue.enumerated() {
                    let string = item["login"].stringValue
                    let ID = item["id"].intValue
                    let stringn = item["email"].stringValue
                    
                    print("String is \(string)")
                    
                    self.newArray.append(string)
                    self.IDArray.append(ID)
                    self.testArray.append(stringn)
                    
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
        return cell
    }
    //start
    
    func table(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testArray.count
    }
    
    private func table(_ table: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "Cel", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.testArray[(indexPath as NSIndexPath).row]
        return cell
    }
    //ok
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("ID is \(self.IDArray[(indexPath as NSIndexPath).row])")
            
          //  Alamofire.request("https://rocky-meadow-1164.herokuapp.com/todo/\(self.IDArray[(indexPath as NSIndexPath).row])", method: .delete)
            
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
