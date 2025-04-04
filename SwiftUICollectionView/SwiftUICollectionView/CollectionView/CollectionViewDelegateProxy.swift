import UIKit

final class CollectionViewDelegateProxy: NSObject, UICollectionViewDelegate {
  let didScroll: (UIScrollView) -> Void
  let didSelect: (UICollectionView, IndexPath) -> Void
  
  init(didScroll: @escaping (UIScrollView) -> Void,
       didSelect: @escaping (UICollectionView, IndexPath) -> Void) {
    
    self.didScroll = didScroll
    self.didSelect = didSelect
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    didScroll(scrollView)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    didSelect(collectionView, indexPath)
  }
}
