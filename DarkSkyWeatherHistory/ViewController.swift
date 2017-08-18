//
//  ViewController.swift
//  DarkSkyWeatherHistory
//
//  Created by Taylor Mott on 17-Aug-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    func updateViews(with weather: Weather?) {
        if let weather = weather {
            iconLabel.text = weather.iconName
            summaryLabel.text = weather.summary
            
            let formatter = MeasurementFormatter()
            formatter.locale = Locale.current
            formatter.unitStyle = .medium
            tempLabel.text = formatter.string(from: weather.temp)
        } else {
            iconLabel.text = ""
            summaryLabel.text = ""
            tempLabel.text = ""
        }
    }
    
    
    @IBAction func fetchButtonTapped() {
        
        let zip = zipTextField.text ?? ""
        
        WeatherController.fetchWeather(at: zip, at: datePicker.date) { (weather: Weather?) in
            DispatchQueue.main.async {
                if weather == nil {
                    print("NIL!")
                }
                self.updateViews(with: weather)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateViews(with: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

