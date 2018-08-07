//
//  MFAllTimeStuffVC.swift
//  MF
//
//  Created by Ahmed Durrani on 04/04/2018.
//  Copyright © 2018 TechEase. All rights reserved.
//

import UIKit

class MFAllTimeStuffVC: UIViewController {
    var index: Int?
    @IBOutlet weak var tblViewss: UITableView!
//    var shirtCollection: Collection?
    let ap = UIApplication.shared.delegate as! AppDelegate

//    var userInfo : UserFavModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewss.register(UINib(nibName: "MFCollectionOfShirts", bundle: nil), forCellReuseIdentifier: "MFCollectionOfShirts")
        tblViewss.tableFooterView = UIView(frame: .zero)

        if ap.allTimeCollectionStuff?.success == true {
            self.tblViewss.delegate = self
            self.tblViewss.dataSource = self
            self.tblViewss.reloadData()
            
        }

//        self.tblViewss.delegate = self
//        self.tblViewss.dataSource = self
//        self.tblViewss.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
   
}
extension MFAllTimeStuffVC : UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (ap.allTimeCollectionStuff?.collection?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MFCollectionOfShirts", for: indexPath) as? MFCollectionOfShirts
        
        let imageOfNews = ap.allTimeCollectionStuff?.collection?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20")
        WAShareHelper.loadImage(urlstring:imageOfNews! , imageView: (cell?.imageOfCollections)!, placeHolder: "")
        
        cell?.delegate = self
        cell?.index = indexPath
        
        let isLikedOrNot = ap.allTimeCollectionStuff?.collection?[indexPath.row].liked
        
        if isLikedOrNot == "true" {
            cell?.btnIsLike.isSelected = true
            cell?.viewOfLikeOrDislike.backgroundColor = UIColor.black
        } else {
            cell?.btnIsLike.isSelected = false
            cell?.viewOfLikeOrDislike.backgroundColor = UIColor(red: 84/255.0, green: 94/255.0, blue: 104/255.0, alpha: 1.0)
        }

        
//        if isLikedOrNot == "true"  {
//            cell?.btnIsLike.setBackgroundImage(UIImage(named: "like"), for: .normal)
//            cell?.viewOfLikeOrDislike.backgroundColor = UIColor.black
//
//
//            //            cell?.btnIsLike.isSelected = true
//        } else {
//            cell?.btnIsLike.setBackgroundImage(UIImage(named: "unlike"), for: .normal)
//            cell?.viewOfLikeOrDislike.backgroundColor = UIColor(red: 84/255.0, green: 94/255.0, blue: 104/255.0, alpha: 1.0)
//
//
//            //            cell?.btnIsLike.isSelected = false
//
//        }
        
        let numberOfLikes = ap.allTimeCollectionStuff?.collection?[indexPath.row].likes
        cell?.lblLike.text = "\(numberOfLikes!) likes"

        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MFCollectionDetail") as? MFCollectionDetail
        vc?.collectionObj = ap.allTimeCollectionStuff?.collection![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 428.0
    }
    
}

extension MFAllTimeStuffVC : UITableViewDataSource  {
    
    
}

extension MFAllTimeStuffVC : ISFavouriteORNot {
    
    func isFavOrUnFav(checkCell : MFCollectionOfShirts , indexPath : IndexPath) {
        
        let collectionId  = ap.allTimeCollectionStuff?.collection?[indexPath.row].id
        let userID = UserDefaults.standard.string(forKey: "id")
        
        if userID == nil {
            self.showAlert(title: "MF", message: "Please Login First", controller: self)
        } else {
            
            
            let isLikedOrNot = ap.allTimeCollectionStuff?.collection?[indexPath.row].likes
            
            if checkCell.btnIsLike.isSelected == false {
                let totalLikes = isLikedOrNot! + 1
                checkCell.viewOfLikeOrDislike.backgroundColor = UIColor.black
                checkCell.lblLike.text = "\(totalLikes) likes"
            } else {
                let totalLikes = isLikedOrNot! - 1
                checkCell.viewOfLikeOrDislike.backgroundColor = UIColor(red: 84/255.0, green: 94/255.0, blue: 104/255.0, alpha: 1.0)
                checkCell.lblLike.text = "\(totalLikes) likes"
            }

            
            let param = [      "collection_id"           : collectionId! ,
                               "user_id"                 : userID!,
                               "returndata"              : "trending"
                ] as [String : Any]

            WebServiceManager.post(params: param as Dictionary<String, AnyObject> , serviceName: USERLIKEORDISLIKE, isLoaderShow: true, serviceType: "User Like Or Dislike" , modelType: Collection.self, success: { (response) in
                self.ap.allTimeCollectionStuff = (response as! Collection)
                if  self.ap.allTimeCollectionStuff?.success == true {
                    
                    
                    if self.ap.allTimeCollectionStuff?.message == "Added To favorite" {

                        checkCell.btnIsLike.isSelected = true
                        checkCell.viewOfLikeOrDislike.backgroundColor = UIColor.black
                        let indexPath = IndexPath(item: indexPath.row, section: 0)
                        self.tblViewss.reloadRows(at: [indexPath], with: .fade)

                    } else {
                        checkCell.btnIsLike.isSelected = false
                        checkCell.viewOfLikeOrDislike.backgroundColor = UIColor(red: 84/255.0, green: 94/255.0, blue: 104/255.0, alpha: 1.0)
                        let indexPath = IndexPath(item: indexPath.row, section: 0)
                        self.tblViewss.reloadRows(at: [indexPath], with: .fade)
                    }
                    
                    
                } else  {
//                    self.showAlert(title: "MF", message: (self.ap.allTimeCollectionStuff?.message)!, controller: self)
                }
                
                
                
            }, fail: { (error) in
                self.showAlert(title: "MF", message: error.description , controller: self)
            }, showHUD: true)
        }
        
    }
    func shareShirtOnFb(checkCell : MFCollectionOfShirts , indexPath : IndexPath) {
        
        let txtToShare = ""
        let imageUrl = self.ap.allTimeCollectionStuff?.collection?[indexPath.row].facebook
        let  imageOfModel = NSURL(string: imageUrl!)
        let objectsToShare = [txtToShare, imageOfModel!] as [Any]
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = checkCell.btnShare
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
}

