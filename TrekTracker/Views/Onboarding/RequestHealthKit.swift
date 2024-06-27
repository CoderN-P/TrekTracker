import SwiftUI
import SwiftData
import HealthKitUI

struct RequestHealthKitView: View {
    @Bindable var user: User
    @State var trigger: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var healthKitManager: HealthKitManager

    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                VStack {
                    Spacer()
                    Text("TrekTracker")
                        .bold()
                        .font(.system(size: 50))
                        .offset(y: 75)
                    ZStack {
                        
                        Image("Logo")
                            .resizable()
                            .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 300)
                .background(colorScheme == .dark ? Color("green_800") :
                                Color("green_200")
                )
                
                
                
                VStack {
                    HStack {
                        Text("Almost done")
                            .bold()
                            .font(.system(size: 50))
                    }
                    
                    Text("Please allow access to your health data")
                    
                    Spacer()
                    
                    
                    Button(action: home) {
                       Text("Allow")
                           .foregroundColor(.white)
                           .padding()
                           .frame(maxWidth: .infinity) // Make the text take full width
                           .background(colorScheme == .dark ? Color("green_900") : Color("green_500"))
                           .cornerRadius(10)
                   }
                   .frame(maxWidth: .infinity) // Make the button take full width
                    
                    
                    Spacer()
                }
                .padding(30)
                .background(colorScheme == .dark ? .black :
                        .white)
                .clipShape(.rect(
                    topLeadingRadius: 50,
                    topTrailingRadius: 50
                ))
                
            }
            .background(colorScheme == .dark ? Color("green_800") :
                            Color("green_200"))
            .ignoresSafeArea()
        }
        .onAppear() {
            if HKHealthStore.isHealthDataAvailable() {
                // Modifying the trigger initiates the health data
                // access request.
                trigger.toggle()
            }
        }
    }
    
    func home(){
        healthKitManager.requestAuthorization(user: user)
    }

    
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let user = User(name: "neel")

    return RequestHealthKitView(user: user, healthKitManager: HealthKitManager()).modelContainer(container)
}


