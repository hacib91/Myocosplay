//
//  Forum.swift
//  Myo Cosplay Test api
//
//  Created by haseeb khalid on 03/11/2016.
//  Copyright © 2016 haseeb khalid. All rights reserved.
//

import Foundation
import UIKit

class Forum : UIViewController {


 
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        let forumURL = URL(string : "https://myocosplay.eu/forum")
        let forumURLRequest = URLRequest(url: forumURL!)
        webView.loadRequest(forumURLRequest)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func goNext(_ sender: Any) {
        webView.goForward()
    }
    @IBAction func goBack(_ sender: Any) {
        webView.goBack()
    }
}
