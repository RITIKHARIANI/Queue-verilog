# Implementation of Queue in Verilog

A queue where the addresses are of 3-bits each and the register file can hold 8 values (2^3).
Each value is a 8 bit number.

## Circuit Diagram
[Circuit Diagram](https://github.com/RITIKHARIANI/Queue-verilog/blob/master/queue-circuit.jpeg)
## To run:
```
iverilog lib.v queue.v reg_alu.v alu.v tb_queue.v -o out && vvp out
gtkwave tb_queue.vcd
```
