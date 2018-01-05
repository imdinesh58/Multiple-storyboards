//
//  testViewController.swift
//  CoreDataSampleApp
//
//  Created by Apple-1 on 11/17/17.
//  Copyright © 2017 Apple-1. All rights reserved.
//

import UIKit
import SwiftyJSON
import AVKit
import AVFoundation


class testViewController: UIViewController,UIWebViewDelegate{

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Test window laoded")
        //webView.delegate = self
        //webView.loadRequest(NSURLRequest(url: NSURL(string: "http://www.google.com")! as URL) as URLRequest)
    }
    
        //https://stackoverflow.com/questions/25932570/how-to-play-video-with-avplayerviewcontroller-avkit-in-swift
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       /* let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }*/
    }
    
    
    func marysFarm() {
        let ApiUrl = "https://api.randomuser.me/"
        let req = NSMutableURLRequest(url: NSURL(string: ApiUrl)! as URL)
        req.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: req as URLRequest) {
            data, response, error in
            // Check for error
            if error != nil {
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("StatusCode is === \(httpStatus.statusCode)")
                OperationQueue.main.addOperation{
                    let alert = UIAlertController(title: "Alert", message: "Server Error... failed to load assigned tasks", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {
                let responseString = String(data: data!, encoding: String.Encoding.utf8)
               // print("API call done with ResponseString = \(responseString)")
                print("StatusCode is === \(httpStatus.statusCode)")
                _ = self.convertStringToDictionary(text: responseString!)
            }
            
        }  //close task
        task.resume()
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        DispatchQueue.main.async(){
                if let data = text.data(using: String.Encoding.utf8) {
                    do {
                        let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
                        //let jsonArray = JSON(jsonObj)
                        print("JSON = " , jsonObj)
                        
                        //for dict in (jsonObj  as? [[String: Any]])! { //(key or index, element)
                            //let test = dict["gender"] as! String
                            //print("gender  ",test)
                            
                            //let test2 = dict["name"]?["first"] as! String
                            //print("name  ", test2)
                        //}
                    } catch {
                        // Catch any other errors
                    }
                }
        }
        return nil
    }
    
}






