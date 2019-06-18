//
//  AppDelegate.swift
//  Events
//
//  Created by Mike Saradeth on 6/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let items = [EventModel]()
        let eventService = EventService()
        let viewModel = ListViewModel(items: items, eventService: eventService)
        let listVC = ListVC(title: "PHUN APP", viewModel: viewModel)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: listVC)
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIDevice.current.userInterfaceIdiom == .pad ? .all : .all    //[.portrait, .portraitUpsideDown]
    }

}

