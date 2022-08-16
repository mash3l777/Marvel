//
//  CharactersListVC.swift
//  Marvel
//
//  Created by مشعل المعمري on 10/08/2022.
//

import UIKit
import AlamofireImage

class CharactersListVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblAttributionText: UILabel!
    
    var limit = 20
    var offset = 0
    var characterDataWrapper: CharacterDataWrapper?
    var arrCharacter:[Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
           flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
         }

        
        registerCollectionViewCells()
        getCharactersListData()
    }
    
    func registerCollectionViewCells() {
        
        collectionView.register(UINib(nibName:"CharacterCell", bundle: nil), forCellWithReuseIdentifier: "CharacterCell")
    }

    func getCharactersListData() {
        
        api.characters.fetchCharacters(limit: limit, offset: offset, vc: self) { success, result, error in
            
            if success {
                print(result ?? "nil result")
                
                self.characterDataWrapper = (result as! CharacterDataWrapper)
                
                self.arrCharacter = self.characterDataWrapper?.data?.results ?? []
//                self.limit = characterDataWrapper.data?.total ?? 20
//                self.offset = characterDataWrapper.data?.offset ?? 0
                self.lblAttributionText.text = self.characterDataWrapper?.attributionText
                
                DispatchQueue.main.async {
                self.collectionView.reloadData()
                }
                
            }else{
                print(error?.userInfo["response"] ?? "nil response")

            }
        }
        
    }

}





extension CharactersListVC: UICollectionViewDelegate, UICollectionViewDataSource, CharacterCellDelegate {

    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterDataWrapper?.data?.count ?? 0
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath) as! CharacterCell

        let imagePath = "\(arrCharacter[indexPath.row].thumbnail?.path ?? "").\(arrCharacter[indexPath.row].thumbnail?.thumbnailExtension ?? "")"
        
            let imageURL = URL(string:imagePath)
            cell.imgMain.af.setImage(withURL:imageURL!, placeholderImage: UIImage(named: "placeholder"))

        
        cell.lblTitle.text = arrCharacter[indexPath.row].name
        cell.lblSubtitle.text = "\(arrCharacter[indexPath.row].id ?? 0)"
        
        cell.delegate = self
        cell.indexPath = indexPath
        if (arrCharacter[indexPath.row].urls?.first(where: { $0.type == .wiki })) != nil {
            
            cell.btnURL.isHidden = false
            
        }else {
            cell.btnURL.isHidden = true

        }
        
        return cell
        
    }
    
    func rowCell(_ characterCell: CharacterCell, didTapURLButton indexPath: IndexPath) {
        guard let urlDetails = arrCharacter[indexPath.row].urls?.first(where: { $0.type == .wiki }) else {return}
        appProperties.showWepPage(vc: self, strURL: urlDetails.url ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CharacterDetailsVC()
        
        let imagePath = "\(arrCharacter[indexPath.row].thumbnail?.path ?? "").\(arrCharacter[indexPath.row].thumbnail?.thumbnailExtension ?? "")"
        
        vc.imagePath = imagePath
        
        vc.characterName = arrCharacter[indexPath.row].name ?? ""
        
        vc.comics = arrCharacter[indexPath.row].comics
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

