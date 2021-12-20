//
//  ViewController.swift
//  simple-iOS
//
//  Created by Tommy on 20/12/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private(set) var searchBar: UISearchBar!
    @IBOutlet private(set) var hospitalTextField: UITextField!
    @IBOutlet private(set) var hospitalButton: UIButton!
    @IBOutlet private(set) var specializationTextField: UITextField!
    @IBOutlet private(set) var specializationButton: UIButton!
    @IBOutlet private(set) var tableView: UITableView!
    @IBOutlet private(set) var pickerView: UIPickerView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.isHidden = true
        tableView.register(UINib(nibName: String(describing: TableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TableViewCell.self))
    }
}


extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as! TableViewCell
        return cell
    }
    
    
}

