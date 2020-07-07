// Write code for modules you need here


module reg_file (input wire clk, reset, wr, input wire [2:0] rd_addr_a, rd_addr_b, wr_addr, input wire [7:0] d_in, output wire [7:0] d_out_a, d_out_b);

// Declare wires here
	wire [7:0] t0, t1, t2, t3, t4, t5, t6, t7, reg_op0, reg_op1,  reg_op2,  reg_op3,  reg_op4,  reg_op5,  reg_op6,  reg_op7;
	wire [0:7] wrload;

// Instantiate modules here

	STBitDemux8 writer(wr_addr, d_in, t0, t1, t2, t3, t4, t5, t6, t7);

	demux8 load_demux(wr, wr_addr[2], wr_addr[1], wr_addr[0], wrload);

	STBitReg reg_0(clk, reset, wrload[0], d_in, reg_op0);
	STBitReg reg_1(clk, reset, wrload[1], d_in, reg_op1);
	STBitReg reg_2(clk, reset, wrload[2], d_in, reg_op2);
	STBitReg reg_3(clk, reset, wrload[3], d_in, reg_op3);
	STBitReg reg_4(clk, reset, wrload[4], d_in, reg_op4);
	STBitReg reg_5(clk, reset, wrload[5], d_in, reg_op5);
	STBitReg reg_6(clk, reset, wrload[6], d_in, reg_op6);
	STBitReg reg_7(clk, reset, wrload[7], d_in, reg_op7);

	STBitMux8 read_a(rd_addr_a, reg_op0, reg_op1,  reg_op2,  reg_op3,  reg_op4,  reg_op5,  reg_op6,  reg_op7, d_out_a);
	STBitMux8 read_b(rd_addr_b, reg_op0, reg_op1,  reg_op2,  reg_op3,  reg_op4,  reg_op5,  reg_op6,  reg_op7, d_out_b);

endmodule


module reg_alu (input wire clk, reset, sel, wr, input wire [1:0] op, input wire [2:0] rd_addr_a,
		rd_addr_b, wr_addr, input wire [7:0] d_in, output wire [7:0] d_out_a, d_out_b, output wire cout);

// Declare wires here
	wire [7:0] alu_outp, reg_din;
	wire alu_cout;

// Instantiate modules here
	reg_file reg_m(clk, reset, wr, rd_addr_a, rd_addr_b, wr_addr, reg_din, d_out_a, d_out_b);
	STBitMux2 din_mux(d_in, alu_outp, sel, reg_din);
	alu alu_m(op, d_out_a, d_out_b, alu_outp, alu_cout);
	dfr cout_dfr(clk, reset, alu_cout, cout);
	
endmodule

module STBitReg(input wire clk, rst, load, input wire[7:0] inp, output wire [7:0] outp);

	dfrl dfrl_0( clk, rst, load, inp[0], outp[0] );
	dfrl dfrl_1( clk, rst, load, inp[1], outp[1] );
	dfrl dfrl_2( clk, rst, load, inp[2], outp[2] );
	dfrl dfrl_3( clk, rst, load, inp[3], outp[3] );
	dfrl dfrl_4( clk, rst, load, inp[4], outp[4] );
	dfrl dfrl_5( clk, rst, load, inp[5], outp[5] );
	dfrl dfrl_6( clk, rst, load, inp[6], outp[6] );
	dfrl dfrl_7( clk, rst, load, inp[7], outp[7] );

endmodule

module STBitDemux8(input wire [2:0] s, input wire [7:0] inp, output [7:0] o0, o1, o2, o3, o4, o5, o6, o7);

	demux8 b_0( inp[0], s[2], s[1], s[0], { o0[0], o1[0], o2[0], o3[0], o4[0], o5[0], o6[0], o7[0] } );
	demux8 b_1( inp[1], s[2], s[1], s[0], { o0[1], o1[1], o2[1], o3[1], o4[1], o5[1], o6[1], o7[1] } );
	demux8 b_2( inp[2], s[2], s[1], s[0], { o0[2], o1[2], o2[2], o3[2], o4[2], o5[2], o6[2], o7[2] } );
	demux8 b_3( inp[3], s[2], s[1], s[0], { o0[3], o1[3], o2[3], o3[3], o4[3], o5[3], o6[3], o7[3] } );
	demux8 b_4( inp[4], s[2], s[1], s[0], { o0[4], o1[4], o2[4], o3[4], o4[4], o5[4], o6[4], o7[4] } );
	demux8 b_5( inp[5], s[2], s[1], s[0], { o0[5], o1[5], o2[5], o3[5], o4[5], o5[5], o6[5], o7[5] } );
	demux8 b_6( inp[6], s[2], s[1], s[0], { o0[6], o1[6], o2[6], o3[6], o4[6], o5[6], o6[6], o7[6] } );
	demux8 b_7( inp[7], s[2], s[1], s[0], { o0[7], o1[7], o2[7], o3[7], o4[7], o5[7], o6[7], o7[7] } );

endmodule

module STBitMux8(input wire [2:0] s, input wire [7:0] i0, i1, i2, i3, i4, i5, i6, i7, output wire [7:0] out);

	mux8 b_0( { i0[0], i1[0], i2[0], i3[0], i4[0], i5[0], i6[0], i7[0] }, s[0], s[1], s[2], out[0] );
	mux8 b_1( { i0[1], i1[1], i2[1], i3[1], i4[1], i5[1], i6[1], i7[1] }, s[0], s[1], s[2], out[1] );
	mux8 b_2( { i0[2], i1[2], i2[2], i3[2], i4[2], i5[2], i6[2], i7[2] }, s[0], s[1], s[2], out[2] );
	mux8 b_3( { i0[3], i1[3], i2[3], i3[3], i4[3], i5[3], i6[3], i7[3] }, s[0], s[1], s[2], out[3] );
	mux8 b_4( { i0[4], i1[4], i2[4], i3[4], i4[4], i5[4], i6[4], i7[4] }, s[0], s[1], s[2], out[4] );
	mux8 b_5( { i0[5], i1[5], i2[5], i3[5], i4[5], i5[5], i6[5], i7[5] }, s[0], s[1], s[2], out[5] );
	mux8 b_6( { i0[6], i1[6], i2[6], i3[6], i4[6], i5[6], i6[6], i7[6] }, s[0], s[1], s[2], out[6] );
	mux8 b_7( { i0[7], i1[7], i2[7], i3[7], i4[7], i5[7], i6[7], i7[7] }, s[0], s[1], s[2], out[7] );
	
endmodule

module STBitMux2(input [7:0] i0, i1, input s, output [7:0] o);
    mux2 op_0( i0[0], i1[0], s, o[0] );
    mux2 op_1( i0[1], i1[1], s, o[1] );
    mux2 op_2( i0[2], i1[2], s, o[2] );
    mux2 op_3( i0[3], i1[3], s, o[3] );
    mux2 op_4( i0[4], i1[4], s, o[4] );
    mux2 op_5( i0[5], i1[5], s, o[5] );
    mux2 op_6( i0[6], i1[6], s, o[6] );
    mux2 op_7( i0[7], i1[7], s, o[7] );

endmodule
