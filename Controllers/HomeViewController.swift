//
//  HomeViewController.swift
//  Skimp
//
//  Created by Anan Mallik on 22/01/2018.
//  Copyright © 2018 Skimp Co. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func technologyButton(_ sender: Any)
    {
        UserDefaults.standard.set("technology", forKey: "category")
        gotoListing()
    }
    
    
    @IBAction func clothesButton(_ sender: Any)
    {
        UserDefaults.standard.set("clothes", forKey: "category")
        gotoListing()
    }
    
    
    @IBAction func toysButton(_ sender: Any)
    {
        UserDefaults.standard.set("toys", forKey: "category")
        gotoListing()
    }
    
    
    @IBAction func carsButton(_ sender: Any)
    {
        UserDefaults.standard.set("cars", forKey: "category")
        gotoListing()
    }
    
    @IBAction func booksButton(_ sender: Any)
    {
        UserDefaults.standard.set("books", forKey: "category")
        gotoListing()
    }
    
    
    @IBAction func instrumentsButton(_ sender: Any)
    {
        UserDefaults.standard.set("instruments", forKey: "category")
        gotoListing()
    }
    
    
    @IBAction func gamingButton(_ sender: Any)
    {
        UserDefaults.standard.set("gaming", forKey: "category")
        gotoListing()
    }
    
    
    @IBAction func miscButton(_ sender: Any)
    {
        UserDefaults.standard.set("misc", forKey: "category")
        gotoListing()
    }
    
    @IBAction func furnitureButton(_ sender: Any)
    {
        UserDefaults.standard.set("furniture", forKey: "category")
        gotoListing()
    }
    
    func gotoListing()
    {
        self.performSegue(withIdentifier: "goto_listing", sender: self)
    }
}
