






/* PROJECT 1:
 
 A (10 points) Add Actions to the text fields so that they can update coefficients
 C (10 points) Have the coefficient labels initialize on launch
 D (40 points) Move all 'Model' functionality out of VC and into a new LPFCalculator class
   i) Controller should not HOLD any coefficients or UI values; its only job is to correctly pass this information back and forth between the View and the Model.
  ii) Coefficients could be stored in an NSArray or Dictionary
 E (40 points) Create an HPFCalculator class, and add a switch to alternate between calculating HPF and LPF coefficients.
 
 Extra Credit: (20 points) Create a Delegate Method for the Model to notify the Controller of coefficient changes
   i) Note: this should be the only line of communication FROM Model TO Controller

 
 
 Basically, the flow of information is such:
 
 
 UI object 1<-\
               \  ----------------  (Msg) ---------------
 UI object 2<--->| ViewController |<---->| LPFCalculator |
               /  ----------------       ---------------
 UI object 3<-/
        .
        .
 */