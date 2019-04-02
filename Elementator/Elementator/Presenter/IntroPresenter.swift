//
//  IntroPresenter.swift
//  Elementator
//
//  Created by Konstantin Kulakov on 01/04/2019.
//  Copyright © 2019 Konstantin Kulakov. All rights reserved.
//

import UIKit

protocol IntroPresenterProtocol {
    func handleJson(url: String)
}

class IntroPresenter {
    weak var view: IntroViewProtocol?
    var dataToView: DataToView?
    
    required init(view: IntroViewProtocol) {
        self.view = view
    }
    
}

extension IntroPresenter: IntroPresenterProtocol {
    func handleJson(url: String) {
        // MARK: MAKE FUNCTION TO HANDLE JSON
        guard let view = self.view else { return }
        
        if url.isEmpty {
            view.showNotice("Your url is empty")
        }
        
        Server.getDataToView(url: url) { result, isSuccess in
            guard let data = result else { view.showNotice("Server parse error!"); return }
            self.dataToView = data
            view.segueToElementor()
        }
    }
}
