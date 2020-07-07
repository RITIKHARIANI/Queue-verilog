# Implementation of Queue in Verilog

8 words of 3 bits  each

## To run:
```
iverilog lib.v queue.v reg_alu.v alu.v tb_queue.v -o out && vvp out
gtkwave tb_queue.vcd
```
