//
//  ViewController.swift
//  Sera
//
//  Created by Cisar Eduard on 09/06/2018.
//  Copyright © 2018 Cisar Eduard. All rights reserved.
//

import UIKit
import Alamofire

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



class ViewController: UIViewController {
 
    func Repetare() {
        Timer.scheduledTimer(timeInterval: 10, target: self,   selector: (#selector(getValues)), userInfo: nil, repeats: true)
    }
    
    
    
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    var menuShowing = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        TextView1.layer.cornerRadius = 5.0
        TextView1.layer.borderWidth = 0.5
        TextView2.layer.cornerRadius = 5.0
        TextView2.layer.borderWidth = 0.5
        TextView3.layer.cornerRadius = 5.0
        TextView3.layer.borderWidth = 0.5
        Text1.layer.borderWidth = 0.5
        Text1.layer.cornerRadius = 5.0
        Text2.layer.borderWidth = 0.5
        Text2.layer.cornerRadius = 5.0
        Text3.layer.borderWidth = 0.5
        Text3.layer.cornerRadius = 5.0
        Text4.layer.borderWidth = 0.5
        Text4.layer.cornerRadius = 5.0
        Text5.layer.borderWidth = 0.5
        Text5.layer.cornerRadius = 5.0
        menuView.layer.shadowOpacity = 0.5
        menuView.layer.shadowRadius = 6
        button1.layer.cornerRadius = 4
        button2.layer.cornerRadius = 4
        button3.layer.cornerRadius = 4
        getValues()
        Repetare()
        
        
    }
    
    
    
  
    
    @IBOutlet weak var menuView: UIView!
    
   
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var Text1: UITextField!
    @IBOutlet weak var Text2: UITextField!
    @IBOutlet weak var Text3: UITextField!
    @IBOutlet weak var Text4: UITextField!
    @IBOutlet weak var Text5: UITextField!
    
    
    @IBOutlet weak var TextView1: UITextView!
    @IBOutlet weak var TextView2: UITextView!
    @IBOutlet weak var TextView3: UITextView!
    
    
    
    
    @IBAction func openMenu(_ sender: Any) {
        
        
        
        if(menuShowing){
            leadingConstraint.constant = -180
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
        }else{
            
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        menuShowing = !menuShowing
    }
    
    
    
    
    @objc func getValues() {
        
        Alamofire.request("http://192.168.1.3:3000?action=3&sera=1&numeActiune=Preia%20luminozitatea").responseString { response in switch response.result {
        case .success(let JSON):
            print("Success with JSON: \(JSON)")
            self.TextView1.text=JSON
            
            
            
        case .failure(let error):
            print("Request failed with error: \(error)")
            }
            
            
            
            
            
            
        }
        Alamofire.request("http://192.168.1.3:3000?action=4&sera=1&numeActiune=Preia%20temperatura").responseString { response in switch response.result {
        case .success(let JSON):
            print("Success with JSON: \(JSON)")
            self.TextView2.text=JSON + "°C"
            
            
            
        case .failure(let error):
            print("Request failed with error: \(error)")
            }
            
            
            
            
            
        }
        Alamofire.request("http://192.168.1.3:3000?action=6&sera=1&numeActiune=Preia%20umiditate%20sol").responseString { response in switch response.result {
        case .success(let JSON):
            print("Success with JSON: \(JSON)")
            self.TextView3.text=JSON
            
            
            
            
        case .failure(let error):
            print("Request failed with error: \(error)")
            }
            
            
            
            
            
        }
    }
    
    
    
    @IBAction func Button(_ sender: Any) {
        let double2 = Double(Text1.text!)
        let val2 = String(double2! * 1000)
        Alamofire.request("http://192.168.1.3:3000?action=0&durata=" + val2 + "&sera=1&numeActiune=Stropire").responseString { response in switch response.result {
        case .success(let JSON):
            print("Success with JSON: \(JSON)")
            
            
            
            
            
        case .failure(let error):
            print("Request failed with error: \(error)")
            }
            
            
            
            
        }
    }
    

    
    
    
    @IBAction func Button2(_ sender: Any) {
       let double = Double(Text2.text!)
        let val1 = String(double! * 1000)
        Alamofire.request("http://192.168.1.3:3000?action=1&durata=" + val1 + "&sera=1&numeActiune=Aerisire").responseString { response in switch response.result {
        case .success(let JSON):
            print("Success with JSON: \(JSON)")
            
            
            
            
            
        case .failure(let error):
            print("Request failed with error: \(error)")
            }
            
            
            
            
        }
        
        
        
    }
    
    
    @IBAction func Button3(_ sender: Any) {
        let double3 = Double(Text5.text!)
        let val3 = String(double3! * 10)
        Alamofire.request("http://192.168.1.3:3000?action=2&lum=" + Text3.text! +  "&temp=" + Text4.text! + "&ums=" + val3  +  "&sera=1&numeActiune=Preia%20valori" ).responseJSON { response in
            
            
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


