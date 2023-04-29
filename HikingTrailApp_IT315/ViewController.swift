//
//  ViewController.swift
//  HikingTrailApp_IT315
//
//  Created by Vanna Tran on 2/19/23.
//

import UIKit
import AVKit //include this kit for sound
import AVFoundation

class ViewController: UIViewController {
    
    var SplitViewHT: HikingTrail = HikingTrail()
    
    //Declare a global variable for the sound Object.
    var mySoundFile:AVAudioPlayer!
    //Allocate mem for the sound variable and initialize the variable - written in the viewDidLoad Function
    
    //call the Play() / Stop() / Pause() / Rewind() / Forward()
    //written in the SetLabels Function
    
    
    
    
    //var hikingTrailArray = ["Old Rag Mountain", "Devils Bath Tub", "Billy Goat", "White Top", "Cedar Run"]
    
    var hikingTrailObjectArray = [HikingTrail] () // create an array of Hiking Trail Objects
    
    var globalHT = HikingTrail()
    
    @IBAction func btnOpenSite(_ sender: Any) {
        let browserApp = UIApplication.shared
        //globalHT is a global variable that is set in the SetLabels Function.
        //this global variable is used to pass values between functions.
        let url = URL(string: globalHT.TrailWebSiteAddress)
        //let url = URL(string: "http://www.gmu.edu")
        browserApp.open(url!)
    }
    
    
    @IBOutlet weak var SWFav: UISwitch!
    
    @IBAction func SWValuedChanged(_ sender: Any) {
        if SWFav.isOn {
            UserDefaults.standard.set(lblName.text, forKey: "favorite" )
        }
        else {
            UserDefaults.standard.set("", forKey: "favorite")
        }
    }
    
    
    @IBOutlet weak var imgTrail: UIImageView!
    
    @IBOutlet weak var lblElevation: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblRouteType: UILabel!
    
    @IBOutlet weak var lblDifficulty: UILabel!
    
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var lblLength: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initialize the sound variable that was globally declared
        let urlObject = URL(fileURLWithPath: Bundle.main.path(forResource:"target_hit", ofType: "wav")!)
        
        mySoundFile = try? AVAudioPlayer(contentsOf:urlObject)
        //mySoundFile.play() //in the Set Labels function
        
        //initializeData()
        setLabels()
        // Do any additional setup after loading the view.
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        imgTrail.alpha = 0
        lblTime.alpha = 0
        txtDescription.alpha = 0
        lblName.alpha = 0
        
        
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        setLabels()
        UIView.animate(withDuration: 3, animations: {
            self.imgTrail.alpha = 1
            self.lblTime.alpha = 1
            self.txtDescription.alpha = 1
            self.lblName.alpha = 1
        })
        
        setLabels()
    }
    
    
    @IBAction func btnNext(_ sender: Any) {
        setLabels()
        
    }
    func setLabels() {
        // lblName.text = hikingTrailArray.randomElement()
        
        var randomTrail = SplitViewHT
        globalHT = randomTrail
        lblName.text = randomTrail.TrailName
        lblLength.text = randomTrail.TrailLength
        txtDescription.text = randomTrail.TrailDescription
        // Set text view properties
        txtDescription.layer.cornerRadius = 25
        txtDescription.layer.borderWidth = 2
        txtDescription.layer.borderColor = UIColor.lightGray.cgColor
        
        
        lblTime.text = randomTrail.TrailTime
        
        lblElevation.text = randomTrail.TrailElevation
        lblRouteType.text = randomTrail.TrailRouteType
        
        lblDifficulty.text = randomTrail.TrailDifficulty
        switch(randomTrail.TrailDifficulty) {
        case "Difficult":
            lblDifficulty.backgroundColor = UIColor(red: 241/255, green: 92/255, blue: 12/255, alpha: 1)
            break
        case "Moderate":
            lblDifficulty.backgroundColor = UIColor(red: 250/255, green: 246/255, blue: 103/255, alpha: 1)
            break
        case "Easy":
            lblDifficulty.backgroundColor = UIColor(red: 200/255, green: 246/255, blue: 186/255, alpha: 1)
            break
        default:
            lblDifficulty.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
            
        }
        
        
        imgTrail.image = convertToImage(urlString: randomTrail.TrailImageName)
        // Make Image Corners Rounded
        imgTrail.layer.cornerRadius = 30
        imgTrail.clipsToBounds = true
        imgTrail.layer.borderWidth = 5
        imgTrail.layer.borderColor = UIColor.darkGray.cgColor
        //http://www.appsdeveloperblog.com/uiimageview-rounded-corners-in-swift/
        
        
        
        let fav = UserDefaults.standard.string(forKey: "favorite")
        SWFav.isOn = (randomTrail.TrailName == fav)
        if (SWFav.isOn) {
            view.backgroundColor = UIColor.lightGray
        }
        else  { view.backgroundColor = UIColor.white }
        
        mySoundFile.play()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! WebViewController
        destinationController.PassedHikingTrail = SplitViewHT
    }
    
    func convertToImage(urlString: String) -> UIImage {
        let imgURL = URL(string: urlString)!
        let imgData = try? Data(contentsOf: imgURL)
        print(imgData ?? "Error. Image does not exist at URL \(imgURL)")
        let img = UIImage(data: imgData!)
        return img!
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

