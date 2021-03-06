//
//  Location.swift
//  Myo Cosplay Test api
//
//  Created by haseeb khalid on 16/01/2017.
//  Copyright © 2017 haseeb khalid. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

struct postLocation {
    // let urlImage : URL!
    let mainImage : UIImage!
    let name : String!
    let id : String!
    let contenu : String
}

class Location : UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var posts = [postLocation]()
    var searchURL = "https://myocosplayeip.herokuapp.com/location"
    var searchNewURL = String()
    
    typealias JSONSTandard = [String : AnyObject]
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keywords = searchBar.text
        
        let finalKeywords = keywords?.replacingOccurrences(of: " ", with: "%20")
        
        
        searchNewURL = "https://myocosplayeip.herokuapp.com/location/titre/\(finalKeywords!)/"
        callAlamo(url: searchNewURL)
        self.view.endEditing(true)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        callAlamo(url: searchURL)
    }
    
    func callAlamo(url : String) {
        Alamofire.request(url).responseJSON(completionHandler: {
            reponse in
            self.parseData(JSONData: reponse.data!)
            self.tableView.reloadData()
        })
    }
    
    func parseData(JSONData: Data)
    {
        do {
            self.posts.removeAll()
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONSTandard
            if let tutos = readableJSON["Location"] as? [JSONSTandard]{
                for i in 0..<tutos.count{
                    let tuto = tutos[i]
                    
                    print(tuto)
                    let name = tuto["titre"] as! String
                    let id = tuto["titre_manga"] as! String
                    let contenu = tuto["description"] as! String
                    
                    if let images = readableJSON["Location"] as? [JSONSTandard]{
                        let imageData = images[i]
                        let mainImageURL = URL(string: "https://myocosplay.eu" + (imageData["image"] as! String))
                        let mainImageData = NSData(contentsOf: mainImageURL!)
                        let mainImage = UIImage(data: mainImageData as! Data)
                        
                        posts.append(postLocation.init(mainImage: mainImage, name: name, id: id, contenu: contenu))
                        
                        self.tableView.reloadData()
                    }
                }
            }
            // print(readableJSON)
        }
        catch {
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let mainImageView = cell?.viewWithTag(2) as! UIImageView
        
        mainImageView.image = posts[indexPath.row].mainImage
        //mainImageView.kf.setImage(with: posts[indexPath.row].urlImage)
        
        let mainLabel = cell?.viewWithTag(1) as! UILabel
        
        mainLabel.text = posts[indexPath.row].name
        
        let SndLabel = cell?.viewWithTag(3) as! UILabel
        
        SndLabel.text = posts[indexPath.row].id
        
        let ConLabel = cell?.viewWithTag(4) as! UILabel
        ConLabel.text = posts[indexPath.row].contenu
        ConLabel.attributedText = stringFromHtml(string: ConLabel.text!)
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        
        let vc = segue.destination as! LocationVC
        
        vc.image = posts[indexPath!].mainImage
        vc.mainSongTitle = posts[indexPath!].name
        vc.mainContenu = posts[indexPath!].contenu
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            if let d = data {
                let str = try NSAttributedString(data: d,
                                                 options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                                 documentAttributes: nil)
                return str
            }
        } catch {
        }
        return nil
    }
    
}




