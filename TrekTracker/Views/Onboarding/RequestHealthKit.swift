import SwiftUI
import SwiftData
import HealthKitUI

struct RequestHealthKitView: View {
    @Bindable var user: User
    @State var trigger: Bool = false
    @Environment(\.colorScheme) var colorScheme
    
    let allTypes: Set = [
        HKQuantityType(.activeEnergyBurned),
        HKQuantityType(.distanceWalkingRunning),
        HKQuantityType(.heartRate),
        HKQuantityType(.stepCount)
    ]
    
    var healthStore = HKHealthStore()

    
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
                        Text("Thank you")
                            .bold()
                            .font(.system(size: 50))
                    }
                    
                    Text("We use your health data to display accurate step counts and other important information")
                    
                    Spacer()
                    
                    
                    Button(action: home) {
                           Text("Complete")
                            .bold()
                            .foregroundStyle(.white)
                    }
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .background(colorScheme == .dark ?
                                Color("green_900") :
                                    Color("green_500")
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .healthDataAccessRequest(
                        store: healthStore,
                        readTypes: allTypes,
                        trigger: trigger) { result in
                            switch result {
                                
                                case .success(_):
                                    user.authenticatedHealthKit = true
                                case .failure(let error):
                                    // Handle the error here.
                                    print("*** An error occurred while requesting authentication: \(error) ***")
                            }
                    }
                    
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
        user.onboardingStep += 1
    }

    
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: User.self, configurations: config)
    let user = User(name: "neel")

    return RequestHealthKitView(user: user).modelContainer(container)
}


