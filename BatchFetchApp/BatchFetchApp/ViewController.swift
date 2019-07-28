//
//  ViewController.swift
//  BatchFetchApp
//
//  Created by dmason on 7/27/19.
//  Copyright © 2019 dmason. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController, UITableViewDataSource
{
    var sessionManager : SessionManager = SessionManager()
    var items : Array<NameModel> = []
    var fetching: Bool = false
    @IBOutlet weak var _tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.sessionManager.delegate.taskDidReceiveChallengeWithCompletion = { (_, _, challenge, completionHandler) -> Void in
            if challenge.protectionSpace.host == "localhost" {
                completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
            }
            else {
                completionHandler(.performDefaultHandling, nil)
            }
        }
        
        fetchNames(offset: 0)
    }
    
    func fetchNames(offset: Int) -> Void
    {
        self.fetching = true
        self.sessionManager.request("https://localhost:5001/api/names/fetch", method: .get, parameters: [ "offset": offset ])
            .responseArray { (response: DataResponse<[NameModel]>) in
            DispatchQueue.main.async {
                let values = response.result.value!
                self.items = self.items + values
                self.fetching = false
                self._tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("number of rows: \(100) in section: \(section)")
        return items.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        print("rendering cell at :\(indexPath.row) for section: \(indexPath.section)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = "\(item.firstName!) \(item.lastName!)"
        
        let delta = items.count - indexPath.row
        print("Rendering cell at :\(indexPath.row) for seciton: \(indexPath.section). Array count is: \(items.count) with a delta of: \(delta)")
        if self.fetching != true && delta < 25 {
            fetchNames(offset: items.count)
        }
        
        return cell
    }
}

