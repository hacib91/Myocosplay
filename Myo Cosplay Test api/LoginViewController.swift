//
//  LoginViewController.swift
//  UserLogin
//
//  Created by haseeb khalid on 11/01/2017.
//  Copyright © 2017 haseeb khalid. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPass: UITextField!
    typealias JSONSTandard = [String : AnyObject]
    

    @IBAction func button(_ sender: UIButton) {
        let uEmail = userEmail.text
        let uPass = userPass.text
        
        //let userEmailStored = UserDefaults.standard.string(forKey: "uEmail")
        //let userPasswordStored = UserDefaults.standard.string(forKey: "uPass")

        if ((uPass?.isEmpty)! || (uEmail?.isEmpty)!) { return;}

        callAlamo(uEmail: uEmail!, uPass: uPass!)

            //login
            //UserDefaults.standard.set(true, forKey:"isUserLoggedIN")
             //UserDefaults.standard.synchronize()
            
            //self.dismiss(animated: true, completion: nil)
    }
    func callAlamo(uEmail: String, uPass: String) {
        let myParam: Parameters = [
            "username": uEmail,
            "password": uPass
            
        ]
       
        Alamofire.request("https://myocosplayeip.herokuapp.com/login", method: .post, parameters: myParam).responseJSON(completionHandler: {
            reponse in
            self.parseData(JSONData: reponse.data!)
        })
    }
    func parseData(JSONData: Data)
    {
        do {
            // self.posts.removeAll()
            var readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONSTandard
            if let tutos = readableJSON["Users"] as? [JSONSTandard]{
                for i in 0..<tutos.count{
                    let tuto = tutos[i]
                    UserDefaults.standard.set(true, forKey:"isUserLoggedIN")
                    UserDefaults.standard.synchronize()
                    
                    self.dismiss(animated: true, completion: nil)
                    print(tuto)
                    //let name = tuto["nom"] as! String
                    //let id = tuto["login"] as! String
                    //let contenu = tuto["email"] as! String
                    //posts.append(postProfile.init( name: name, id: id, contenu: contenu))
                    
                    //self.tableView.reloadData()
                    
                }
            }
            // print(readableJSON)
        }
        catch {
            print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
