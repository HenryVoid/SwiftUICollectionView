
import SwiftUI

struct ContentView: View {
  typealias Item = Int
  typealias Section = Int
  typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
  
  @State var snapshot: Snapshot = {
    var initialSnapshot = Snapshot()
    initialSnapshot.appendSections([0])
    return initialSnapshot
  }()
  
  var body: some View {
    
    ZStack(alignment: .bottom) {
      CollectionView(
        snapshot: snapshot,
        collectionViewLayout: collectionViewLayout,
        configuration: collectionViewConfiguration,
        cellProvider: cellProvider,
        supplementaryViewProvider: supplementaryProvider
      )
      .padding()
      
      Button(
        action: {
          let itemsCount = snapshot.numberOfItems(inSection: 0)
          snapshot.appendItems([itemsCount + 1], toSection: 0)
        }, label: {
          Text("Add More Items")
        }
      )
    }
  }
}


extension ContentView {
  func collectionViewLayout() -> UICollectionViewLayout {
    UICollectionViewFlowLayout()
  }
  
  func collectionViewConfiguration(_ collectionView: UICollectionView) {
    collectionView.register(
      UICollectionViewCell.self,
      forCellWithReuseIdentifier: "CellReuseId"
    )
    
    collectionView.register(
      UICollectionReusableView.self,
      forSupplementaryViewOfKind: "KindOfHeader",
      withReuseIdentifier: "SupplementaryReuseId"
    )
  }
  
  func cellProvider(_ collectionView: UICollectionView,
                    indexPath: IndexPath,
                    item: Item) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "CellReuseId",
      for: indexPath
    )
    
    cell.backgroundColor = .red
    return cell
  }
  
  
  func supplementaryProvider(_ collectionView: UICollectionView,
                             elementKind: String,
                             indexPath: IndexPath) -> UICollectionReusableView {
    
    collectionView.dequeueReusableSupplementaryView(
      ofKind: elementKind,
      withReuseIdentifier: "SupplementaryReuseId",
      for: indexPath
    )
  }
}
