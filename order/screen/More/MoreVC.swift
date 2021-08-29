//
//  MoreVC.swift
//  order
//
//  Created by hany karam on 8/27/21.
//

import UIKit

class MoreVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    static let cellIdentifierTableViewCell = "MoreTableViewCell"
    let items = ["Edit Profile","Change Language","Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: MoreVC.cellIdentifierTableViewCell, bundle: nil), forCellReuseIdentifier:  MoreVC.cellIdentifierTableViewCell)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoreVC.cellIdentifierTableViewCell, for: indexPath) as! MoreTableViewCell
        cell.name.text = items[indexPath.row]
        return cell
        
    }
    
}
