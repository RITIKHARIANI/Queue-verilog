`timescale 1 ns / 100 ps
`define TESTVECS 20

module tb;
  reg clk, reset, wr, rd;
  wire full, empty;
  reg [7:0] din;
  wire [7:0] dout;
  reg [9:0] test_vecs [0:(`TESTVECS-1)];
  integer i;
  initial begin $dumpfile("tb_queue.vcd"); $dumpvars(0,tb); end
  initial begin reset = 1'b1; #12.5 reset = 1'b0; end
  initial clk = 1'b0; always #5 clk =~ clk;
  initial begin
  test_vecs[0][9] = 1'b1; test_vecs[0][8] = 1'b0; test_vecs[0][7:0] = 8'ha;
  test_vecs[1][9] = 1'b0; test_vecs[1][8] = 1'b1; test_vecs[1][7:0] = 8'hxx;
  test_vecs[2][9] = 1'b1; test_vecs[2][8] = 1'b0; test_vecs[2][7:0] = 8'h1;
  test_vecs[3][9] = 1'b0; test_vecs[3][8] = 1'b1; test_vecs[3][7:0] = 8'hxx;
  test_vecs[4][9] = 1'b1; test_vecs[4][8] = 1'b0; test_vecs[4][7:0] = 8'h2;
  test_vecs[5][9] = 1'b0; test_vecs[5][8] = 1'b1; test_vecs[5][7:0] = 8'hxx;
  test_vecs[6][9] = 1'b0; test_vecs[6][8] = 1'b1; test_vecs[6][7:0] = 8'hxx;
  test_vecs[7][9] = 1'b1; test_vecs[7][8] = 1'b0; test_vecs[7][7:0] = 8'h4;
  test_vecs[8][9] = 1'b0; test_vecs[8][8] = 1'b1; test_vecs[8][7:0] = 8'hxx;
  test_vecs[9][9] = 1'b1; test_vecs[9][8] = 1'b0; test_vecs[9][7:0] = 8'h9;
  test_vecs[10][9] = 1'b1; test_vecs[10][8] = 1'b0; test_vecs[10][7:0] = 8'h6;
  test_vecs[11][9] = 1'b0; test_vecs[11][8] = 1'b1; test_vecs[11][7:0] = 8'hxx;
  test_vecs[12][9] = 1'b1; test_vecs[12][8] = 1'b0; test_vecs[12][7:0] = 8'h5;
  test_vecs[13][9] = 1'b1; test_vecs[13][8] = 1'b0; test_vecs[13][7:0] = 8'h8;
  test_vecs[14][9] = 1'b0; test_vecs[14][8] = 1'b1; test_vecs[14][7:0] = 8'hxx;
  test_vecs[15][9] = 1'b0; test_vecs[15][8] = 1'b1; test_vecs[15][7:0] = 8'hxx;
  test_vecs[16][9] = 1'b1; test_vecs[16][8] = 1'b0; test_vecs[16][7:0] = 8'h7;
  test_vecs[17][9] = 1'b0; test_vecs[17][8] = 1'b1; test_vecs[17][7:0] = 8'hxx;
  test_vecs[18][9] = 1'b1; test_vecs[18][8] = 1'b0; test_vecs[18][7:0] = 8'h3;
  test_vecs[19][9] = 1'b0; test_vecs[19][8] = 1'b1; test_vecs[19][7:0] = 8'hxx;
  end
  initial {wr, rd, din} = 0;
  queue queue_0 (clk, reset, wr, rd, din[7:0], empty, full, dout[7:0]);
  initial begin
      #6 for(i=0;i<`TESTVECS;i=i+1)
        begin #10 {wr, rd, din}=test_vecs[i]; end
      #10 $finish;
  end
endmodule
