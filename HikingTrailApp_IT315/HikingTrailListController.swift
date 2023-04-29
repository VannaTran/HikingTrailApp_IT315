//
//  HikingTrailListController.swift
//  HikingTrailApp_IT315
//
//  Created by Vanna Tran on 4/1/23.
//

import Foundation
import UIKit

class HikingTrailListController: UITableViewController {
    
    var hikingTrailObjectArray = [HikingTrail] ()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationController = segue.destination as! ViewController
        let index = tableView.indexPathForSelectedRow
        let selectedRowHT = hikingTrailObjectArray[index!.row]
        destinationController.SplitViewHT = selectedRowHT
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetJSONDate()
        //initializeData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hikingTrailObjectArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell!.textLabel!.text = hikingTrailObjectArray[indexPath.row].TrailName
        cell!.detailTextLabel!.text = "Elevation : \(hikingTrailObjectArray[indexPath.row].TrailElevation) Lengh : \(hikingTrailObjectArray[indexPath.row].TrailLength)"
        cell!.textLabel!.font = UIFont.boldSystemFont(ofSize: 18)
        cell!.textLabel!.textColor = UIColor.red
        //cell!.imageView!.image = UIImage(named: hikingTrailObjectArray[indexPath.row].TrailImageName)
        let img: UIImage = convertToImage(urlString: hikingTrailObjectArray[indexPath.row].TrailImageName)
        cell?.imageView?.image = img
        cell!.imageView?.contentMode = UIView.ContentMode.scaleAspectFill
        cell!.imageView?.frame.size.width = 200
        cell!.imageView?.frame.size.height = 200
        cell!.imageView?.layer.cornerRadius = 25
        cell!.imageView?.clipsToBounds = true
        cell!.imageView?.layer.borderWidth = 2
        cell!.imageView?.layer.borderColor = UIColor.darkGray.cgColor
        return cell!
        
    }
    
    func convertToImage(urlString: String) -> UIImage {
        let imgURL = URL(string: urlString)!
        let imgData = try? Data(contentsOf: imgURL)
        print(imgData ?? "Error. Image does not exist at URL \(imgURL)")
        let img = UIImage(data: imgData!)
        return img!
    }
    
    func GetJSONDate(){
        let endPointString = "https://raw.githubusercontent.com/VannaTran/JSONProjectsIT315/master/HikingTrails.json"
        let endPointUrl = URL(string: endPointString)
        
        let dataBytes = try? Data(contentsOf: endPointUrl!)
        
        if (dataBytes != nil){
            let dictionary: NSDictionary = (try!
                                            JSONSerialization.jsonObject(with: dataBytes!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            let htDictionary = dictionary["HikingTrails"]! as! [[String:AnyObject]]
            
            for index in 0...htDictionary.count - 1 {
                let singleHT = htDictionary[index]
                let ht = HikingTrail()
                ht.TrailName = singleHT["TrailName"] as! String
                ht.TrailDescription = singleHT["TrailDescription"] as! String
                ht.TrailDifficulty = singleHT["TrailDifficulty"] as! String
                ht.TrailImageName = singleHT["TrailImage"] as! String
                ht.TrailWebSiteAddress = singleHT["TrailWebsite"] as! String
                ht.TrailTime = singleHT["TrailTime"] as! String
                ht.TrailLength = singleHT["TrailLength"] as! String
                ht.TrailElevation = singleHT["TrailElevation"] as! String
                hikingTrailObjectArray.append(ht)
            }
        }
        
    }
    
//    func initializeData() {
//        var ht1 = HikingTrail() // Creating an object of the class hiking trail
//        ht1.TrailName = "Old Rag Mountain"
//        ht1.TrailDescription = "Head out on this 9.3-mile loop trail near Etlan, Virginia. Generally considered a challenging route. This is a very popular area for hiking, so you'll likely encounter other people while exploring. The best times to visit this trail are May through October. You'll need to leave pups at home — dogs aren't allowed on this trail. Featuring hikes with adventurous rock scrambles and 360-degree views that make you feel like you're on top of the world, there's no wonder why Old Rag is the most popular destination in Shenandoah National Park."
//        ht1.TrailLength = "9.3 mi"
//        ht1.TrailElevation = "2595"
//        ht1.TrailTime = "12 hrs"
//        ht1.TrailDifficulty = "Difficult"
//        ht1.TrailRouteType = "Loop"
//        ht1.TrailImageName = "oldrag.jpg"
//        ht1.TrailWebSiteAddress = "https://www.alltrails.com/trail/us/virginia/old-rag-mountain-loop-trail"
//        hikingTrailObjectArray.append(ht1)
//
//        var ht2 = HikingTrail() // Creating an object of the class hiking trail
//        ht2.TrailName = "Devils Bath Tub"
//        ht2.TrailDescription = "Explore this 3.9-mile out-and-back trail near Fort Blackmore, Virginia. Generally considered a challenging route, it takes an average of 1 h 44 min to complete. This is a very popular area for birding, hiking, and running, so you'll likely encounter other people while exploring. Dogs are welcome and may be off-leash in some areas."
//        ht2.TrailLength = "3.9 mi"
//        ht2.TrailElevation = "590"
//        ht2.TrailTime = "1.44 hrs"
//        ht2.TrailDifficulty = "Easy"
//        ht2.TrailRouteType = "Out & Back"
//        ht2.TrailImageName = "greatfalls.jpeg"
//        ht2.TrailWebSiteAddress = "https://www.alltrails.com/trail/us/virginia/devils-bathtub-trail"
//        hikingTrailObjectArray.append(ht2)
//
//        var ht3 = HikingTrail() // Creating an object of the class hiking trail
//        ht3.TrailName = "Billy Goat"
//        ht3.TrailDescription = "Explore this 3.6-mile loop trail near Potomac, Maryland. Generally considered a moderately challenging route, it takes an average of 1 h 12 min to complete. This is a very popular area for hiking, running, and walking, so you'll likely encounter other people while exploring. You'll need to leave pups at home — dogs aren't allowed on this trail."
//        ht3.TrailLength = "3.6 mi"
//        ht3.TrailElevation = "164"
//        ht3.TrailTime = "1.12 hrs"
//        ht3.TrailDifficulty = "Easy"
//        ht3.TrailRouteType = "Loop"
//        ht3.TrailImageName = "billygoat.jpg"
//        ht3.TrailWebSiteAddress = "https://www.alltrails.com/trail/us/maryland/billy-goat-loop-trail"
//        hikingTrailObjectArray.append(ht3)
//
//        var ht4 = HikingTrail() // Creating an object of the class hiking trail
//        ht4.TrailName = "White Top"
//        ht4.TrailDescription = "Looking for the best hiking trails in Whitetop? Whether you're getting ready to hike, bike, trail run, or explore other outdoor activities, AllTrails has 9 scenic trails in the Whitetop area. Enjoy hand-curated trail maps, along with reviews and photos from nature lovers like you. Explore one of 2 easy hiking trails in Whitetop or discover kid-friendly routes for your next family trip. Check out some trails with historic sights or adventure through the nature areas surrounding Whitetop that are perfect for hikers and outdoor enthusiasts at any skill level."
//        ht4.TrailLength = "33.1 mi"
//        ht4.TrailElevation = "200"
//        ht4.TrailTime = "0.5 hrs"
//        ht4.TrailDifficulty = "Moderate"
//        ht4.TrailRouteType = "Out & Back"
//        ht4.TrailImageName = "whiteoak.jpg"
//        ht4.TrailWebSiteAddress = "https://www.alltrails.com/us/virginia/whitetop"
//        hikingTrailObjectArray.append(ht4)
//
//        var ht5 = HikingTrail() // Creating an object of the class hiking trail
//        ht5.TrailName = "Cedar Run"
//        ht5.TrailDescription = "Try this 5.8-mile out-and-back trail near Syria, Virginia. Generally considered a challenging route, it takes an average of 4 h 2 min to complete. This trail is great for hiking. The trail is open year-round and is beautiful to visit anytime. You'll need to leave pups at home — dogs aren't allowed on this trail."
//        ht5.TrailLength = "5.8 mi"
//        ht5.TrailElevation = "2230"
//        ht5.TrailTime = "4.2 hrs"
//        ht5.TrailDifficulty = "Moderate"
//        ht5.TrailRouteType = "Loop"
//        ht5.TrailImageName = "bullrun.jpg"
//        ht5.TrailWebSiteAddress = "https://www.alltrails.com/trail/us/virginia/cedar-run-falls-trail"
//        hikingTrailObjectArray.append(ht5)
//
//
//    }
    
}
