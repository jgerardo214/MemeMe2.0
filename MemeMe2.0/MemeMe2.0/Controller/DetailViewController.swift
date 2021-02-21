//
//  DetailViewController.swift
//  MemeMe2.0
//
//  Created by Jonathan Gerardo on 2/16/21.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = meme.memedImage
        
    }
    
    

    
    
    
    
}
