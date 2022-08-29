//
//  AddProtocolVC.swift
//  BioGenesis
//
//  Created by Martin on 13/07/2022.
//

import UIKit

class AddProtocolVC: UIViewController {
    
    //MARK: - id(string), label(string)
    var drugSearchJson: DrugBankResult = []

    //MARK: Elements
    var searchResultsTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    func setupScreen() {
        
        //MARK: Top View - Search Bar & Back Buttom
        
        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 20, y: 50, width: 30, height: 30)
        backBtn.backgroundColor = .black
        backBtn.addTarget(self, action: #selector(backBtnPressed(_:)), for: .touchUpInside)
        
        view.addSubview(backBtn)
        
        let searchBox = UIView()
        searchBox.frame = CGRect(x: 20, y: 80, width: screenSize.width - 40, height: 50)
        searchBox.backgroundColor = .red
        view.addSubview(searchBox)
        
        let searchTextField = UITextField()
        searchTextField.frame = CGRect(x: 0, y: 0, width: searchBox.frame.width, height: searchBox.frame.height)
        searchTextField.addTarget(self, action: #selector(textFieldEditingDidChange), for: UIControl.Event.editingChanged)
        searchTextField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        searchTextField.tintColor = mainColor
        searchTextField.delegate = self
        
        searchBox.addSubview(searchTextField)
        
//        searchTextField.keyboardAppearance = .dark
        searchTextField.keyboardType = .alphabet
        
        
        //Table View - Shows Search Results
        // -------------------------
        
        searchResultsTableView.frame = CGRect(x: 0, y: 135, width: view.frame.width, height: view.frame.height - 105)
        searchResultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "protocolCell")
        
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        
        searchResultsTableView.tag = 5
        searchResultsTableView.rowHeight = 40
        
        view.addSubview(searchResultsTableView)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc func textFieldEditingDidChange(sender: UITextField) {
        performSearch(from: sender.text ?? "")
    }
    
    func performSearch(from phrase: String) {
        
        self.drugSearchJson = []
        
        if phrase == "" {
            return
        }
        
        let maxResults: String = "15"
        
        let API_Search_Request = "https://api.drugbank.com/v1/product_concepts?q="
        + phrase
        + "&hit_details=false&per_page="
        + maxResults
        + "&page=1"
        
        let symptomSearchURL = URL(string: API_Search_Request)
        
        if let unwrappedURL = symptomSearchURL {
            var request = URLRequest(url: unwrappedURL)
            
            //MARK: PRIVATE KEY AND ID
            request.addValue("ec67a5ccfbbb565fa3f95810b628666a", forHTTPHeaderField: "Authorization")
            
            // Make your request and handle the response
            let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { [self] data, response, error in
                
                guard let data = data, error == nil else {
                    print("DrugBank Search Request went wrong")
                    return
                }
                
                var result: DrugBankResult?
                print(data)
                do {
                    result = try JSONDecoder().decode(DrugBankResult.self, from: data)
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                
                guard let json = result else {
                    return
                }
                
                //MARK: PRIVATE KEY AND ID
                self.drugSearchJson = json
                
                DispatchQueue.main.async {

                     self.searchResultsTableView.reloadData()

                }

            })
            
            dataTask.resume()
        }
    }

}


extension AddProtocolVC: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        performSearch()
//        view.endEditing(true)
//        return true
//    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchResultsTableView.reloadData()
        return true
    }
}


extension AddProtocolVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "protocolCell")
        cell.textLabel?.text = drugSearchJson[indexPath.row].name
        cell.detailTextLabel?.text = drugSearchJson[indexPath.row].drugbankPcid
        cell.textLabel?.font = UIFont(name: "Mont-Regular", size: 17)
        cell.textLabel?.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        cell.detailTextLabel?.font = UIFont(name: "Mont-Light", size: 12)
        cell.detailTextLabel?.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    
        cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drugSearchJson.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ///Add Later
//        if indexPath.row == 0 {
//            isSelectingLocation = true
//            changeLocationBtn.isHidden = false
//            animateTableView(shouldShow: false)
//        } else {
//            if matchingItems == [] {
//
//            } else {
//                let currentCoordinate = manager.location?.coordinate
//
//                locationTextField.text = tableView.cellForRow(at: indexPath)?.textLabel?.text
//
//                let selectedMapItem = matchingItems[indexPath.row - 1]
//
//                dropPinFor(placemark: selectedMapItem.placemark)
//
//                animateTableView(shouldShow: false)
//            }
//
//        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}


extension AddProtocolVC {
    
    func searchProtocols_test(outputJson searchResponse: DrugBankResult?) {
        print("-------------------------------------")
        print("-----Start Protocol Search (TEST)----")
        print("-------------------------------------")
        print("Search Results(Json):")
        print(drugSearchJson)
        print("------------------------------------")
        print("---------End Search (TEST)----------")
        print("------------------------------------")
    }
    
}
