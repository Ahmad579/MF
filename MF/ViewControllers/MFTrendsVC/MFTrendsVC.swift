//
//  MFTrendsVC.swift
//  MF
//
//  Created by Ahmed Durrani on 04/04/2018.
//  Copyright © 2018 TechEase. All rights reserved.
//

import UIKit

class MFTrendsVC: UIViewController {
    var index: Int?
    
    var previousVC: UIViewController?
    var showingIndex: Int = 0
    var pageVC: UIPageViewController?
//    var weeklyCollection: Collection?
//    var montlyCollection: Collection?
//    var allTimeCollection: Collection?


    @IBOutlet var viewOfTop: UIView!
    @IBOutlet weak var btnWeek: UIButton!
    @IBOutlet weak var btnMonth: UIButton!
    @IBOutlet weak var btnAllTime: UIButton!
    @IBOutlet var viewOfWeek: UIView!
    @IBOutlet var viewOfMonth: UIView!
    @IBOutlet var viewOfAllTime: UIView!
    var loaderShow : Bool?
    var isWeekOrallTimeClick : Bool?
    var isMonthClicked : Bool?

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        btnWeek.isSelected = true
        btnMonth.isSelected = false
        btnAllTime.isSelected = false
        viewOfWeek.backgroundColor = UIColor.black
        viewOfMonth.backgroundColor = UIColor.clear
        viewOfAllTime.backgroundColor = UIColor.clear
        isWeekOrallTimeClick = false
        isMonthClicked = false
        

        self.appDelegate.isWeek_pressed = 1
        self.appDelegate.isMonth_pressed = 1
        self.appDelegate.isAllTime_pressed = 1

        getAllCollectionByWeek()
        getAllCollectionByMonth()
        getAllCollectionByAllTime()

       
    }
    
    
    
    func setPager() {
        pageVC = storyboard?.instantiateViewController(withIdentifier: "PageViewControllerTrends") as! UIPageViewController?
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
    
    func getAllCollectionByMonth(){
        
        var params :   [String : Any]
        let userID = UserDefaults.standard.string(forKey: "id")
        if userID == nil  {
            params = [ : ]
        } else {
            params = [ "user_id"        : userID!]
        }

//        let param = [
//            :] as [String : AnyObject]
        
        if appDelegate.isFirtTimeCheck == 1 {
            loaderShow = true
        } else {
            loaderShow = false
        }
        WebServiceManager.post(params: params as Dictionary<String, AnyObject>   , serviceName: MONTHCOLLECTION, isLoaderShow: loaderShow!, serviceType: "Collection" , modelType: Collection.self, success: { (response) in
//            self.montlyCollection = (response as! Collection)
            self.appDelegate.monthlyCollectionStuff = (response as! Collection)
            if  self.appDelegate.monthlyCollectionStuff?.success == true {
                self.appDelegate.isFirtTimeCheck = 2
                self.loaderShow  = false
            } else {
                
            }
        }, fail: { (error) in
            
            
            self.showAlert(title: "MF", message: error.description , controller: self)
        }, showHUD: true)
    }
    
    func getAllCollectionByWeek(){
        
//        let param = [
//            :] as [String : AnyObject]
//
        var params :   [String : Any]
        let userID = UserDefaults.standard.string(forKey: "id")
        if userID == nil  {
            params = [ : ]
        } else {
            params = [ "user_id"        : userID!]
        }

        
        if appDelegate.isFirtTimeCheck == 1 {
            loaderShow = true
        } else {
            loaderShow = false
        }

        WebServiceManager.post(params: params as Dictionary<String, AnyObject>   , serviceName: WEEKCOLLECTION, isLoaderShow: loaderShow!, serviceType: "Collection" , modelType: Collection.self, success: { (response) in
            self.appDelegate.weeklyCollectionStuff = (response as! Collection)
            self.setPager()
            self.view.bringSubview(toFront: self.viewOfTop)

            self.getAllCollectionByMonth()
            if  self.appDelegate.weeklyCollectionStuff?.success == true {
                self.appDelegate.isFirtTimeCheck = 2
                self.loaderShow  = false

//                self.tblViewss.delegate = self
//                self.tblViewss.dataSource = self
//                self.tblViewss.reloadData()
                
            } else {
                //                self.showAlert(title: "MF", message: (self.shirtCollection?.message)!, controller: self)
                
                //                self.showAlert(title: "OEPNSPOT", message: (self.listOfAllGround?.message)!, controller: self)
                //                self.tbleView.delegate = self
                //                self.tbleView.dataSource = self
                //                self.tbleView.reloadData()
            }
        }, fail: { (error) in
            
            
            self.showAlert(title: "MF", message: error.description , controller: self)
        }, showHUD: true)
    }
    
    func getAllCollectionByAllTime(){
        
        var params :   [String : Any]
        let userID = UserDefaults.standard.string(forKey: "id")
        if userID == nil  {
            params = [ : ]
        } else {
            params = [ "user_id"        : userID!]
        }
        
        
        if appDelegate.isFirtTimeCheck == 1 {
            loaderShow = true
        } else {
            loaderShow = false
        }
        WebServiceManager.post(params: params  as Dictionary<String, AnyObject>  , serviceName: ALLCOLLECTIONTRADE, isLoaderShow: loaderShow!, serviceType: "Collection" , modelType: Collection.self, success: { (response) in
            self.appDelegate.allTimeCollectionStuff = (response as! Collection)
            
            if  self.appDelegate.allTimeCollectionStuff?.success == true {
           
                self.appDelegate.isFirtTimeCheck = 2
                self.loaderShow  = false

            } else {
                //                self.showAlert(title: "MF", message: (self.shirtCollection?.message)!, controller: self)
            }
        }, fail: { (error) in
            self.showAlert(title: "MF", message: error.description , controller: self)
        }, showHUD: true)
    }

    
    func viewControllerAtIndex(tempIndex: Int) -> UIViewController {
        if tempIndex == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MFWeeklyStuffVC" ) as! MFWeeklyStuffVC
            
            vc.index = 0
            return vc
        }else if tempIndex == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MFMonthlyStuffVC" ) as! MFMonthlyStuffVC

            vc.index = 1
            return vc
        } else  {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MFAllTimeStuffVC" ) as! MFAllTimeStuffVC

            vc.index = 2
            return vc
            
        }
    }

    //MARK: IBActions
    @IBAction func bottomBarPressed(_ sender: UIButton) {
            if sender.tag == 0
            {
                isWeekOrallTimeClick = false
                btnWeek.isSelected = true
                btnMonth.isSelected = false
                btnAllTime.isSelected = false
                showingIndex = 1
                viewOfWeek.backgroundColor = UIColor.black
                viewOfMonth.backgroundColor = UIColor.clear
                viewOfAllTime.backgroundColor = UIColor.clear
//                self.appDelegate.isWeek_pressed = 2
                self.appDelegate.isMonth_pressed = 1
                self.appDelegate.isAllTime_pressed = 1

                let startVC = viewControllerAtIndex(tempIndex: 0)
                _ = startVC.view
                
                if self.appDelegate.isWeek_pressed == 1 {
                    if isMonthClicked == false {
                        pageVC?.setViewControllers([startVC], direction: .reverse , animated: true, completion: nil)
                        self.appDelegate.isWeek_pressed = 2
                    } else {
                        pageVC?.setViewControllers([startVC], direction: .reverse , animated: true, completion: nil)
                        self.appDelegate.isWeek_pressed = 2
                        
                    }
                }
                
              
//                pageVC?.setViewControllers([startVC], direction: .forward , animated: true, completion: nil)

                
            }
            else if sender.tag == 1
            {
                btnWeek.isSelected = false
                btnMonth.isSelected = true
                btnAllTime.isSelected = false
                showingIndex = 2
                isMonthClicked = true
                
                self.appDelegate.isWeek_pressed = 1
//                self.appDelegate.isMonth_pressed = 1
                self.appDelegate.isAllTime_pressed = 1

                
                viewOfWeek.backgroundColor    = UIColor.clear
                viewOfMonth.backgroundColor = UIColor.black
                viewOfAllTime.backgroundColor     = UIColor.clear
                let startVC = viewControllerAtIndex(tempIndex: 1)
                _ = startVC.view
                
//                .forward
                
                if self.appDelegate.isMonth_pressed == 1 {

                if isWeekOrallTimeClick == true {
                    pageVC?.setViewControllers([startVC], direction:.reverse, animated: true, completion: nil)
                    isMonthClicked = true
                    self.appDelegate.isMonth_pressed = 2



                } else {
                    pageVC?.setViewControllers([startVC], direction:.forward, animated: true, completion: nil)
                    isMonthClicked = false
                    self.appDelegate.isMonth_pressed = 2

                }
            }

                
            } else {
                btnWeek.isSelected = false
                btnAllTime.isSelected = true
                btnMonth.isSelected = false
                showingIndex = 1
                isWeekOrallTimeClick = true
                self.appDelegate.isWeek_pressed = 1
                self.appDelegate.isMonth_pressed = 1
//                self.appDelegate.isAllTime_pressed = 1

                viewOfWeek.backgroundColor = UIColor.clear
                viewOfMonth.backgroundColor = UIColor.clear
                viewOfAllTime.backgroundColor = UIColor.black
                
                let startVC = viewControllerAtIndex(tempIndex: 2)
                _ = startVC.view
                
                if self.appDelegate.isAllTime_pressed == 1 {
                    pageVC?.setViewControllers([startVC], direction : .forward , animated: true, completion: nil)
                    self.appDelegate.isAllTime_pressed = 2

                }

            }
            
//            showingIndex = sender.tag
//            let startVC = viewControllerAtIndex(tempIndex: showingIndex)
//            _ = startVC.view
//            pageVC?.setViewControllers([startVC], direction:(showingIndex == 0) ? .forward : .reverse, animated: true, completion: nil)
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

extension MFTrendsVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var currIndex: Int = -1
        if viewController is MFWeeklyStuffVC {
            currIndex = (viewController as! MFWeeklyStuffVC).index!

            viewOfWeek.backgroundColor = UIColor.black
            viewOfMonth.backgroundColor = UIColor.clear
            viewOfAllTime.backgroundColor = UIColor.clear


            btnWeek.isSelected = true
            btnMonth.isSelected = false
            btnAllTime.isSelected = false

        }else if  viewController is MFMonthlyStuffVC {
            currIndex = (viewController as! MFMonthlyStuffVC).index!

            viewOfWeek.backgroundColor = UIColor.clear
            viewOfMonth.backgroundColor = UIColor.black
            viewOfAllTime.backgroundColor = UIColor.clear

            btnWeek.isSelected = false
            btnMonth.isSelected = true
            btnAllTime.isSelected = false

        } else  {
            currIndex = (viewController as! MFAllTimeStuffVC).index!

            viewOfWeek.backgroundColor = UIColor.clear
            viewOfMonth.backgroundColor = UIColor.clear
            viewOfAllTime.backgroundColor = UIColor.black

            btnWeek.isSelected = false
            btnMonth.isSelected = false
            btnAllTime.isSelected = true


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
        var currIndex: Int = -1
        if viewController is MFAllTimeStuffVC {
            currIndex = 2
            viewOfWeek.backgroundColor = UIColor.clear
            viewOfMonth.backgroundColor = UIColor.clear
            viewOfAllTime.backgroundColor = UIColor.black

            btnWeek.isSelected = false
            btnMonth.isSelected = false
            btnAllTime.isSelected = true


        }else if  viewController is MFMonthlyStuffVC {
            currIndex = (viewController as! MFMonthlyStuffVC).index!

            viewOfWeek.backgroundColor = UIColor.clear
            viewOfMonth.backgroundColor = UIColor.black
            viewOfAllTime.backgroundColor = UIColor.clear

            btnWeek.isSelected = false
            btnMonth.isSelected = true

            btnAllTime.isSelected = false

        }

        else if viewController is MFWeeklyStuffVC {
            currIndex = (viewController as! MFWeeklyStuffVC).index!

            btnWeek.isSelected = true
            btnMonth.isSelected = false

            btnAllTime.isSelected = false

            viewOfWeek.backgroundColor = UIColor.black
            viewOfMonth.backgroundColor = UIColor.clear
            viewOfAllTime.backgroundColor = UIColor.clear



        }

        if currIndex == 0 || currIndex == NSNotFound {
            return nil
        }

        currIndex = currIndex - 1
        return viewControllerAtIndex(tempIndex: currIndex)
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed == true {
            previousVC = previousViewControllers.first
            if showingIndex == 0 {
                if pageViewController.viewControllers != nil && (pageViewController.viewControllers?.count)! > 0 && pageViewController.viewControllers?.first is MFWeeklyStuffVC {
                    showingIndex = 1

                    btnWeek.isSelected = true
                    btnAllTime.isSelected = false
                    btnMonth.isSelected = false



                    viewOfWeek.backgroundColor = UIColor.black
                    viewOfMonth.backgroundColor = UIColor.clear
                    viewOfAllTime.backgroundColor = UIColor.clear

                }
            }else if showingIndex == 1 {
                if pageViewController.viewControllers != nil && (pageViewController.viewControllers?.count)! > 0 && pageViewController.viewControllers?.first is MFMonthlyStuffVC {
                    showingIndex = 2
                    btnWeek.isSelected = false
                    btnAllTime.isSelected = false
                    btnMonth.isSelected = true

                    viewOfWeek.backgroundColor = UIColor.clear
                    viewOfMonth.backgroundColor = UIColor.black
                    viewOfAllTime.backgroundColor = UIColor.clear


                }
            } else {
                if pageViewController.viewControllers != nil && (pageViewController.viewControllers?.count)! > 0 && pageViewController.viewControllers?.first is MFAllTimeStuffVC {
                    showingIndex = 0
                    btnWeek.isSelected = false
                    btnAllTime.isSelected = true
                    btnMonth.isSelected = false

                    viewOfWeek.backgroundColor = UIColor.clear
                    viewOfMonth.backgroundColor = UIColor.clear
                    viewOfAllTime.backgroundColor = UIColor.black

                }
            }
        }
    }



}


