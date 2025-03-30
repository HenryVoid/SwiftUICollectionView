import UIKit
import SwiftUI

extension UICollectionView.CellRegistration {
  
  static func hosting<Content: View, Item: Hashable & Sendable>(
    content: @escaping (IndexPath, Item) -> Content) -> UICollectionView.CellRegistration<UICollectionViewCell, Item> {
      
      UICollectionView.CellRegistration { cell, indexPath, item in
        
        cell.contentConfiguration = UIHostingConfiguration {
          content(indexPath, item)
        }
      }
    }
}
