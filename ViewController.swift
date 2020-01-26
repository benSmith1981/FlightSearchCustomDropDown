//
//  ViewController.swift
//  TUIMobility
//
//  Created by Ben Smith on 20/01/2020.
//  Copyright © 2020 Ben Smith. All rights reserved.
//

import UIKit

protocol filterSearch: class {
    func filter(textfieldType: SearchTextField, searchText: String)
}

class ViewController: UIViewController {
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var fromSearchTextfield: CustomSearchTextField!
    @IBOutlet weak var toSearchTextfield: CustomSearchTextField!

    var connections: [Connection] = [Connection]()
    private var departureResults: [Connection] = [Connection]()
    private var destinationResults: [Connection] = [Connection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectionDataService.getItems { (status, connections) in
            print(connections)
            self.connections = connections
            self.fromSearchTextfield.filterDelegate = self
            self.toSearchTextfield.filterDelegate = self


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

extension ViewController: filterSearch {
    func filter(textfieldType: SearchTextField, searchText: String) {
        switch textfieldType {
        case SearchTextField.from:
            self.departureResults = connections.filter{ ($0.from.range(of: searchText, options: .caseInsensitive) != nil) }
            self.destinationResults = connections.filter{ ($0.from.range(of: searchText, options: .caseInsensitive) != nil) }
            self.departureResults = self.departureResults.unique { $0.from }
            fromSearchTextfield?.departureResults = self.departureResults
            fromSearchTextfield?.tableView?.reloadData()

        case SearchTextField.to:
            print("filter the destination")
            self.destinationResults = self.destinationResults.filter{ ($0.to.range(of: searchText, options: .caseInsensitive) != nil) }
            toSearchTextfield?.destinationResults = self.destinationResults
            toSearchTextfield.tableView?.reloadData()

        }
        
    }
}
