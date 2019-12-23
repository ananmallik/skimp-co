//
//  ItemDetailViewController.swift
//  Skimp
//
//  Created by Anan Mallik on 27/01/2018.
//  Copyright © 2018 Skimp Co. All rights reserved.
//

import UIKit
import MessageUI

class ItemDetailViewController: UIViewController {
    
    
    @IBOutlet weak var item_image: UIImageView!
    @IBOutlet weak var item_title: UILabel!
    @IBOutlet weak var item_price: UILabel!
    @IBOutlet weak var item_desc: UILabel!
    @IBOutlet weak var item_desc_main: UILabel!
    @IBOutlet weak var item_location: UILabel!
    @IBOutlet weak var view_count: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        updateItemDetail()

        // Do any additional setup after loading the view.
    }

    
    func updateItemDetail()
    {
        let row = UserDefaults.standard.integer(forKey: "row")
        self.item_title.text = GlobalData.sharedInstance.dict[row]["title"] as? String
        
        let path = IMAGE_DATA + (GlobalData.sharedInstance.dict[row]["image1_url"]! as! String)
        let url = URL(string: path)
        
        //Download Image Data using DispatchQueue(to avoid blocking main thread):
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                //Set Image to UIView in Cell:
                self.item_image.image = UIImage(data: data!)
            }
        }
            
        self.item_price.text = "£" + (GlobalData.sharedInstance.dict[row]["price"] as? String)!
        
        self.item_desc_main.text = GlobalData.sharedInstance.dict[row]["description"] as? String
        
        self.view_count.text = "views: " + (GlobalData.sharedInstance.dict[row]["view_count"] as? String)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func sendButton(_ sender: Any)
    {
        self.sendEmail()
    }
    
    func sendEmail()
    {
        if MFMailComposeViewController.canSendMail()
        {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            mail.setToRecipients(["ananmallik@gmail.com"])
            mail.setMessageBody("<p>re: Skimp Item for Sale</p>", isHTML: true)
            
            present(mail, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }

}
