//
//  AccommodationGalleryPageViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 11.04.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit

class AccommodationGalleryPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var picturesURLArray = [String]()
    var selectedPictureIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false // fix: for tap & move image issue
        self.delegate = self
        self.dataSource = self
                        
        self.dataSource = self
        self.setViewControllers([getViewController(at: selectedPictureIndex)] as [UIViewController],
                                direction: UIPageViewController.NavigationDirection.forward,
                                animated: false,
                                completion: nil)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        let pageContent: AccommodationGalleryContentViewController = viewController as! AccommodationGalleryContentViewController
        var index = pageContent.pageIndex
        
        if ((index == 0) || (index == NSNotFound)) {
            return nil
        }
        
        index = index - 1; // go back
        
        return getViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        let pageContent: AccommodationGalleryContentViewController = viewController as! AccommodationGalleryContentViewController
        var index = pageContent.pageIndex
        
        if (index == NSNotFound) {
            return nil;
        }
        
        index = index + 1; // go ahead
        
        if (index == self.picturesURLArray.count) { // do we reach the end ?
            return nil;
        }
        return getViewController(at: index)
    }
    
    func getViewController(at index: NSInteger) -> AccommodationGalleryContentViewController
    {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccommodationGalleryContentViewController") as! AccommodationGalleryContentViewController
        pageContentViewController.pictureURL = "\(self.picturesURLArray[index])"
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
