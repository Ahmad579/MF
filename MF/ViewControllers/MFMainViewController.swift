//
//  MFMainViewController.swift
//  MF
//
//  Created by Ahmed Durrani on 04/04/2018.
//  Copyright © 2018 TechEase. All rights reserved.
//

import UIKit

class MFMainViewController: UIViewController {
    
    var newShirtCollection: Collection?
    var myFavouriteList: Collection?

    var previousVC: UIViewController?
    var showingIndex: Int = 0
    var pageVC: UIPageViewController?
  
    @IBOutlet var viewOfTop: UIView!
    @IBOutlet weak var btnNew: UIButton!
    @IBOutlet weak var btnTrends: UIButton!
    @IBOutlet weak var btnMy: UIButton!
    @IBOutlet var viewOfNew: UIView!
    @IBOutlet var viewOfTrends: UIView!
    @IBOutlet var viewOfMy: UIView!
    var isWeekOrallTimeClick : Bool?
    var isMonthClicked : Bool?
    var isNew_Pressed  : Bool?
    var isTrends_Pressed  : Bool?
    var isMy_Pressed  : Bool?
    let ap = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        isNew_Pressed = true
        isTrends_Pressed = true
        isMy_Pressed = true
        
        btnNew.isSelected = true
        btnTrends.isSelected = false
        btnMy.isSelected = false
        viewOfNew.backgroundColor = UIColor.black
        viewOfTrends.backgroundColor = UIColor.clear
        viewOfMy.backgroundColor = UIColor.clear
        isWeekOrallTimeClick = false
        isMonthClicked = false

//        self.view.bringSubview(toFront: viewOfTop)

        getAllCollection()

        
    }

//    func getAllNewList(){
//
//        var params :   [String : Any]
//
//        let userID = UserDefaults.standard.string(forKey: "id")
//        if userID == nil  {
//            params = [ : ]
//        } else {
//            params = [ "user_id"        : userID!]
//        }
//
//        WebServiceManager.post(params: params as Dictionary<String, AnyObject>   , serviceName: COLLECTION, serviceType: "Collection" , modelType: Collection.self, success: { (response) in
//            self.newShirtCollection = (response as! Collection)
//            self.setPager()
//
//
//
//
//            if  self.newShirtCollection?.success == true {
//
//            } else {
//
////                self.showAlert(title: "MF", message: (self.shirtCollection?.message)!, controller: self)
//            }
//        }, fail: { (error) in
//
//
//
//            self.showAlert(title: "MF", message: error.description , controller: self)
//        }, showHUD: true)
//    }

    
    func getAllCollection(){
        
        var params :   [String : Any]
        
        let userID = UserDefaults.standard.string(forKey: "id")
        if userID == nil  {
            params = [ : ]
        } else {
            params = [ "user_id"        : userID!]
        }
        
        WebServiceManager.post(params: params as Dictionary<String, AnyObject>   , serviceName: COLLECTION, isLoaderShow: true, serviceType: "Collection" , modelType: Collection.self, success: { (response) in
//            self.newShirtCollection = (response as! Collection)
            self.ap.shirtCollectionOfNewTab = (response as! Collection)
            self.setPager()
            self.view.bringSubview(toFront: self.viewOfTop)
            if  self.newShirtCollection?.success == true {

                
            } else {
                
//                self.showAlert(title: "MF", message: (self.shirtCollection?.message)!, controller: self)
            }
        }, fail: { (error) in
            
            
            
            self.showAlert(title: "MF", message: error.description , controller: self)
        }, showHUD: true)
    }
    
    func setPager() {
        pageVC = storyboard?.instantiateViewController(withIdentifier: "PageViewControllerMain") as! UIPageViewController?
        pageVC?.dataSource = self
        pageVC?.delegate = self
        let startVC = viewControllerAtIndex(tempIndex: 0)
        _ = startVC.view
        
        pageVC?.setViewControllers([startVC], direction: .forward, animated: true, completion: nil)
        pageVC?.view.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEGHT)
        self.addChildViewController(pageVC!)
        self.view.addSubview((pageVC?.view)!)
        self.pageVC?.didMove(toParentViewController: self)
        
    }
    
    func viewControllerAtIndex(tempIndex: Int) -> UIViewController {
     
        if tempIndex == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MFNewVarietyVC" ) as! MFNewVarietyVC
//            vc.shirtCollection =  self.ap.shirtCollectionOfNewTab
            vc.index = 0
            return vc
        }
        else if tempIndex == 1 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MFTrendsVC" ) as! MFTrendsVC
            vc.index = 1
            return vc
        } else  {
             let vc = self.storyboard?.instantiateViewController(withIdentifier: "MFMyViewController") as? MFMyViewController
             vc?.index = 2
             return vc!
            
         }
     }
    
    @IBAction func btnProfile_Pressed(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MFPRofileVC") as? MFPRofileVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: IBActions
    @IBAction func bottomBarPressed(_ sender: UIButton) {
//        if showingIndex != sender.tag {
//            showingIndex = sender.tag
            if sender.tag == 0
            {
                isWeekOrallTimeClick = false

                btnNew.isSelected = true
                btnMy.isSelected = false
                btnTrends.isSelected = false
                isTrends_Pressed = true
                isMy_Pressed = true
                viewOfNew.backgroundColor = UIColor.black
                viewOfTrends.backgroundColor = UIColor.clear
                viewOfMy.backgroundColor = UIColor.clear
                let startVC = viewControllerAtIndex(tempIndex: 0)
                _ = startVC.view
                
                if  isNew_Pressed == true {
                    if isMonthClicked == false {
                        pageVC?.setViewControllers([startVC], direction: .reverse , animated: true, completion: nil)
                        isNew_Pressed = false
                    } else {
                        pageVC?.setViewControllers([startVC], direction: .reverse , animated: true, completion: nil)
                        isNew_Pressed = false
                        
                    }

                }
            }
            else if sender.tag == 1
            {
                    btnNew.isSelected = false
                    btnMy.isSelected = false
                    btnTrends.isSelected = true
                    viewOfNew.backgroundColor    = UIColor.clear
                    viewOfTrends.backgroundColor = UIColor.black
                    viewOfMy.backgroundColor     = UIColor.clear
                    isNew_Pressed = true
                    isMy_Pressed = true
                    let startVC = viewControllerAtIndex(tempIndex: 1)
                    _ = startVC.view
                    if  isTrends_Pressed == true {

                     if isWeekOrallTimeClick == true {
                            pageVC?.setViewControllers([startVC], direction:.reverse, animated: true, completion: nil)
                            isTrends_Pressed = false
                    
                    
                        }
                else {
                        pageVC?.setViewControllers([startVC], direction:.forward, animated: true, completion: nil)
                     isTrends_Pressed = false
                    
                        }
                }
           
            } else if sender.tag == 2 {
                
                
                let userID = UserDefaults.standard.string(forKey: "id")
                if userID == nil {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MFPRofileVC") as? MFPRofileVC
                    self.navigationController?.pushViewController(vc!, animated: true)
                    
                } else {
                    
                    isWeekOrallTimeClick = true
                    btnNew.isSelected = false
                    btnMy.isSelected = true
                    btnTrends.isSelected = false
                    isNew_Pressed = true

                    viewOfNew.backgroundColor = UIColor.clear
                    viewOfTrends.backgroundColor = UIColor.clear
                    viewOfMy.backgroundColor = UIColor.black
                    showingIndex = sender.tag
                    let startVC = viewControllerAtIndex(tempIndex: 2)
                    _ = startVC.view
                    
                    isTrends_Pressed = true
                    isNew_Pressed = true
                 
                    if  isMy_Pressed == true {
                        
                        pageVC?.setViewControllers([startVC], direction : .forward , animated: true, completion: nil)
                        isMy_Pressed = false
                    }

                    
                }


            }
            
//        }
    }

  
}

extension MFMainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var currIndex: Int = 0
        if viewController is MFNewVarietyVC {
//            currIndex = (viewController as! MFNewVarietyVC).index!
            currIndex = 0
            viewOfNew.backgroundColor = UIColor.black
            viewOfTrends.backgroundColor = UIColor.clear
            viewOfMy.backgroundColor = UIColor.clear

            btnNew.isSelected = true
            btnTrends.isSelected = false
            btnMy.isSelected = false

        }else if  viewController is MFTrendsVC {
//            currIndex = (viewController as! MFTrendsVC).index!
            currIndex = 1

            viewOfNew.backgroundColor = UIColor.clear
            viewOfTrends.backgroundColor = UIColor.black
            viewOfMy.backgroundColor = UIColor.clear

            btnNew.isSelected = false
            btnTrends.isSelected = true
            btnMy.isSelected = false

        } else if viewController is MFMyViewController  {
          
            currIndex = 2

//          currIndex = (viewController as! MFMyViewController).index!
          viewOfNew.backgroundColor = UIColor.clear
          viewOfTrends.backgroundColor = UIColor.clear
          viewOfMy.backgroundColor = UIColor.black
          btnNew.isSelected = false
          btnTrends.isSelected = false
          btnMy.isSelected = true
    }

        if currIndex == NSNotFound {
            return nil
        }
        currIndex = currIndex + 1
        if currIndex == 3 {
            return nil
        }
      
        let vc = viewControllerAtIndex(tempIndex: currIndex)
        return vc


    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var currIndex: Int = 0
        if viewController is MFMyViewController {
//            currIndex = (viewController as! MFMyViewController).index!
            
            currIndex = 2
            viewOfNew.backgroundColor = UIColor.clear
            viewOfTrends.backgroundColor = UIColor.clear
            viewOfMy.backgroundColor = UIColor.black

            btnNew.isSelected = false
            btnTrends.isSelected = false
            btnMy.isSelected = true


        }else if  viewController is MFTrendsVC {
//            currIndex = (viewController as! MFTrendsVC).index!
            currIndex = 1

            viewOfNew.backgroundColor = UIColor.clear
            viewOfTrends.backgroundColor = UIColor.black
            viewOfMy.backgroundColor = UIColor.clear

            btnNew.isSelected = false
            btnTrends.isSelected = true

            btnMy.isSelected = false

        }

        else {
            currIndex = 0

//            currIndex = (viewController as! MFNewVarietyVC).index!
            btnNew.isSelected = true
            btnTrends.isSelected = false

            btnMy.isSelected = false
            viewOfNew.backgroundColor = UIColor.black
            viewOfTrends.backgroundColor = UIColor.clear
            viewOfMy.backgroundColor = UIColor.clear



        }

        if currIndex == 0 || currIndex == NSNotFound {
            return nil
        }

        currIndex = currIndex - 1
        return viewControllerAtIndex(tempIndex: currIndex)
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
//        if completed == true {
//            previousVC = previousViewControllers.first
//            if showingIndex == 0 {
//                if pageViewController.viewControllers != nil && (pageViewController.viewControllers?.count)! > 0 && pageViewController.viewControllers?.first is MFNewVarietyVC {
//                    showingIndex = 0
//                    btnNew.isSelected = true
//                    btnMy.isSelected = false
//                    btnTrends.isSelected = false
//
//                    viewOfNew.backgroundColor = UIColor.black
//                    viewOfTrends.backgroundColor = UIColor.clear
//                    viewOfMy.backgroundColor = UIColor.clear
//
//                }
//            }else if showingIndex == 1 {
//                if pageViewController.viewControllers != nil && (pageViewController.viewControllers?.count)! > 0 && pageViewController.viewControllers?.first is MFTrendsVC {
//                    showingIndex = 1
//                    btnNew.isSelected = false
//                    btnMy.isSelected = false
//                    btnTrends.isSelected = true
//
//                    viewOfNew.backgroundColor = UIColor.clear
//                    viewOfTrends.backgroundColor = UIColor.black
//                    viewOfMy.backgroundColor = UIColor.clear
//
//
//                }
//            } else {
//                if pageViewController.viewControllers != nil && (pageViewController.viewControllers?.count)! > 0 && pageViewController.viewControllers?.first is MFMyViewController {
//                    showingIndex = 2
//                    btnNew.isSelected = false
//                    btnMy.isSelected = true
//                    btnTrends.isSelected = false
//
//                    viewOfNew.backgroundColor = UIColor.clear
//                    viewOfTrends.backgroundColor = UIColor.clear
//                    viewOfMy.backgroundColor = UIColor.black
//
//                }
//            }
//        }
    }
    
    
    
}

