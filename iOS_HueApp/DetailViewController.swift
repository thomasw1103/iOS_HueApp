//
//  DetailViewController.swift
//  iOS_HueApp
//
//  Created by Thomas Woerdeman on 19/10/2016.
//  Copyright © 2016 Thomas Woerdeman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var light : Light?
    
    @IBOutlet weak var lampNameLabel: UILabel!
    @IBOutlet weak var isOnSwitch: UISwitch!
    @IBOutlet weak var hueSlider: UISlider!
    @IBOutlet weak var satSlider: UISlider!
    @IBOutlet weak var briSlider: UISlider!
    
    override func viewDidLoad() {
        
        lampNameLabel.text = light?.lightName
        
        isOnSwitch.isOn = (light?.isOn)!
        isOnSwitch.addTarget(self, action: #selector(DetailViewController.stateChanged), for: UIControlEvents.valueChanged)

        
        let hueVal : Float = Float(Int((light?.hue)!))
        hueSlider.setValue(hueVal, animated: true)
        
        let briVal : Float = Float(Int((light?.bri)!))
        briSlider.setValue(briVal, animated: true)
        
        let satVal : Float = Float(Int((light?.sat)!))
        satSlider.setValue(satVal, animated: true)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.isOn {
            light!.isOn = true
        } else {
            light!.isOn = false
        }
        JSONHelper.sharedInstance.putState(lightObj: light!)
        
    }
}
