# Sequence Detectors
A sequence detector is a sequential circuit designed to recognize a specific pattern of bits within a stream of input bits. It generates an output of **1** when the desired pattern is detected; otherwise, the output remains **0**. Sequence detectors are commonly used in digital systems for tasks such as error detection, synchronization, and data recognition. They can be implemented using various types of *Finite State Machines* (FSMs), such as Mealy or Moore machines.
</br>
This repository contains Verilog code for following types of sequence detectors:
- **Overlapping Sequence Detector**: These detectors are designed to identify patterns even if they overlap within the input sequence. When a pattern is found, the detector continues scanning for the same pattern within the subsequent bits without resetting. This enables the detection of new instances of the pattern that may begin within the previously detected pattern.
- **Non-overlapping Sequence Detector**: These detectors reset their detection process after recognizing a pattern. Once a pattern is detected, the detector starts anew, ensuring that no bits from the detected pattern are reused for immediate subsequent pattern detection. Each detected pattern is distinct and separated from others.
</br>
For example to detect the sequence 11011 in the sequence 101101101101100 </br>
Output of Overlapping Sequence Detctor:                  000000100100100 (sequence is detected at 10**11011**01101100, 10110**11011**01100, 10110110**11011**00) </br>
Output of Non-Overlapping Sequence Detctor:              000000100000100 (sequence is detected at 10**11011**01101100, 10110110**11011**00) </br>
