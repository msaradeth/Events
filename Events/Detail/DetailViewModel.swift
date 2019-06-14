//
//  DetailViewModel.swift
//  Events
//
//  Created by Mike Saradeth on 6/13/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import MessageUI

class DetailViewModel: NSObject {
    var item: EventModel
    
    init(item: EventModel) {
        self.item = item
    }
    
//    
//    func sendText(srcVC: UIViewController) {
//        let composeVC = MFMessageComposeViewController()
//        composeVC.messageComposeDelegate = self
//        
//        // Configure the fields of the interface.
//        composeVC.recipients = ["3142026521"]
//        composeVC.body = "I love Swift!"
//        
//        // Present the view controller modally.
//        if MFMessageComposeViewController.canSendText() {
//            srcVC.present(composeVC, animated: true, completion: nil)
//        } else {
//            print("Can't send messages.")
//        }
//    }
//    
//    //MARK: - Send Email to CSR
//    func sendMail(srcVC: UIViewController) {
//        let mailComposerVC = MFMailComposeViewController()
//        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
//        
//        
//        let csrEmailTo = "codereadtech@vanceandhines.com"
//        let csrEmailSubject = "CSR - Code:READ"
//        let csrEmailTitle = "CSR - Code:READ"
//        
//        mailComposerVC.setToRecipients([csrEmailTo])
//        mailComposerVC.setSubject(csrEmailSubject)
//        
//        
//        //Form Email Body
//        var body = [String](repeating: "\n", count: 2)
//        //        body.append("iOS Version: \n \(BikeDisplayInfoWrapper.shared().phoneInfo!)")
//        //        body.append("ECU Version: \n \(BikeDisplayInfoWrapper.shared().connectedBikeEcm!)")
//        //        body.append("Code:READ Firmware Version: \n \(BikeDisplayInfoWrapper.shared().firmwareVersion!)")
//        //        body.append("Code:READ Hardware Version: \n \(BikeDisplayInfoWrapper.shared().hardwareVersion!)")
//        //        body.append("Model: \n \(BikeDisplayInfoWrapper.shared().connectedBikeModel!)")
//        //        body.append("Year: \n \(BikeDisplayInfoWrapper.shared().connectedBikeYear!)")
//        
//        
//        
//        mailComposerVC.setMessageBody(body.filter({!$0.contains("--")}).joined(separator: "\n\n"), isHTML: false)
//        
//        //        let mailComposeViewController = self.configuredMailComposeViewController()
//        if MFMailComposeViewController.canSendMail() {
//            srcVC.present(mailComposerVC, animated: true, completion: nil)
//        }
//        
//    }
}

