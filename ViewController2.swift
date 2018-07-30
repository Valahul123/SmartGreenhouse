//
//  ViewController2.swift
//  Green
//
//  Created by Cisar Eduard on 25/07/2018.
//  Copyright © 2018 Cisar Eduard. All rights reserved.
//

import UIKit
import Alamofire
import UserNotifications


class ViewController2: UIViewController {
    func Repetare() {
        Timer.scheduledTimer(timeInterval: 3, target: self,   selector: (#selector(notificari)), userInfo: nil, repeats: true)
    }

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler:{didAllow, error in
        } )
        // Do any additional setup after loading the view.
        Alamofire.request("http://192.168.1.3:3000/logs").responseString { response in switch response.result {
        case .success(let JSON):
            print("Success with JSON: \(JSON)")
            self.textView.text=JSON
            
            
            
        case .failure(let error):
            print("Request failed with error: \(error)")
            }
            
            
            
            
            
        }
        Repetare()
    }
    @objc func notificari() {
       
        Alamofire.request("http://192.168.1.3:3000?action=7&sera=1").responseString { response in switch response.result {
        case .success(let JSON):
            print("Success with JSON: \(JSON)")
            var json : String = JSON
            if(json == "da"){
                let content = UNMutableNotificationContent()
                content.title = "Alerta!!!"
                content.body = "fara apa"
                content.badge = 1;
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
                let request = UNNotificationRequest(identifier: "AlertaUmiditate", content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
            
            
        case .failure(let error):
            print("Request failed with error: \(error)")
            }
            
            
            
            
            
            
        }
 
     
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
