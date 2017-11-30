//
//  RouteDetailViewController.swift
//  BusRoute
//
//  Created by Rakhi goel on 11/19/17.
//  Copyright © 2017 Rakhi goel. All rights reserved.
//

import UIKit

class RouteDetailViewController: UIViewController {
    
    var busRouteDetailData : NSArray = []
    var indexPath : Int!
    
    @IBOutlet weak var imageBus: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var scrollRouteDetail : UIScrollView!



    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = kDetailTitle
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        self.dispayBusRouteData()
        
    }

    @objc  func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            
            if indexPath > 0 {
                indexPath = indexPath-1
                let subViews = scrollRouteDetail.subviews
                for subview in subViews{
                    subview.removeFromSuperview()
                }
                
                self.dispayBusRouteData()
            }
            
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            
            if indexPath >= 0 && indexPath < busRouteDetailData.count - 1 {
                
                let subViews = scrollRouteDetail.subviews
                for subview in subViews{
                    subview.removeFromSuperview()
                }
                
                indexPath = indexPath+1
                self.dispayBusRouteData()
            }
        }
    }
    
    // MARK : Display Data
    
    func dispayBusRouteData() {
        
        if let dict = busRouteDetailData[indexPath] as? NSDictionary
        {
            let title = dict["name"] as! String
            labelName.text = title
            
            let desc = dict["description"] as! String
            labelDesc.text = desc
            
            self.showRouteDetail(dict: dict)
            
            imageBus.image = UIImage(named: "placeholder")

            
            if let imagePath = dict["imageUrl"] as? String{
                
                let imageUrl = URL(string: imagePath)
                
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    if let imageData:NSData = NSData(contentsOf: imageUrl!) {
                    
                        // When from background thread, UI needs to be updated on main_queue
                        DispatchQueue.main.async {
                            let image = UIImage(data: imageData as Data)
                            self.imageBus.image = image
                        }
                    }
                }
            }
        }
    }
    
    func showRouteDetail(dict:NSDictionary)
    {
        let arrStops = dict["stops"] as! NSArray
        
        let viewWidth:CGFloat = scrollRouteDetail.frame.size.width - 10
        let viewheight:CGFloat = 50
        let viewLineHeight:CGFloat = 5
        var yPosition:CGFloat = 0
        var scrollViewContentSize:CGFloat=0;

        var count = 0
        
        for stopsDict in arrStops{
            count+=1
            
            let nameDict = stopsDict as? Dictionary<String, Any>
            print( nameDict!["name"] as! String)
            
            let view : UIView = UIView()
            view.frame.origin.x = 5
            view.frame.origin.y = yPosition
            view.frame.size.width = viewWidth
            view.frame.size.height = viewheight
            view.backgroundColor = UIColor.clear

            
            
            let viewStop : UIImageView = UIImageView()
            viewStop.frame.origin.x = 30
            viewStop.frame.origin.y = 0
            viewStop.frame.size.width = 16
            viewStop.frame.size.height = 32
            viewStop.backgroundColor = UIColor.clear
            viewStop.image = UIImage(named: "dotIcon")
            
            view.addSubview(viewStop)
            
            
            let labelTitle : UILabel = UILabel()
            labelTitle.frame.origin.x = viewStop.frame.origin.x + viewStop.frame.size.width + 15 //70
            labelTitle.frame.origin.y = viewStop.frame.origin.y
            labelTitle.frame.size.width = 200
            labelTitle.frame.size.height = viewStop.frame.size.height
            labelTitle.text = (nameDict!["name"] as? String)
            //labelTitle.font = UIFont.boldSystemFont(ofSize: 25)
            
            view.addSubview(labelTitle)
            
            
            let viewLine : UIView = UIView()
            viewLine.frame.origin.x = viewStop.frame.origin.x + viewStop.frame.size.width/2 - viewLineHeight/2
            viewLine.frame.origin.y = viewStop.frame.origin.y + viewStop.frame.size.height/2
            viewLine.frame.size.width = viewLineHeight
            viewLine.frame.size.height = viewheight - viewStop.frame.origin.y
            viewLine.backgroundColor = UIColor.black
            
            
            if count != arrStops.count{
                view.addSubview(viewLine)
            }

            
            scrollRouteDetail.addSubview(view)
            let spacer:CGFloat = 0
            yPosition+=viewheight + spacer
            
            scrollViewContentSize+=viewheight + spacer

            scrollRouteDetail.contentSize = CGSize(width: viewWidth, height: scrollViewContentSize)
            
            scrollRouteDetail.backgroundColor = UIColor.clear
        }
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
