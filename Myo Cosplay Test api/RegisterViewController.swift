//
//  RegisterViewController.swift
//  UserLogin
//
//  Created by haseeb khalid on 08/01/2017.
//  Copyright © 2017 haseeb khalid. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var userLogin: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPass: UITextField!
    @IBOutlet weak var userPass2: UITextField!
    let date = NSDate()
    let dateFormatter = DateFormatter()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @discardableResult func doSomething() -> Bool {
        return true
    }
    @IBAction func button(_ sender: UIButton) {
      
        dateFormatter.dateFormat = "yyy-MM-dd"
        let convertedDate = dateFormatter.string(from: date as Date)
        
        let uEmail = userEmail.text
        let uPass = userPass.text
        let uRepeatPass = userPass2.text
        let uLogin = userLogin.text
        
        //empty
        
        if ((uEmail?.isEmpty)! || (uPass?.isEmpty)! || (uRepeatPass?.isEmpty)! || (uLogin?.isEmpty)!)
        {
        // display aler message
            displayAlertMessage(userMessage: "All fields are required");
            return;
        }
        if(uPass != uRepeatPass)
        {
            // display aler message
            displayAlertMessage(userMessage: "password not match");
            return;
        }
      
        let myParam: Parameters = [
            "username": uLogin!,
            "password": uPass!,
            "email": uEmail!,
            "nom": "macbook",
            "prenom":"apple",
            "device":"iPhone",
            "telephone": "06-53-21-12-00",
            "date": convertedDate
            
            
        ]
        Alamofire.request("https://myocosplayeip.herokuapp.com/signup",method: .post, parameters: myParam, encoding: JSONEncoding.prettyPrinted)
        
        //UserDefaults.standard.setValue(uEmail, forKey: "uEmail")
        //UserDefaults.standard.setValue(uPass, forKey: "uPass")
        //UserDefaults.standard.synchronize()
        
         let myAlert = UIAlertController(title: "Alert", message: "Reg ok", preferredStyle:.alert);
        let okAction = UIAlertAction(title: "string", style: .default) {
            action in
            self.dismiss(animated: true, completion: nil)
        }
        myAlert.addAction(okAction)
        present(myAlert, animated:true, completion:nil);
    }
    
    func displayAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title: "Attention", message: userMessage, preferredStyle:UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title: "fermer", style: UIAlertActionStyle.default, handler: nil)
        
        myAlert.addAction(okAction);
        
        present(myAlert, animated:true, completion:nil);
        
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
