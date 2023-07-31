//
//  ViewController.swift
//  PruebaStefanini
//
//  Created by Ricardo Gonzalez on 27/07/23.
//

import UIKit
import Foundation
import SideMenu
import RealmSwift

class ViewController: UIViewController {
    
    
    var emailModel = Array(DBManagerEmail.sharedInstance.getDataFromDB())

    
    private let sideMenu = SideMenuNavigationController(rootViewController: MenuController(with: ["Destacados", "Spam", "Papelera"]))
    
    @IBOutlet weak var buscador: UITextField!
    @IBOutlet weak var emailsTable: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailsTable.register(UINib(nibName: "infoCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        sideMenu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        
        emailsTable.delegate = self
        emailsTable.dataSource = self
        
        var email = mockEmail()
        
        for i in email?.correos ?? [] {
            let s = SaveEmail()
            s.idEmail = UUID().uuidString
            
            s.sender = i.sender
            s.senderMail = i.senderMail
            s.affair = i.affair
            s.message = i.message
            s.time = i.time
            s.read = i.read
            s.outstanding = i.outstanding
            s.spam = i.spam
            
            DBManagerEmail.sharedInstance.addDataSafe(object: s) {
                print("<<\(s)")
            }
        }
       
        //emailModel = DBManagerEmail.sharedInstance.getDataFromDB()
    }
    
    
   func mockEmail() -> EmailResponse? {
       if let path = Bundle.main.path(forResource: "email", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    let decoder = JSONDecoder()
                    let emailResponse = try decoder.decode(EmailResponse.self, from: data)
            
                    return emailResponse
                } catch {
                    // handle error
                    print(error)
                    return nil
                }
            }
            return nil
        }
    
    @IBAction func menuButton(_ sender: UIButton) {
        print("Menu")
        present(sideMenu, animated: true)
    }
    
    
    
    class MenuController: UITableViewController {
        
        let menuItems: [String]
        
        init(with menuItems: [String]) {
            self.menuItems = menuItems
            super.init(nibName: nil, bundle: nil)
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return menuItems.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = menuItems[indexPath.row]
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(identifier: "PapeleraViewController") as! PapeleraViewController
            
            viewController.modalPresentationStyle = .fullScreen
            
            present(viewController, animated: true)*/
           switch indexPath.row {
            case 0:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "DestacadosViewController") as! DestacadosViewController
               viewController.modalPresentationStyle = .fullScreen
                present(viewController, animated: true)
                
            case 1:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "SpamViewController") as! SpamViewController
               viewController.modalPresentationStyle = .fullScreen
                present(viewController, animated: true)
               
               
           case 2:
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let viewController = storyboard.instantiateViewController(identifier: "PapeleraViewController") as! PapeleraViewController
               viewController.modalPresentationStyle = .fullScreen
               present(viewController, animated: true)
                
            default:
                break
                
                
            }
            
            
        }
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 70
        }
        
    }
    
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! infoCell
        
        cell.content = emailModel
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteEmail = UIContextualAction(style: .normal, title: "Borrar") { _, _, _ in
            //print("borrar email")
            guard indexPath.row < self.emailModel.count ?? 0 else { return }

            // Eliminar el elemento del array
            //self.emailModel.remove(at: indexPath.row)

            // Eliminar la celda del UITableView con animación (opcional)
            //self.emailsTable.beginUpdates()
            self.emailsTable.deleteRows(at: [indexPath], with: .automatic)
            //self.emailsTable.endUpdates()
        
           // self.emailsTable.reloadData()
            
            
            
            let itemToDelete = self.emailModel?.correos[indexPath.row]
            
            let itemToSave = SaveEmail()
            itemToSave.sender = itemToDelete?.sender ?? ""
            
            
            itemToSave.senderMail = itemToDelete?.senderMail ?? ""
            
            
            
            self.dbManEmail?.addData(object: itemToSave)

           /* let realm = try! Realm()
            try! realm.write {
                realm.add(itemToSave)
                
                
            //self.dbManEmail?.addData(object: itemToSave)
                
            }*/
            
            
            
            
        }
        
        deleteEmail.title = "Borrar"
        deleteEmail.backgroundColor = .red
        deleteEmail.image = UIImage(systemName: "trash")
        
        return UISwipeActionsConfiguration(actions: [deleteEmail])
    }*/
    
}

