//
//  MFCollectionDetail.swift
//  MF
//
//  Created by Ahmed Durrani on 07/04/2018.
//  Copyright © 2018 TechEase. All rights reserved.
//

import UIKit

class MFCollectionDetail: UIViewController {
    
    var collectionObj : CollectionObject?
    @IBOutlet weak var tblViewss: UITableView!
    var shirtCollection: Collection?


    override func viewDidLoad() {
        super.viewDidLoad()
        getAllCollectionProduct()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    //COLLECTIONPRODUCT
    
    func getAllCollectionProduct(){
        
        let collectionId = self.collectionObj?.id
        let param = [ "collection_id"               : collectionId!
            ] as [String : Any]
        
        WebServiceManager.post(params: param as Dictionary<String, AnyObject>   , serviceName: COLLECTIONPRODUCT, isLoaderShow: true, serviceType: "Collection" , modelType: Collection.self, success: { (response) in
            self.shirtCollection = (response as! Collection)
            if  self.shirtCollection?.success == true {
                self.tblViewss.delegate = self
                self.tblViewss.dataSource = self
                self.tblViewss.reloadData()
                
            } else {
                self.showAlert(title: "MF", message: (self.shirtCollection?.message)!, controller: self)
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

extension MFCollectionDetail : UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (self.shirtCollection?.collection?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionDetailCell", for: indexPath) as? CollectionDetailCell
        let imageOfNews = self.shirtCollection?.collection?[indexPath.row].image?.replacingOccurrences(of: " ", with: "%20")
        WAShareHelper.loadImage(urlstring:imageOfNews! , imageView: (cell?.imageOfCollections)!, placeHolder: "")
        cell?.delegate = self
        cell?.index = indexPath
        cell?.lblPrice.text = self.shirtCollection?.collection![indexPath.row].price
        
//        if isLikedOrNot == "true"{
//            //            cell?.btnIsLike.isSelected = true
//            cell?.btnIsLike.setBackgroundImage(UIImage(named: "like"), for: .normal)
//
//        } else {
//            //            cell?.btnIsLike.isSelected = false
//            cell?.btnIsLike.setBackgroundImage(UIImage(named: "unlike"), for: .normal)
//
//
//        }
//
//        let numberOfLikes = self.shirtCollection?.collection?[indexPath.row].likes
//
//        cell?.lblLike.text = "\(numberOfLikes!)"
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
}

extension MFCollectionDetail : UITableViewDataSource  {
    
    
}


extension MFCollectionDetail : AmazaonLinkClick {

    func isLinkClickedOrNot(checkCell : CollectionDetailCell , indexPath : IndexPath) {
        
        let url = self.shirtCollection?.collection![indexPath.row].link

        UIApplication.shared.openURL(NSURL(string:url!)! as URL)


    }
    
}
