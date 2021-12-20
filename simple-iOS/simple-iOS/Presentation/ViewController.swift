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
    
    let usecase = GetDataUseCase()
    var data: [DataViewModel] = []
    var dataTemp: [DataViewModel] = []
    
    var hospitalPickerLabel: [DataViewModel] = []
    var specialPickerLabel: [DataViewModel] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        hospitalPicker()
        specializationPicker()
        tableView.register(UINib(nibName: String(describing: TableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TableViewCell.self))
        loadData()
    }
    
    func hospitalPicker(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 1
        hospitalTextField.inputView = pickerView
    }
    
    func specializationPicker(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 2
        specializationTextField.inputView = pickerView
    }
    
    
    func loadData(){
        usecase.showDataToView { dataList in
            self.data = dataList
            self.dataTemp = dataList
            self.hospitalPickerLabel = []
            self.specialPickerLabel = []
            for element in dataList {
                if !self.hospitalPickerLabel.contains(where: {$0.hospital == element.hospital }) {
                    self.hospitalPickerLabel.append(element)
                }
                if !self.specialPickerLabel.contains(where: {$0.specialization == element.specialization }) {
                    self.specialPickerLabel.append(element)
                }
            }
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataTemp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as! TableViewCell
        cell.setDataToCell(data: dataTemp[indexPath.row])
        return cell
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.hospitalTextField.text = ""
        self.specializationTextField.text = ""
        dataTemp = data.filter { searchText.isEmpty ? $0.name == $0.name  : $0.name.lowercased().contains(searchText.lowercased()) }
            tableView.reloadData()
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return hospitalPickerLabel[row].hospital
        }
        return specialPickerLabel[row].specialization
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.searchBar.text = ""
        if pickerView.tag == 1 {
            self.specializationTextField.text = ""
            self.hospitalTextField.text = hospitalPickerLabel[row].hospital
            dataTemp = data.filter { $0.hospital.lowercased().contains(hospitalPickerLabel[row].hospital.lowercased()) }
        }else{
            self.hospitalTextField.text = ""
            self.specializationTextField.text = specialPickerLabel[row].specialization
            dataTemp = data.filter { $0.specialization.lowercased().contains(specialPickerLabel[row].specialization.lowercased()) }
            
        }
        self.view.endEditing(true)
        tableView.reloadData()
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return hospitalPickerLabel.count
        }
        return specialPickerLabel.count
    }
    
    
}

