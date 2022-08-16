//
//  CharacterDetailsVC.swift
//  Marvel
//
//  Created by مشعل المعمري on 16/08/2022.
//

import UIKit
import AlamofireImage

class CharacterDetailsVC: UIViewController {

    @IBOutlet weak var imgCharacter: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var comics: ComicsDetails?
    var imagePath: String?
    var characterName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = characterName
        let imageURL = URL(string:imagePath ?? "" )
        imgCharacter.af.setImage(withURL: imageURL!, placeholderImage: UIImage(named: "placeholder"))

        tableView.reloadData()
    }



}


extension CharacterDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = comics?.items?[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        guard let url = comics?.items?[indexPath.row].resourceURI else {return}
        //appProperties.showWepPage(vc:self , strURL: url)
    }
    
    
}
