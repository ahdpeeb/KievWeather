//
//  UICollectionView + Extension.swift
//  Caledonia
//
//  Created by Nikola Andriiev on 2/23/17.
//  Copyright © 2017 iosDeveloper. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(cls: T.Type) {
        let name = String(describing: cls.self)
        let cell = UINib.nibName(name)
        self.register(cell, forCellWithReuseIdentifier: name)
    }
    
    func dequeueCell<T>(cls: T.Type, indexPath path: IndexPath) -> T? {
        let clsString = String(describing: T.self)
        return self.dequeueReusableCell(withReuseIdentifier: clsString, for: path) as? T
    }
    
    func cell<T>(path: IndexPath) -> T? {
        return self.cellForItem(at: path) as? T
    }
    
    func regiter<T: UICollectionReusableView>(reusable: T.Type, ofKind kind: String) {
        let name = String(describing: reusable.self)
        let reusableView = UINib.nibName(name)
        self.register(reusableView, forSupplementaryViewOfKind: kind, withReuseIdentifier: name)
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(cls: T.Type, path: IndexPath, kind: String) -> T?  {
        let clsString = String(describing: T.self)
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: clsString, for: path) as? T
    }
}
