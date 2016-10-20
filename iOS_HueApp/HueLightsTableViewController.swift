//
//  HueLightsTableViewController.swift
//  iOS_HueApp
//
//  Created by Thomas Woerdeman on 18/10/2016.
//  Copyright © 2016 Thomas Woerdeman. All rights reserved.
//

import UIKit


class HueLightsTableViewController: UITableViewController {
    var lights = [Light]()
    
    override func viewDidLoad() {
        
        JSONHelper.sharedInstance.recieveLights(completionHandler:{ responseObject, error in
            
                            if let json = responseObject as? Dictionary<String, Any> {
                                for field in json {
                                    let light : Light! = Light()
            
                                    if let value = field.value as? Dictionary<String, Any>{
            
                                        light?.lightId = field.key
            
                                        if let state = value["state"] as? Dictionary<String, Any>{
            
                                            if let on = state["on"] as? Bool {
                                                light?.isOn = on
                                            }
            
                                            if let hue = state["hue"] as? Int {
                                                light?.hue = hue
                                            }
            
                                            if let bri = state["bri"] as? Int {
                                                light?.bri = bri
                                            }
            
                                            if let sat = state["sat"] as? Int {
                                                light?.sat = sat
                                            }
            
            
                                            if let lightName = value["name"] as? String {
                                                light?.lightName = lightName
                                            }
            
            
            
                                        }
            
                                    }
                                    self.lights.append(light)
                                }
                                self.tableView.reloadData()
            
                            }
        
        
        } )
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lights.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HueLightCell", for: indexPath)
        
        cell.textLabel?.text = lights[indexPath.row].lightName
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue"{
            if let destination = segue.destination as? DetailViewController {
                
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    
                    let light = lights[(indexPath as NSIndexPath).row]
                    
                    destination.light = light
                }
            }
            
        }
    }

}
