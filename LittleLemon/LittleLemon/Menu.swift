//
//  Menu.swift
//  LittleLemon
//
//  Created by Timmy Lau on 2024-12-22.
//

import SwiftUI


struct Menu: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext //core data viewcontext
    @State private var menuItems: [MenuItem] = []
    
    @State private var searchText = ""
    
     var body: some View {
        VStack{
            
            HStack(alignment: .center){
                Image("Logo")
//                Spacer()
                Image("Profile")
                    .resizable()
                    .frame(width: 50, height: 50,alignment: .leading)
                    
            }
            .padding()
            
            
                
            VStack (alignment: .leading, spacing: 10){
                Text("Little Lemon")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.llYellow)
                Text("Vancouver")
                    .foregroundStyle(Color.llMenuText)
                    .bold()

                HStack {
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .foregroundStyle(Color.llMenuText)
                    Image("Hero image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 50))                }
            }
            .padding()
            .background(Color.llGreen)
            
          
   
            TextField("Search Menu", text: $searchText)
 
            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List{
                    ForEach(dishes, id: \.self) { dish in
                        HStack(){
                            Text("\(dish.title ?? "")\n $\(dish.price ?? "")")
                                .font(.headline)
 
                            Spacer()
                            // AsyncImage for the dish image
                            if let imageUrl = URL(string: dish.image ?? "") {
                                AsyncImage(url: imageUrl) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView() // Placeholder while loading
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 80, height: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    case .failure:
                                        Image(systemName: "photo") // Fallback image
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .frame(width: 100, height: 50, alignment: .trailing)
                            }
                        }
                        
                    }
                }
            }
            
        }
        .listStyle(.plain)
        .onAppear(perform: {
            getMenuData()
        })
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true) // No filtering
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }

    
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
    }

    
    func getMenuData() {
        // Clear existing Dish data before saving new items, it already knows its dish entity
        PersistenceController.shared.clear()
        
        
        // Define the server URL
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        
        // Create a URL object
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Create a URLRequest
        let request = URLRequest(url: url)
        
        // Fetch data from the server
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle errors
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }

//            print("The data \(data)")
            
            // Safely unwrap the received data
            if let data = data {
                print("Raw JSON: \(String(data: data, encoding: .utf8) ?? "Invalid JSON")")

                let decoder = JSONDecoder()
                if let decodedMenuList = try? decoder.decode(MenuList.self, from: data) {
                    
                    print("Decoded menu: \(decodedMenuList)")

                    
                    // Update menuItems state variable for UI
                    DispatchQueue.main.async {
                        self.menuItems = decodedMenuList.menu
                    }
                    
                    // Save decoded menu items to Core Data
                    decodedMenuList.menu.forEach { menuItem in
                        let dish = Dish(context: viewContext) // Initialize a new Dish instance
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                    }
                    
                    // Save to Core Data
                    try? viewContext.save()
                } else {
                    print("Failed to decode data")
                }
            } else {
                print("No data received")
            }
        }
        
        // Start the task
        task.resume()
    }
    
    //    func getMenuData(){
    //        guard let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/littleLemonSimpleMenu.json") else{
    //            print("Invalid URL")
    //            return
    //        }
    //        // Step 2.3: Create a URLRequest
    //           let request = URLRequest(url: url)
    //
    //        // Step 2.4: Fetch data from server using URLSession
    //                let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //                    // Handle errors
    //                    if let error = error {
    //                        print("Error fetching data: \(error.localizedDescription)")
    //                        return
    //                    }
    //
    //                    // Ensure valid data
    //                    guard let data = data else {
    //                        print("No data received")
    //                        return
    //                    }
    //
    //                    // Decode JSON into MenuList
    //                    do {
    //                        let decodedData = try JSONDecoder().decode(MenuList.self, from: data)
    //                        DispatchQueue.main.async {
    //                            self.menuItems = decodedData.menu
    //                        }
    //                    } catch {
    //                        print("Error decoding data: \(error.localizedDescription)")
    //                    }
    //                }
    //
    //                // Step 2.5: Start the task
    //                task.resume()
    //
    //
    //    }
}


#Preview {
    Menu()
}
