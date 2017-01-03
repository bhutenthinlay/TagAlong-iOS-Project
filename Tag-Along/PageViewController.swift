//
//  PageViewController.swift
//  Tag-Along
//
//  Created by Tenzin Thinlay on 12/30/16.
//  Copyright © 2016 Tenzin Thinlay. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    lazy var viewControllerList:[UIViewController] = {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "page1")
        let vc2 = sb.instantiateViewController(withIdentifier: "page2")
        
        
        return [vc1, vc2]
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            
        }
        NotificationCenter.default.addObserver(forName: Notification.Name("segment0"), object: nil, queue: nil){ notfication in
                    print("notification for segment 0: \(notfication.object as! Int)")
                    //            self.currentIndex1 = notfication.object as! Int
            
            
            if let firstViewController = self.viewControllerList.first {
                self.setViewControllers([firstViewController], direction: .reverse, animated: true, completion: nil)
                
            }
        }
        NotificationCenter.default.addObserver(forName: Notification.Name("segment1"), object: nil, queue: nil){ notfication in
                    print("notification for segment 1: \(notfication.object as! Int)")
                    //            self.currentIndex1 = notfication.object as! Int
            if let lastViewController = self.viewControllerList.last{
                self.setViewControllers([lastViewController], direction: .forward, animated: true, completion: nil)
                
            }
            }


    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard viewControllerList.count > previousIndex else {return nil}
      
        
        
      //  NotificationCenter.default.post(name: Notification.Name("currentindexbefore"), object: previousIndex)
          print("previous is: \(vcIndex)")
        return viewControllerList[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        guard viewControllerList.count != nextIndex else { return nil}
        
        guard  viewControllerList.count > nextIndex else { return nil }
       
      //  NotificationCenter.default.post(name: Notification.Name("currentindexafter"), object: nextIndex)
         print("next is: \(vcIndex)")
        return viewControllerList[nextIndex]
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
       // guard completed else { return }
        
//          let currentPage = pageViewController.viewControllers!.first!.view.tag
//        print("current page is: \(currentPage)")
//         NotificationCenter.default.post(name: Notification.Name("currentindexbefore"), object: currentPage)
        if (!completed)
        {
            return
        }
        let currentPageIndex = pageViewController.viewControllers!.first!.view.tag //Page Index
        NotificationCenter.default.post(name: Notification.Name("currentindexbefore"), object: currentPageIndex)
        print(currentPageIndex)

    }
   
}
//extension PageViewController: UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if currentIndex1 == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
//            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
//        } else if currentIndex1 == 2 - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
//            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
//        }
//    }
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        if currentIndex1 == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
//            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
//        } else if currentIndex1 == 2 - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
//            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
//        }
//    }
//}




//var pages = [UIViewController]()
//var currentIndex1 = Array<Any>.Index()
////var currentIndex2 = Array<Any>.Index()
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    //        for view in self.view.subviews {
//    //            if let scrollView = view as? UIScrollView {
//    //                scrollView.delegate = self
//    //            }
//    //        }
//    
//    self.dataSource = self
//    self.delegate = self
//    let page1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "page1")
//    let page2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "page2")
//    
//    pages.append(page1)
//    pages.append(page2)
//    
//    setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
//    NotificationCenter.default.addObserver(forName: Notification.Name("segment0"), object: nil, queue: nil){ notfication in
//        print("notification for segment 0: \(notfication.object as! Int)")
//        //            self.currentIndex1 = notfication.object as! Int
//        
//        
//        self.setViewControllers([page1], direction: .reverse, animated: true, completion: nil)
//    }
//    NotificationCenter.default.addObserver(forName: Notification.Name("segment1"), object: nil, queue: nil){ notfication in
//        print("notification for segment 1: \(notfication.object as! Int)")
//        //            self.currentIndex1 = notfication.object as! Int
//        self.setViewControllers([page2], direction: .forward, animated: true, completion: nil)
//    }
//    
//    
//    
//    
//    // Do any additional setup after loading the view.
//}
//func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//    let currentIndex = pages.index(of: viewController)!
//    currentIndex1 = currentIndex
//    
//    let nextIndex = abs((currentIndex + 1) % pages.count)
//    
//    print("current idex is: \(currentIndex)")
//    NotificationCenter.default.post(name: Notification.Name("currentindexafter"), object: currentIndex)
//    guard nextIndex > currentIndex else {
//        
//        
//        return nil
//        
//    }
//    return pages[nextIndex]
//    
//}
//func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//    
//    let currentIndex = pages.index(of: viewController)!
//    currentIndex1 = currentIndex
//    let previousIndex = abs((currentIndex - 1) % pages.count)
//    print("current idex is: \(currentIndex)")
//    
//    NotificationCenter.default.post(name: Notification.Name("currentindexbefore"), object: currentIndex)
//    guard previousIndex < currentIndex else {
//        
//        return nil
//        
//    }
//    return pages[previousIndex]
//    
//    
//}
//func presentationCount(for pageViewController: UIPageViewController) -> Int {
//    return pages.count
//}
//func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//    return 0
//}
//func removeSwipeGesture(){
//    for view in self.view.subviews {
//        if let subView = view as? UIScrollView {
//            subView.isScrollEnabled = false
//        }
//    }
//}
