//
//  infoCell.swift
//  PruebaStefanini
//
//  Created by Ricardo Gonzalez on 27/07/23.
//

import UIKit

class infoCell: UITableViewCell {

    
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var subtitleLbl: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var messageLbl: UILabel!
    
    
    @IBOutlet weak var spamIcon: UIImageView!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func destacadoButton(_ sender: UIButton) {
        print ("favoritos")
        
        
        //color al seleccionar el boton
        let goldenColor = UIColor(red: 255/255, green: 215/255, blue: 0/255, alpha: 1.0)
        sender.tintColor = goldenColor
        
       
    }
    
    
    var content: SaveEmail!{
            didSet{
                setUpCell()
            }
        }
        
        func setUpCell(){
            titleLbl.text = content.sender
            subtitleLbl.text = content.affair
            timeLabel.text = content.time
            messageLbl.text = content.message
            spamIcon.isHidden = content.spam
        }
    
}
