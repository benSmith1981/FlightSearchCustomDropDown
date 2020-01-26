//
//  ViewController.swift
//  TUIMobility
//
//  Created by Ben Smith on 20/01/2020.
//  Copyright © 2020 Ben Smith. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextfield: CustomSearchTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectionDataService.getItems { (status, connections) in
            print(connections)
            self.searchTextfield.connections = connections
        }
//        ConnectionDataService.getStaticJson { (status, connections) in
//            if status {
//                
//            } else {
//                print("failed to get connections")
//            }
//        } 
        // Do any additional setup after loading the view.
    }

}
