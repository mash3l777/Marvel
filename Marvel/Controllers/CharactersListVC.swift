//
//  CharactersListVC.swift
//  Marvel
//
//  Created by مشعل المعمري on 10/08/2022.
//

import UIKit

class CharactersListVC: UIViewController {

    var limit = 20
    var offset = 0
    var arrCharacter:[Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCharactersListData()
    }

    func getCharactersListData() {
        
        api.characters.fetchCharacters(limit: limit, offset: offset, vc: self) { success, result, error in
            
            if success {
                print(result ?? "nil result")
                
                let characterDataWrapper = result as! CharacterDataWrapper
                
                self.arrCharacter = characterDataWrapper.data?.results ?? []
                
            }else{
                print(error?.userInfo["response"] ?? "nil response")

            }
        }
        
    }

}
