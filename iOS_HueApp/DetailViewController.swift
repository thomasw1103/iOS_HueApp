//
//  DetailViewController.swift
//  iOS_HueApp
//
//  Created by Frank Molengraaf on 19/10/2016.
//  Copyright © 2016 Frank Molengraaf. All rights reserved.
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
        
        hueSlider.minimumValue = 0
        hueSlider.maximumValue = 65535
        
        satSlider.minimumValue = 0
        satSlider.maximumValue = 255
        
        briSlider.minimumValue = 0
        briSlider.maximumValue = 255
        
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
            light?.isOn = switchState.isOn
        JSONHelper.sharedInstance.putState(lightObj: light!)
    }
    @IBAction func hueSliderChanged(_ sender: AnyObject) {
        light?.hue = Int(round(hueSlider.value))
        JSONHelper.sharedInstance.putState(lightObj: light!)
        
    }
    
    @IBAction func satSliderChanged(_ sender: AnyObject) {
        light?.sat = Int(round(satSlider.value))
        JSONHelper.sharedInstance.putState(lightObj: light!)
    }
    
    @IBAction func briSliderChanged(_ sender: AnyObject) {
        light?.bri = Int(round(briSlider.value))
        JSONHelper.sharedInstance.putState(lightObj: light!)
    }
}
