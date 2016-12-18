//
//  VideoVC.swift
//  Myo Cosplay Test api
//
//  Created by haseeb khalid on 07/12/2016.
//  Copyright © 2016 haseeb khalid. All rights reserved.
//

import Foundation
import UIKit

class VideoVC: UIViewController {
    
    var image = UIImage ()
    var mainSongTitle = String()
    var mainContenu = String()
    let youtubeURL = "https://www.youtube.com/embed/Rg6GLVUnnpM"
    
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var tuto: UITextView!
    @IBOutlet weak var tutoContenu: UILabel!
    @IBOutlet weak var videoView: UIWebView!
    
    override func viewDidLoad() {
        
        songTitle.text = mainSongTitle
        tuto.text = mainContenu
        tuto.attributedText = stringFromHtml(string: mainContenu)
        background.image = image
        mainImageView.image = image
        videoView.allowsInlineMediaPlayback = true
        videoView.loadHTMLString("<iframe width=\"\(videoView.frame.width)\" height=\"\(videoView.frame.height)\" src=\"\(mainContenu)/?&playsinline=1\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
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

