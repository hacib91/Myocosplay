//
//  Images.swift
//  Myo Cosplay Test api
//
//  Created by haseeb khalid on 12/11/2016.
//  Copyright © 2016 haseeb khalid. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

struct post {
   // let urlImage : URL!
    let mainImage : UIImage!
    let name : String!
    let id : String!
    let contenu : String
}

    extension String {
        
        func html2AttributedString(font: UIFont?) ->  NSAttributedString? {
            guard
                let data = data(using: String.Encoding.utf8)
                else { return nil }
            do {
                return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:String.Encoding.utf8], documentAttributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
                return  nil
            }
        }
        var html2String: String {
            return html2AttributedString(font: nil)?.string ?? ""
        }
    }
class Images: UITableViewController {
    
    var posts = [post]()
    var searchURL = "https://myocosplayeip.herokuapp.com/tuto"
    
    typealias JSONSTandard = [String : AnyObject]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        callAlamo(url: searchURL)
    }
    
    func callAlamo(url : String) {
        Alamofire.request(url).responseJSON(completionHandler: {
            reponse in
            self.parseData(JSONData: reponse.data!)
        })
    }
    
    func parseData(JSONData: Data)
    {
        do {
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONSTandard
            if let tutos = readableJSON["Tuto"] as? [JSONSTandard]{
                for i in 0..<tutos.count{
                    let tuto = tutos[i]
                   
                print(tuto)
                    let name = tuto["titre"] as! String
                    let id = tuto["titre_manga"] as! String
                    let contenu = tuto["contenu"] as! String
                    
                    if let images = readableJSON["Tuto"] as? [JSONSTandard]{
                    let imageData = images[i]
                    let mainImageURL = URL(string: "https://myocosplay.eu" + (imageData["img_pres"] as! String))
                        let mainImageData = NSData(contentsOf: mainImageURL!)
                        let mainImage = UIImage(data: mainImageData as! Data)
                    //posts.append(post.init(urlImage: mainImageURL, name: name, id: id, contenu: contenu))
                        posts.append(post.init(mainImage: mainImage, name: name, id: id, contenu: contenu))

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
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        
        let vc = segue.destination as! AudioVC
        
       vc.image = posts[indexPath!].mainImage
        vc.mainSongTitle = posts[indexPath!].name
        vc.mainContenu = posts[indexPath!].contenu
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


