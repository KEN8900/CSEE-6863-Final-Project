# CSEE-6863-Final-Project

This repository is for the Final Project of Columbia University Course CSEE by Yelin Mao, Yuxiang Xia, and Hongkuan Yu. CSEE 6863 is a course about Formal Verification.



We conduct a formal verification for hardware using Cadence Jasper Gold: a Formal Property Verification (FPV) using SystemVerilog Assertion (SVA) for a AHB-to-APB bridge. The reference repositories can be found here: [Formal-Verification-of-an-AHB2APB-Bridge](https://github.com/Ghonimo/Formal-Verification-of-an-AHB2APB-Bridge) and [AHB-to-APB-Bridge](https://github.com/prajwalgekkouga/AHB-to-APB-Bridge) .



## File Hierarchy

In our file hierarchy, the files are organized into distinct folders.

- `RTL`: Contains the RTL design files of the AHB2APB bridge from [AHB-to-APB-Bridge](https://github.com/prajwalgekkouga/AHB-to-APB-Bridge) with our own small preference modifications.
- `SVA`: Contains FPV SVA code used for formal verification. Also contains several `.tcl` files, along with `run.sh`scripts, to execute Cadence Jasper Gold.
- `TB`: Includes the testbench `.v` code, along with `waveform.do`, `runsim.do`, and `run.sh` files, to execute the simulation in Siemens ModelSim.
- `Specification_Sheets`: Contains AMBA specification documents.
- `Reports_and_Slides`: Contains our final report and presentation slides.



## Short Summary

The combined use of simulation test benches and FPV has provided a comprehensive evaluation of the AHB-to-APB bridge. Simulation of the AHB interface demonstrated correct behavior for single and burst transactions, detecting invalid addresses, and functionality of the active low reset. FPV confirmed the correctness of the APB FSM across all states, with no illegal transitions detected. At the top bridge level, FPV identified two specific issues, `Back2back_Pwrite` and `Burst_write_psel0`, which highlight timing or control logic flaws in the RTL. The removal of assumptions about valid address ranges or transfer types led to predictable property failures, emphasizing that the design is not intended to handle out-of-specification scenarios. Simulation at the top bridge level validates functionality for single transactions, while formal verification ensures exhaustive coverage of corner cases, ensuring strong robustness of the AHB-to-APB bridge design. Overall, all results suggest that, with appropriate fixes to the identified bugs, the source RTL code will obey the AMBA specification document under normal operating conditions.

Several enhancements can be made to improve the design and verification processes. First, the errors identified in the source RTL code should be fixed to ensure the AHB-to-APB bridge operates as the AMBA specification document. Moreover, if time permits, the verification scope can be expanded to include a broader range of scenarios and edge cases, providing more thorough coverage of potential issues. Last but not least, the integration of verification tools can be optimized, and the FPV methodology can be extended to other AMBA components, enabling a more comprehensive and robust AMBA system validation.
