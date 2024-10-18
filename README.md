# Project Introduction: Polygon ZKEVM

This repository provides an overview of a custom zero-knowledge circuit implemented using the Circom language. The circuit, named Multiplier2, demonstrates how to construct logic gates and connect them to perform custom computations. It allows the generation of zero-knowledge proofs for specific calculations while keeping input values private.

## Circuit Implementation 
<img width="353" alt="circuit-photo" src="https://github.com/user-attachments/assets/8ce9dad8-c866-446c-83ab-300039acd598">

The circuit processes two input signals, A and B, which act as the operands for the calculation. It employs three separate logic gates—AND, NOT, and OR—each implemented as unique templates. The AND gate produces an intermediate signal, X, while the NOT gate generates another intermediate signal, Y. These intermediate signals are then used as inputs to the OR gate, which produces the final output signal, Q.

## Introduction To Circom 

Circom is a domain-specific language designed for creating arithmetic circuits that are used in zero-knowledge proofs (ZKPs). It allows developers to define custom computational logic that can be compiled into circuits for use in zk-SNARKs (Zero-Knowledge Succinct Non-Interactive Arguments of Knowledge) or zk-STARKs (Zero-Knowledge Scalable Transparent Arguments of Knowledge).

With Circom, developers can build circuits that verify computations without revealing the underlying data, ensuring privacy while proving that certain calculations have been performed correctly. Circom's syntax and structure are tailored for expressing constraints and relationships between inputs, making it ideal for designing privacy-preserving applications such as decentralized finance (DeFi) protocols, identity verification, and secure voting systems. It is often paired with tools like SnarkJS to generate and verify proofs.

## ZKSnarks Circuit Explanation 

```circom
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
```

This code is written in the Circom language and defines a custom zero-knowledge circuit called `Multiplier2`. The circuit takes two inputs and uses basic logic gates (AND, NOT, and OR) to produce an output. Here’s a detailed explanation of each part of the code:

### 1. Pragma Directive
```circom
pragma circom 2.0.0;
```
- This specifies that the code is written for version 2.0.0 of the Circom language, ensuring compatibility with this version.

### 2. Template Definition: `Multiplier2`
```circom
template Multiplier2 () {
    // User Inputs 
    signal input a;  
    signal input b;

    // Circuit Internal Inputs
    signal x;  
    signal y;  

    // Output Circuit 
    signal output q;
```
- **`template Multiplier2 ()`**: Defines a circuit template named `Multiplier2`.
- **`signal input a;` and `signal input b;`**: These are the user-provided inputs for the circuit.
- **`signal x;` and `signal y;`**: Intermediate signals used within the circuit for computations.
- **`signal output q;`**: The final output of the circuit.

### 3. Component Instantiation
```circom
    //component
    component andGate = AND();
    component notGate = NOT();
    component orGate = OR();
```
- **Component Declaration**: Instantiates three components, each representing a logic gate:
    - **`andGate`**: An instance of the `AND` gate template.
    - **`notGate`**: An instance of the `NOT` gate template.
    - **`orGate`**: An instance of the `OR` gate template.

### 4. Wiring Signals to Components
```circom
    // Singals Operation to AND Gate
    andGate.a <== a;
    andGate.b <== b;
    x <== andGate.out;
```
- **AND Gate**: Connects the inputs `a` and `b` to the `andGate` inputs. The result of the `andGate` is stored in the intermediate signal `x`.

```circom
    // Signals Operation to Not Gate 
    notGate.in <== b;
    y <== notGate.out;
```
- **NOT Gate**: Connects the input `b` to the `notGate`. The output of the `notGate` is stored in the intermediate signal `y`.

```circom
    // Getting Final Output From Logical Gates (q)
    orGate.a <== x;
    orGate.b <== y;
    q <== orGate.out;
}
```
- **OR Gate**: Connects the outputs of `x` and `y` to the `orGate`. The result of this gate is assigned to the output signal `q`.

### 5. AND Gate Template
```circom
template AND() {
    signal input a;
    signal input b;
    signal output out;

    out <== a * b;
}
```
- Defines the `AND` gate logic:
    - **Inputs**: `a` and `b`.
    - **Output**: `out`.
    - **Logic**: The output is the product of `a` and `b` (`out <== a * b`), which simulates an AND operation in boolean algebra (1 * 1 = 1, otherwise 0).

### 6. NOT Gate Template
```circom
template NOT() {
    signal input in;
    signal output out;

    out <== 1 + in - 2 * in;
}
```
- Defines the `NOT` gate logic:
    - **Input**: `in`.
    - **Output**: `out`.
    - **Logic**: The formula `out <== 1 + in - 2 * in` effectively inverts the input. For a binary input (0 or 1), it returns 1 when `in` is 0, and 0 when `in` is 1.

### 7. OR Gate Template
```circom
template OR() {
    signal input a;
    signal input b;
    signal output out;

    out <== a + b - a * b;

    log("Circuit Contract Complete!");
    log("Result - ", out);
}
```
- Defines the `OR` gate logic:
    - **Inputs**: `a` and `b`.
    - **Output**: `out`.
    - **Logic**: The formula `out <== a + b - a * b` simulates the OR operation. It results in 1 if either `a` or `b` is 1, and 0 if both are 0.
    - **Logging**: Outputs messages to indicate that the circuit contract has completed and logs the final output value.

### 8. Main Component Declaration
```circom
component main = Multiplier2();
```
- Creates an instance of the `Multiplier2` template as the main component of the circuit, which will be executed when the circuit is run.

### Summary
- **Input**: Two signals, `a` and `b`.
- **Processing**:
    - Uses an `AND` gate to process `a` and `b` and store the result in `x`.
    - Uses a `NOT` gate to process `b` and store the result in `y`.
    - Uses an `OR` gate to combine `x` and `y` to produce the final output `q`.
- **Output**: The signal `q`, representing the result of the circuit.

This circuit allows you to combine basic logical operations (AND, NOT, and OR) to create a simple zero-knowledge proof circuit, which can be used to verify certain computations while maintaining the privacy of the inputs.
