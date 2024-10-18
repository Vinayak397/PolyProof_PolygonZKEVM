pragma circom 2.0.0;

 template Multiplier2 () {  

   // User Inputs 
   signal input a;  
   signal input b;

   // Circuit Internal Inputs

   signal x;  
   signal y;  

   // Output Circuit 
   signal output q;

   //component

   component andGate = AND();
   component notGate = NOT();
   component orGate = OR();

   // Singals Operatio to AND Gate

   andGate.a <== a;
   andGate.b <== b;
   x <== andGate.out;

   // Signals Operation to Not Gate 

   notGate.in <== b;
   y <== notGate.out;

   // Getting Final Output From Logical Gates (q)

   orGate.a <== x;
   orGate.b <== y;
   q <== orGate.out;

}

template AND() {
    signal input a;
    signal input b;
    signal output out;

    out <== a*b;
}

template NOT() {
    signal input in;
    signal output out;

    out <== 1 + in - 2*in;
}

template OR() {
    signal input a;
    signal input b;
    signal output out;

    out <== a + b - a*b;

    log("Circuit Contract Complete!");
    log("Result - ", out);
}

component main = Multiplier2();