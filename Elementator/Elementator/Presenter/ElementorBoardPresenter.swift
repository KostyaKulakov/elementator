//
//  ElementorBoardPresenter.swift
//  Elementator
//
//  Created by Konstantin Kulakov on 02/04/2019.
//  Copyright © 2019 Konstantin Kulakov. All rights reserved.
//


import UIKit

protocol ElementorBoardPresenterProtocol {
    func getCount() -> Int
    func getInfoCellByIndex(index: Int) -> DataToView.Data?
    func showNoticeAboutCell(index: Int)
}

class ElementorBoardPresenter {
    weak var view: ElementorBoardViewProtocol?
    var data: DataToView? {
        didSet {
            self.view?.updateTableView()
        }
    }
    
    required init(view: ElementorBoardViewProtocol, model: DataToView?) {
        self.view = view
        self.data = model
    }
}

extension ElementorBoardPresenter: ElementorBoardPresenterProtocol {
    func showNoticeAboutCell(index: Int) {
        guard let model = self.data else { return }
        
        self.view?.showNotice("This id: \(index), name: \(model.view[index])")
    }
    
    func getInfoCellByIndex(index: Int) -> DataToView.Data? {
        guard let model = self.data else { return nil }
        
        let nameElement: String = model.view[index]
        
        for element in model.data {
            if element.name == nameElement {
                return element
            }
        }
        
        return nil
    }
    
    func getCount() -> Int {
        return data?.view.count ?? 0
    }
}
