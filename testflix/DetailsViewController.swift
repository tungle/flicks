//
//  DetailsViewController.swift
//  testflix
//
//  Created by Tung Le on 16/10/2016.
//  Copyright © 2016 Tung Le. All rights reserved.
//

import UIKit
import AFNetworking

class DetailsViewController: UIViewController {
    
    public var photoUrl = ""
    public var titleText = ""
    public var contentText = ""
 
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoView.setImageWith(URL(string:photoUrl)!)
        titleLabel.text = titleText
        contentLabel.text = contentText
        
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
