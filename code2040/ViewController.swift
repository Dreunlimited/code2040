//
//  ViewController.swift
//  code2040
//
//  Created by Dandre Ealy on 9/27/16.
//  Copyright © 2016 Dandre Ealy. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var result = ""
    var resultDic = ["token": "831b21c47a7f7daee7d6e4e3fa11deaa","string": ""]
    let token = ["token": "831b21c47a7f7daee7d6e4e3fa11deaa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reverseString(_ sender: AnyObject) {
        
        
        
        let url =  "http://challenge.code2040.org/api/reverse"
        let postUrl = "http://challenge.code2040.org/api/reverse/validate"
        
        
        Alamofire.request(url, method: .post, parameters: token).responseString { response in
            
            print(response.result) // HTTP URL response
            
            
            print("works \(response.debugDescription)")
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
                
                self.result = String(JSON.characters.reversed())
                print(self.result)
                self.resultDic["string"] = self.result
                print(self.resultDic)
                
                Alamofire.request(postUrl, method: .post, parameters: self.resultDic).responseString { response in
                    print(response.result)
                    
                }
                
            }
        }
        
    }
    
    @IBAction func Registration(_ sender: AnyObject) {
        
        
        let registration = ["token": "831b21c47a7f7daee7d6e4e3fa11deaa", "github" : "https://github.com/Dreunlimited/code2040"]
        
        let url = NSURL(string: "http://challenge.code2040.org/api/register")
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url as! URL)
        
        do {
            
            let auth = try JSONSerialization.data(withJSONObject: registration, options: .prettyPrinted)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = auth
            
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                
                //print("Got response \(response) with error \(error)")
                //print("Done.")
            })
            
            
            task.resume()
            
        } catch {
            //print("Error")
        }
        
        
    }
    
    
    @IBAction func datingGame(_ sender: AnyObject) {
        
        let datingUrl = "http://challenge.code2040.org/api/dating"
        let dateingValidateUrl = "http://challenge.code2040.org/api/dating/validate"
        
        Alamofire.request(datingUrl, method: .post, parameters: token).responseJSON { response in
            //print(response.result.value)
            
            if let JSON = response.result.value as? [String:AnyObject] {
                
                if let dateStamp = JSON["datestamp"] , let interval = JSON["interval"] as? Int {
                    print("date \(dateStamp)")
                    print("second \(interval)")
                    
                    let dateFormatter = ISO8601DateFormatter()
                    if let date = dateFormatter.date(from: dateStamp as! String) {
                        print("New date \(date)")
                        
                        let newtimeStamp = date.addingTimeInterval(TimeInterval(interval))
                        
                        print("Time \(newtimeStamp)")
                        
                        let finalDate = dateFormatter.string(from: newtimeStamp)
                        print("finalDate time \(finalDate)")
                        
                        let datingGame = ["token": "831b21c47a7f7daee7d6e4e3fa11deaa", "datestamp" : finalDate]
                        
                        Alamofire.request(dateingValidateUrl, method: .post, parameters: datingGame).responseString { response in
                            print(response.result.value)
                            
                        }
                        
                        
                    }
                    
                    
                }
                
            }
        }
        
    }
    
    
    @IBAction func prefix(_ sender: AnyObject) {
        
        let prefixUrl = "http://challenge.code2040.org/api/prefix"
        let prefixvalidate = "http://challenge.code2040.org/api/prefix/validate"
        
        Alamofire.request(prefixUrl, method: .post, parameters: token).responseJSON { response in
            //print(response.result.value)
            
            if let JSON = response.result.value as? [String: AnyObject] {
                
                if let prefixValue = JSON["prefix"] as? String, let arrayValues = JSON["array"] as? [String] {
                    
                    
                    let filterArray = arrayValues.filter { !$0.lowercased().contains(prefixValue) }
                    
                    let resultsDic = ["token": "831b21c47a7f7daee7d6e4e3fa11deaa", "array": filterArray] as [String : Any]
                    
                    print(resultsDic)
                    print(arrayValues)
                    
                    Alamofire.request(prefixvalidate, method: .post, parameters: resultsDic).responseString { response in
                        print(response.result.value)
                        
                    }
                    
                    
                    
                }
            }
            
        }
        
        
    }
    
    
    
    @IBAction func findNeedle(_ sender: AnyObject) {
        
        let url = "http://challenge.code2040.org/api/haystack"
        let validateUrl = "http://challenge.code2040.org/api/haystack/validate"
        
        Alamofire.request(url, method: .post, parameters: token).responseJSON { response in
            
            if let JSON = response.result.value as? [String: AnyObject] {
                
                if let needleValue = JSON["needle"] , let haystackValues = JSON["haystack"] as? [AnyObject]  {
                    print(needleValue)
                    for (index, value) in haystackValues.enumerated() {
                        
                        if value === needleValue {
                            print("\(index): \(value)")
                            
                            let needleIndex = ["token": "831b21c47a7f7daee7d6e4e3fa11deaa", "needle":index] as [String : Any]
                            
                            Alamofire.request(validateUrl, method: .post, parameters: needleIndex).responseString { response in
                                print(response.result)
                                
                            }
                        }
                    }
                    
                }
            }
            
            
            
        }
        
        
    }
    
    
}















