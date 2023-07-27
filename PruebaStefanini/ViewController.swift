//
//  ViewController.swift
//  PruebaStefanini
//
//  Created by Ricardo Gonzalez on 27/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    var nameLabel = ["Juan Perez", "Alan Perez", "Jose Perez", "Andres Perez", "Pedro Perez", "Daniel Perez"]

    @IBOutlet weak var buscador: UITextField!
    @IBOutlet weak var emailsTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailsTable.delegate = self
        emailsTable.dataSource = self
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = nameLabel[indexPath.row]
        
        return cell
    }
    
    
}
