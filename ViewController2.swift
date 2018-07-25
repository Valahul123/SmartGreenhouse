//
//  ViewController2.swift
//  Green
//
//  Created by Cisar Eduard on 25/07/2018.
//  Copyright © 2018 Cisar Eduard. All rights reserved.
//

import UIKit
import Alamofire
import SwiftCharts

class ViewController2: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var chartView:LineChart!
    override func viewDidLoad() {
        
        super.viewDidLoad()
     /*
        let chartConfig = ChartConfigXY(
            xAxisConfig:ChartAxisConfig(from: 0, to: 12, by: 2),
            yAxisConfig: ChartAxisConfig(from: 0, to: 12, by: 2)
        )
        
        let frame = CGRect(x: 0, y: 100, width: self.view.frame.width-20, height: 300)
        
        let chart = LineChart(
            frame: frame,
            chartConfig: chartConfig,
            xTitle: "",
            yTitle: "",
            lines: [
                (chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.red),
                (chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blue)
            ]
        )
        
        self.view.addSubview(chart.view)
        self.chartView = chart
 */
        // Do any additional setup after loading the view.
        Alamofire.request("http://192.168.1.3:3000/logs").responseString { response in switch response.result {
        case .success(let JSON):
            print("Success with JSON: \(JSON)")
            self.textView.text=JSON
            
            
            
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
