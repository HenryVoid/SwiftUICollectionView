import UIKit
import SwiftUI

extension UICollectionView.CellRegistration {
  
  static func hosting<Content: View, CellItem: Hashable & Sendable>(
    content: @escaping (IndexPath, CellItem) -> Content) -> UICollectionView.CellRegistration<UICollectionViewCell, CellItem> {
      
      UICollectionView.CellRegistration { cell, indexPath, item in
        
        cell.contentConfiguration = UIHostingConfiguration {
          content(indexPath, item)
        }
      }
    }
}
