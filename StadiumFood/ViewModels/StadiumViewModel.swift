//
//  StadiumViewModel.swift
//  StadiumFood
//
//  Created by 이현호 on 5/27/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import Combine

class StadiumViewModel: ObservableObject {
    @Published var stadiums: [StadiumModel] = []
    
    init() {
        Task {
            await fetchStadiums()
        }
    }
    
    // 구장데이터 가져오기
    func fetchStadiums() async {
        do {
            let snapshot = try await Firestore.firestore().collection("stadiums").order(by: "order").getDocuments()
            DispatchQueue.main.async {
                self.stadiums = snapshot.documents.compactMap { document -> StadiumModel? in
                    let id = document.documentID
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let teams = data["teams"] as? [String] ?? []
                    let destinationView = data["destinationView"] as? String ?? ""
                    let imageURL = data["imageURL"] as? String ?? ""
                    let floors = data["floors"] as? [String] ?? []
                    return StadiumModel(id: id, name: name, imageURL: imageURL, teams: teams, destinationView: destinationView, order: 0, restaurants: [], floors: floors)
                }
            }
        } catch {
            print("Error fetching stadiums: \(error.localizedDescription)")
        }
    }
    
    // 데이터 새로고침 메서드
    func reload() async {
        await fetchStadiums()
    }
    
    // 구장 뷰 이동 로직
    func destinationViewForStadium(_ stadium: StadiumModel, favoritesViewModel: FavoritesViewModel) -> AnyView {
        let viewDictionary: [String: AnyView] = [
            "JamsilView": AnyView(JamsilView().environmentObject(favoritesViewModel)),
            "GochuckView": AnyView(GochuckView().environmentObject(favoritesViewModel)),
            "WizParkView": AnyView(WizParkView().environmentObject(favoritesViewModel)),
            "LandersFieldView": AnyView(LandersFieldView().environmentObject(favoritesViewModel)),
            "EaglesParkView": AnyView(EaglesParkView().environmentObject(favoritesViewModel)),
            "LionsParkView": AnyView(LionsParkView().environmentObject(favoritesViewModel)),
            "ChampionsParkView": AnyView(ChampionsParkView().environmentObject(favoritesViewModel)),
            "NCParkView": AnyView(NCParkView().environmentObject(favoritesViewModel)),
            "SajicView": AnyView(SajicView().environmentObject(favoritesViewModel))
        ]
        
        if let view = viewDictionary[stadium.destinationView] {
            return view
        } else {
            return AnyView(Text("기본적으로 표시할 뷰입니다."))
        }
    }
}
