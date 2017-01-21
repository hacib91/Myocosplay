//
//  AddViewController.swift
//  Myo Cosplay Test api
//
//  Created by haseeb khalid on 08/07/2016.
//  Copyright © 2016 haseeb khalid. All rights reserved.
//

import UIKit
import Alamofire

class AddViewController: UIViewController {
    
    @IBOutlet weak var mdp: UITextField!
    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var nom: UITextField!
    @IBOutlet weak var prenom: UITextField!
    @IBOutlet weak var device: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var tel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButton(_ sender: AnyObject) {
        
        let myParam: Parameters = [
            "login": self.textView.text!,
            "mdp": self.mdp.text!,
            "device": self.device.text!,
            "email": self.email.text!,
            "tel": self.tel.text!,
            "nom": self.nom.text!,
            "prenom": self.prenom.text!
            
        ]
        Alamofire.request("https://myocosplayeip.herokuapp.com/users",method: .post, parameters: myParam, encoding: JSONEncoding.prettyPrinted)
        
       // Alamofire.request("https://myocosplayeip.herokuapp.com/users",method: .post, parameters: ["login": self.textView.text!,"mdp": self.mdp.text!, "device": self.device.text!, "email": self.email.text!, "tel": self.tel.text!, "nom": self.nom.text!, "prenom": self.prenom.text!])
        
        self.navigationController!.popViewController(animated: true)
        
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

