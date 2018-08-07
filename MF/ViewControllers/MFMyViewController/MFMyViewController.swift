//
//  MFMyViewController.swift
//  MF
//
//  Created by Ahmed Durrani on 04/04/2018.
//  Copyright © 2018 TechEase. All rights reserved.
//

import UIKit

class MFMyViewController: UIViewController {
    var index: Int?
    var myFavouriteCollectionList: Collection?
    var userInfo : Collection?

    @IBOutlet weak var tblViewss: UITableView!
    let ap = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewss.register(UINib(nibName: "MFCollectionOfShirts", bundle: nil), forCellReuseIdentifier: "MFCollectionOfShirts")
        tblViewss.tableFooterView = UIView(frame: .zero)

        getAllCollection()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAllCollection(){
        var params :   [String : Any]
        let userID = UserDefaults.standard.string(forKey: "id")
        if userID == nil  {
            params = [ : ]
        } else {
            params = [ "user_id"        : userID!]
        }
        WebServiceManager.post(params: params as Dictionary<String, AnyObject>   , serviceName: USERFavourite, isLoaderShow: false, serviceType: "Collection" , modelType: Collection.self, success: { (response) in
            self.myFavouriteCollectionList = (response as! Collection)
            if  self.myFavouriteCollectionList?.success == true {
                self.tblViewss.delegate = self
                self.tblViewss.dataSource = self
                self.tblViewss.reloadData()
                
            } else {
                self.tblViewss.delegate = self
                self.tblViewss.dataSource = self
                self.tblViewss.reloadData()

//                self.showAlert(title: "MF", message: (self.myFavouriteCollectionList?.message)!, controller: self)
                //                self.tbleView.delegate = self
//                self.tbleView.dataSource = self
//                self.tbleView.reloadData()
            }
        }, fail: { (error) in
            
            self.showAlert(title: "MF", message: error.description, controller: self)

//            self.showAlert(title: "OEPNSPOT", message: error.description , controller: self)
        }, showHUD: true)
    }
    
    

}

extension MFMyViewController : UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
            var numOfSections: Int = 0
            if  self.myFavouriteCollectionList?.collection?.isEmpty == false {
                numOfSections = 1
                tblViewss.backgroundView = nil
            }
            else {
                let noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tblViewss.bounds.size.width, height: tblViewss.bounds.size.height))
                noDataLabel.numberOfLines = 10
                if let aSize = UIFont(name: "Axiforma-Book", size: 14) {
                    noDataLabel.font = aSize
                }
                noDataLabel.text = "No Favourite Found!"
                noDataLabel.textColor = UIColor(red: 119.0 / 255.0, green: 119.0 / 255.0, blue: 119.0 / 255.0, alpha: 1.0)
                noDataLabel.textAlignment = .center
                tblViewss.backgroundView = noDataLabel
                tblViewss.separatorStyle = .none
            }
            return numOfSections
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.myFavouriteCollectionList?.collection?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MFCollectionOfShirts", for: indexPath) as? MFCollectionOfShirts
        
        let imageOfNews = self.myFavouriteCollectionList?.collection?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20")
        WAShareHelper.loadImage(urlstring:imageOfNews! , imageView: (cell?.imageOfCollections)!, placeHolder: "")
        
        cell?.delegate = self
        cell?.index = indexPath
        cell?.btnIsLike.isSelected = true
        cell?.viewOfLikeOrDislike.backgroundColor = UIColor.black
//        let isLikedOrNot = self.shirtCollection?.collection?[indexPath.row].liked
//
//        if isLikedOrNot == "true"{
//            cell?.btnIsLike.setBackgroundImage(UIImage(named: "like"), for: .normal)
//
//        } else {
//            cell?.btnIsLike.setBackgroundImage(UIImage(named: "unlike"), for: .normal)
//
//
//        }
        let numberOfLikes = self.myFavouriteCollectionList?.collection?[indexPath.row].likes
        cell?.lblLike.text = "\(numberOfLikes!) likes"

        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MFCollectionDetail") as? MFCollectionDetail
        vc?.collectionObj = myFavouriteCollectionList?.collection![indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 428.0
    }
    
}

extension MFMyViewController : UITableViewDataSource  {
    
    
}

extension MFMyViewController : ISFavouriteORNot {
    
    func isFavOrUnFav(checkCell : MFCollectionOfShirts , indexPath : IndexPath) {
        
        let collectionId  = self.myFavouriteCollectionList?.collection?[indexPath.row].id
        let userID = UserDefaults.standard.string(forKey: "id")

        if userID == nil {
            self.showAlert(title: "MF", message: "Please Login First", controller: self)
        } else {
            let param = [      "collection_id"           : collectionId! ,
                               "user_id"                 : userID! ,
                               "returndata"              : "collection"

                ] as [String : Any]

            WebServiceManager.post(params: param as Dictionary<String, AnyObject> , serviceName: USERLIKEORDISLIKE, isLoaderShow: true , serviceType: "User Like Or Dislike" , modelType: Collection.self, success: { (response) in
                self.userInfo = (response as! Collection)
                if  self.userInfo?.success == true {

                    if self.userInfo?.message == "Added To favorite" {
//                        checkCell.btnIsLike.setBackgroundImage(UIImage(named: "like"), for: .normal)
//                        checkCell.viewOfLikeOrDislike.backgroundColor = UIColor.black
//                        checkCell.btnIsLike.isSelected = true
                    } else {
                        self.ap.shirtCollectionOfNewTab = (response as! Collection)


                        checkCell.btnIsLike.setBackgroundImage(UIImage(named: "unlike"), for: .normal)
                        checkCell.viewOfLikeOrDislike.backgroundColor = UIColor(red: 84/255.0, green: 94/255.0, blue: 104/255.0, alpha: 1.0)
                        let idOfCollection = self.myFavouriteCollectionList?.collection![indexPath.row].id

                        if let index  = self.myFavouriteCollectionList?.collection?.index(where: {$0.id == idOfCollection}) {
                            self.myFavouriteCollectionList?.collection?.remove(at: index)
                            self.tblViewss.reloadData()
//                            self.tblViewss.beginUpdates()
//                            let indexPath = IndexPath(item: indexPath.row, section: 0)
//                            self.tblViewss.reloadRows(at: [indexPath], with: .fade)
//                            self.tblViewss.reloadData()
                        }
                        
//                        if let index = self.timeArray?.index(where: {$0.time_id == timeId}) {
//                            self.timeArray?.remove(at: index)
//                            if self.timeArray?.count == 0 {
//                                btnBooked.isHidden = true
//
//                            } else {
//                                btnBooked.isHidden = false
//
//                            }

                        
                    }

//                    self.showAlert(title: "MF", message: (self.userInfo?.message)!, controller: self)

                } else  {
                    self.showAlert(title: "MF", message: (self.userInfo?.message)!, controller: self)
                }



            }, fail: { (error) in
                self.showAlert(title: "MF", message: error.description , controller: self)
            }, showHUD: true)
        }
        
    }
    func shareShirtOnFb(checkCell : MFCollectionOfShirts , indexPath : IndexPath) {
        
        let txtToShare = ""
        let imageUrl = self.myFavouriteCollectionList?.collection?[indexPath.row].facebook
        let  imageOfModel = NSURL(string: imageUrl!)
        let objectsToShare = [txtToShare, imageOfModel!] as [Any]
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = checkCell.btnShare
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
}

