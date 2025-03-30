//import SwiftUI
//
//struct ContentView: View {
//    typealias Item = Int
//    typealias Section = Int
//    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
//
//    @State var snapshot: Snapshot = {
//        var initialSnapshot = Snapshot()
//        initialSnapshot.appendSections([0])
//        return initialSnapshot
//    }()
//
//    var body: some View {
//
//        ZStack(alignment: .bottom) {
//            CollectionView(
//                snapshot: snapshot,
//                collectionViewLayout: collectionViewLayout,
//                cellProvider: cellProviderWithRegistration
//            )
//            .collectionViewDelegate {
//                CollectionViewDelegateProxy(didSelect: { collection, index in
//                    appendItemToCollection()
//                })
//            }
//            .padding()
//
//            Button(
//                action: {
//                    appendItemToCollection()
//                }, label: {
//                    Text("Add More Items")
//                }
//            )
//        }
//    }
//
//    let cellRegistration: UICollectionView.CellRegistration = .hosting { (idx: IndexPath, item: Item) in
//        Text("\(item)")
//    }
//    
//    func appendItemToCollection() {
//        let itemsCount = snapshot.numberOfItems(inSection: 0)
//        snapshot.appendItems([itemsCount], toSection: 0)
//    }
//}
//
//extension ContentView {
//    func collectionViewLayout() -> UICollectionViewLayout {
//        UICollectionViewFlowLayout()
//    }
//
//    func cellProviderWithRegistration(_ collectionView: UICollectionView,
//                                                    indexPath: IndexPath,
//                                                    item: Item) -> UICollectionViewCell {
//
//        collectionView.dequeueConfiguredReusableCell(
//            using: cellRegistration,
//            for: indexPath,
//            item: item
//        )
//    }
//}
