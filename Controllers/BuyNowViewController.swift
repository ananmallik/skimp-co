//
//  BuyNowViewController.swift
//  Skimp
//
//  Created by Anan Mallik on 27/01/2018.
//  Copyright © 2018 Skimp Co. All rights reserved.
//

import UIKit
import MessageUI

class BuyNowViewController: UIViewController {

    @IBOutlet weak var apple_button: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func payCash(_ sender: Any)
    {
        sendEmail()
    }
    
    func sendEmail()
    {
        if MFMailComposeViewController.canSendMail()
        {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            mail.setToRecipients(["ananmallik@gmail.com"])
            mail.setMessageBody("<p>Hello World!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

}
