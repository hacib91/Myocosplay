//
//  BoutiqueVC.swift
//  Myo Cosplay Test api
//
//  Created by haseeb khalid on 16/01/2017.
//  Copyright © 2017 haseeb khalid. All rights reserved.
//

import Foundation
import UIKit

class BoutiqueVC: UIViewController {
    
    var image = UIImage ()
    var mainSongTitle = String()
    var mainContenu = String()
    
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    
    @IBOutlet weak var songTitle: UILabel!
    
    @IBOutlet weak var tuto: UITextView!
    @IBOutlet weak var tutoContenu: UILabel!
    override func viewDidLoad() {
        
        songTitle.text = mainSongTitle
        tuto.text = mainContenu
        tuto.attributedText = stringFromHtml(string: mainContenu)
        background.image = image
        mainImageView.image = image
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


