//
//  ListingViewController.swift
//  Skimp
//
//  Created by Anan Mallik on 27/01/2018.
//  Copyright © 2018 Skimp Co. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var get_items: ItemsNetworking!
    var item_list: [Dictionary<String, AnyObject>] = []
    var count = 0
    @IBOutlet weak var title_label: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        setCategory()
        
        get_item_list()
    
        //customActivityIndicatory(self.view, startAnimate: true)
        
        let when = DispatchTime.now() + 2.5
        DispatchQueue.main.asyncAfter(deadline: when)
        {
            //self.customActivityIndicatory(self.view, startAnimate: false)
        }

    }
    
    func setCategory()
    {
        let category = UserDefaults.standard.string(forKey: "category")!
        Category.item_category = category
        
        switch category
        {
            case "technology":
                self.title_label.text = "Tech Stuff"
            case "clothes":
                self.title_label.text = "Clothing"
            case "cars":
                self.title_label.text = "Cars"
            case "books":
                self.title_label.text = "Books"
            case "toys":
                self.title_label.text = "Toys"
            case "misc":
                self.title_label.text = "Misc."
            case "furniture":
                self.title_label.text = "Furniture"
            case "gaming":
                self.title_label.text = "Games"
            case "instruments":
                self.title_label.text = "Instruments"
            default:
                self.title_label.text = "All"
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func get_item_list()
    {
        get_items = ItemsNetworking()
        get_items.downloadItemDetails()
            {
                self.item_list = JSON_DATA
                self.count = self.item_list.count
                self.tableView.reloadData()
                
                print(self.item_list)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
   {
        let row = indexPath.row
        UserDefaults.standard.set(row, forKey: "row")
        self.performSegue(withIdentifier: "go_to_details", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath)
        
        let image_item = cell.viewWithTag(1) as! UIImageView
        let title_item = cell.viewWithTag(2) as! UILabel
        let price_item = cell.viewWithTag(3) as! UILabel
        let desc_item = cell.viewWithTag(4) as! UILabel
        let sold_item = cell.viewWithTag(5) as! UILabel
        
        title_item.text = self.item_list[indexPath.row]["title"]! as? String
        price_item.text = "£" + (self.item_list[indexPath.row]["price"]! as! String)
        desc_item.text = self.item_list[indexPath.row]["description"]! as? String
        
        image_item.layer.cornerRadius = 10
        image_item.layer.shadowRadius = 5
        image_item.layer.shadowOpacity = 0.5
        
        let path = IMAGE_DATA + (self.item_list[indexPath.row]["image1_url"]! as! String)
        let url = URL(string: path)
        

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                //Set Image to UIView in Cell:
                image_item.image = UIImage(data: data!)
            }
        }
        
        let sold = self.item_list[indexPath.row]["sold"]! as! String
        
        //Show Sold label for items that are not for sale:
        if (sold == "1")
        {
            sold_item.isHidden = false
        }
        
        return cell
  
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 125
    }
    
    func customActivityIndicatory(_ viewContainer: UIView, startAnimate:Bool? = true) -> UIActivityIndicatorView {
        let mainContainer: UIView = UIView(frame: viewContainer.frame)
        mainContainer.center = viewContainer.center
        mainContainer.backgroundColor = UIColor.darkGray
        mainContainer.alpha = 0.5
        mainContainer.tag = 789456123
        mainContainer.isUserInteractionEnabled = false
        
        let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
        viewBackgroundLoading.center = viewContainer.center
        viewBackgroundLoading.backgroundColor = UIColor.darkGray
        viewBackgroundLoading.alpha = 0.5
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 15
        
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 40.0, height: 40.0)
        activityIndicatorView.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
        if startAnimate!{
            viewBackgroundLoading.addSubview(activityIndicatorView)
            mainContainer.addSubview(viewBackgroundLoading)
            viewContainer.addSubview(mainContainer)
            activityIndicatorView.startAnimating()
        }else{
            for subview in viewContainer.subviews{
                if subview.tag == 789456123{
                    subview.removeFromSuperview()
                }
            }
        }
        return activityIndicatorView
    }

    
}
