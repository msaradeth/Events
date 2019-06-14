//
//  Protocols.swift
//  Events
//
//  Created by Mike Saradeth on 6/13/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit

protocol LoadImageService {
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
}
extension LoadImageService {
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                guard let imageUrl = imageUrl else { return }
                let url = URL(string: imageUrl)
                let data = try Data(contentsOf: url!)
                let image = UIImage(data: data)
                completion(image)
            }catch let error {
                print(error.localizedDescription)
            }
        }
    }
}

protocol FileURLWithPathService {
    func getFileURLWithPath(filename: String, subDirectory: String) -> URL
}
extension FileURLWithPathService {
    func getFileURLWithPath(filename: String, subDirectory: String) -> URL {
        do {
            var directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            if subDirectory.count > 0 {
                directoryURL.appendPathComponent(subDirectory, isDirectory: true)
                if !directoryExistsAtPath(directoryURL.path) {
                    try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
                }
            }
            let fileURLWithPath = URL(fileURLWithPath: filename, relativeTo: directoryURL).appendingPathExtension("json")
            return fileURLWithPath
            
        } catch let error {
            print(error.localizedDescription)
            return getFileURLWithPath(filename: filename, subDirectory: "")
        }
    }
    
    func directoryExistsAtPath(_ path: String) -> Bool {
        var isDirectory = ObjCBool(true)
        let exists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return exists && isDirectory.boolValue
    }
}
