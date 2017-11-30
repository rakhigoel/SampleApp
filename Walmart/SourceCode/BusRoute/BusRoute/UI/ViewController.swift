//
//  ViewController.swift
//  BusRoute
//
//  Created by Rakhi goel on 11/15/17.
//  Copyright © 2017 Rakhi goel. All rights reserved.
//

import UIKit


class ViewController: BRBaseViewController , UITableViewDelegate ,UITableViewDataSource{
    
    var busRouteData : NSArray = []
    @IBOutlet weak var busRouteTableView: UITableView!

    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache:NSCache<AnyObject, AnyObject>!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = kAppTitle
        busRouteTableView.delegate = self
        busRouteTableView.dataSource = self
        
        self.cache = NSCache()
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.downloadAndParseData()
        
    }
    
    func downloadAndParseData(){
       
        let url = URL(string: "https://www.mocky.io/v2/5a0b474a3200004e08e963e5")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! NSArray
                self.busRouteData = json
                print(self.busRouteData)
                
                DispatchQueue.main.async {
                    if self.busRouteData.count > 0 {
                        self.busRouteTableView.reloadData()
                    }
                }
        
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
 
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {

        return busRouteData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusRouteCell", for: indexPath)

        if let dict = busRouteData[indexPath.row] as? NSDictionary
        {
            let title = dict["name"] as! String
            
            cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell.selectionStyle = UITableViewCellSelectionStyle.blue
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            
            cell.textLabel!.text = title
            cell.imageView?.image = UIImage(named: "placeholder")
            
            if let imagePath = dict["imageUrl"] as? String{
                
                if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
                    // 2
                    // Use cache
                    print("Cached image used, no need to download it")
                    cell.imageView?.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
                }else{
                    // 3
                    let artworkUrl = imagePath 
                    let url:URL! = URL(string: artworkUrl)
                    task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                        if let data = try? Data(contentsOf: url){
                            // 4
                            DispatchQueue.main.async(execute: { () -> Void in
                                // 5
                                // Before we assign the image, check whether the current cell is visible
                                if let updateCell = tableView.cellForRow(at: indexPath) {
                                    let img:UIImage! = UIImage(data: data)
                                    updateCell.imageView?.image = img
                                    self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
                                }
                            })
                        }
                    })
                    task.resume()
                }
            }
        }
        
        
        return cell
    }
    
    
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        
        let viewController:RouteDetailViewController = BRUtility.controllerForClass(name: "RouteDetailViewController",storyBoardName: StoryBoardName.kMain) as! RouteDetailViewController
        
        viewController.busRouteDetailData = busRouteData
        viewController.indexPath = indexPath.row
        self.navigationController?.pushViewController(viewController, animated:true)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

