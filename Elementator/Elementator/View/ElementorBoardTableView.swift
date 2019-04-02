//
//  ElementorBoardTableView.swift
//  Elementator
//
//  Created by Konstantin Kulakov on 02/04/2019.
//  Copyright © 2019 Konstantin Kulakov. All rights reserved.
//

import UIKit

protocol ElementorBoardViewProtocol: class {
    func showNotice(_ msg: String)
    func updateTableView()
}

class ElementorBoardTableView: UIViewController {
    var presenter: ElementorBoardPresenter?
    var data: DataToView?
    @IBOutlet weak var dataView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataView.dataSource = self
        self.dataView.delegate = self
        
        presenter = ElementorBoardPresenter(view: self, model: self.data)
    }
}

extension ElementorBoardTableView: ElementorBoardViewProtocol {
    func updateTableView() {
        self.dataView.reloadData()
    }
}

extension ElementorBoardTableView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.getCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dataView.dequeueReusableCell(withReuseIdentifier: "elementorBoardCell", for: indexPath) as? ElementorBoardViewCell else { fatalError() }
        
        let data = presenter?.getInfoCellByIndex(index: indexPath.row)
        
        guard let currentInfo = data else { return cell }
        
        cell.hideAll()
        
        switch currentInfo.name {
        case "hz":
            cell.labelText?.isHidden = false
            cell.labelText?.text = currentInfo.data.text
            break
            
        case "picture":
            cell.photo.isHidden = false
            cell.labelText?.isHidden = false
            cell.labelText?.text = currentInfo.data.text
            
            guard let urlPath = currentInfo.data.url else { break }
            
            cell.photo.downloaded(from: urlPath)
            
            break
            
        case "selector":
            cell.selector.isHidden = false
            
            cell.selector.removeAllSegments()
            
            guard let segments = currentInfo.data.variants,
                let selectedSegmentIndex = currentInfo.data.selectedId else { break }
            
            for segment in segments {
                cell.selector.insertSegment(withTitle: segment.text, at: segment.id, animated: true)
            }
            
            cell.selector.selectedSegmentIndex = selectedSegmentIndex
            
            break
            
        default:
            break
        }
        
        cell.layoutIfNeeded()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showNoticeAboutCell(index: indexPath.row)
    }
}
