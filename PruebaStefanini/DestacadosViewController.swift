//
//  DestacadosViewController.swift
//  PruebaStefanini
//
//  Created by Ricardo Gonzalez on 31/07/23.
//

import UIKit

class DestacadosViewController: UIViewController {

    
    var emailModel = DBManagerEmail.sharedInstance.getDataFromDB()
    
    @IBOutlet weak var destacadosTable: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        destacadosTable.register(UINib(nibName: "infoCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        destacadosTable.delegate = self
        destacadosTable.dataSource = self
        
        
    }
    

    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    

}

extension DestacadosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! infoCell
        
        //cell.delegate = self
        
        cell.titleLbl.text = emailModel[indexPath.row].sender
        cell.subtitleLbl.text = emailModel[indexPath.row].affair
        cell.timeLabel.text = emailModel[indexPath.row].time
        cell.messageLbl.text = emailModel[indexPath.row].message
        
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteEmail = UIContextualAction(style: .normal, title: "Borrar") { _, _, _ in
            //print("borrar email")
            guard indexPath.row < self.emailModel?.count ?? 0 else { return }

            // Eliminar el elemento del array
            self.emailModel?.correos.remove(at: indexPath.row)

            // Eliminar la celda del UITableView con animación (opcional)
            //self.emailsTable.beginUpdates()
            self.emailsTable.deleteRows(at: [indexPath], with: .automatic)
            //self.emailsTable.endUpdates()
        
           // self.emailsTable.reloadData()
        }
        
        deleteEmail.title = "Borrar"
        deleteEmail.backgroundColor = .red
        deleteEmail.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteEmail])
    }*/
    
    
    
}


