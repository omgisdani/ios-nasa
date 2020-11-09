//
//  SingleController.swift
//  nasa
//
//  Created by dani v on 06/11/20.
//

import UIKit
import Alamofire
import Kingfisher

class SingleController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    var date: String = ""
    var newDate: String = ""
    var desc: String = ""
    var name: String = ""
    var img: String = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
        self.titleLabel.text = name
        self.descLabel.text = desc
        var imgURL: URL = URL(string: img)!
       self.imageView.kf.setImage(with: imgURL)
       }



}
