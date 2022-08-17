//
//  AddSymptomVC.swift
//  BioGenesis
//
//  Created by Martin on 13/07/2022.
//

import UIKit
import Amplify
import AWSCognitoAuthPlugin
import AWSAPIPlugin

class AddSymptomVC: UIViewController {
    
    //MARK: - id(string), label(string)
    var potentialSymptomsJson: SearchResponse = []

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
        searchResultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "symptomCell")
        
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
        
        self.potentialSymptomsJson = []
        
        if phrase == "" {
            return
        }
        
        let userAge: String = "30"
        let userSex: String = "female"
        let maxResults: String = "10"
        
        let API_Search_Request = "https://api.infermedica.com/v3/search?phrase="
        + phrase
        + "&age.value="
        + userAge
        + "&sex="
        + userSex
        + "&max_results="
        + maxResults
        + "&types=symptom"
        
        let symptomSearchURL = URL(string: API_Search_Request)
        
        if let unwrappedURL = symptomSearchURL {
            var request = URLRequest(url: unwrappedURL)
            
            //MARK: PRIVATE KEY AND ID
            request.addValue("5abc846c8492636c2622a630e45b67b6", forHTTPHeaderField: "App-Key")
            request.addValue("29457438", forHTTPHeaderField: "App-Id")
            
            // Make your request and handle the response
            let dataTask = URLSession.shared.dataTask(with: request, completionHandler: { [self] data, response, error in
                
                guard let data = data, error == nil else {
                    print("Infermedica Symptom Search Request went wrong")
                    return
                }
                
                var result: SearchResponse?
                
                do {
                    result = try JSONDecoder().decode(SearchResponse.self, from: data)
                }
                catch {
                    print("failed to convert \(error.localizedDescription)")
                }
                
                guard let json = result else {
                    return
                }
                
                //MARK: PRIVATE KEY AND ID
                self.potentialSymptomsJson = json
                
                DispatchQueue.main.async {

                     self.searchResultsTableView.reloadData()

                }

            })
            
            dataTask.resume()
        }
    }

}


extension AddSymptomVC: UITextFieldDelegate {
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


extension AddSymptomVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "symptomCell")
        cell.textLabel?.text = potentialSymptomsJson[indexPath.row].label
        cell.detailTextLabel?.text = potentialSymptomsJson[indexPath.row].id
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
        return potentialSymptomsJson.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}


extension AddSymptomVC {
    
    func searchSymptoms_test(outputJson searchResponse: SearchResponse?) {
        print("-------------------------------------")
        print("-----Start Symptom Search (TEST)-----")
        print("-------------------------------------")
        print("Search Results(Json):")
        print(potentialSymptomsJson)
        print("------------------------------------")
        print("---------End Search (TEST)----------")
        print("------------------------------------")
    }
    
}
