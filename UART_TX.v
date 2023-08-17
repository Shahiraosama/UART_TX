module UART_TX (

input	wire		clk,
input	wire		rst,
input	wire	[7:0]	P_Data,
input	wire		Data_valid,
input	wire		Par_type,
input	wire		Par_en,
output	wire		TX_OUT,
output	wire		busy

);

wire		ser_done;
wire		ser_en;
wire		ser_data;
wire		par_bit;
wire	[1:0]	mux_sel;

Serializer serial_unit (.clk(clk),.rst(rst),.P_Data(P_Data),.ser_en(ser_en),.ser_done(ser_done),.ser_data(ser_data),.Data_valid(Data_valid) );

MUX mux_unit (.clk(clk),.rst(rst),.start_bit(1'b0),.stop_bit(1'b1),.ser_data(ser_data),.par_bit(par_bit),.mux_sel(mux_sel),.TX_OUT(TX_OUT) );

Parity_calc parity_unit (.clk(clk),.rst(rst),.Data_valid(Data_valid),.P_Data(P_Data),.Par_type(Par_type),.Par_bit(par_bit),.Par_en(Par_en) );

FSM fsm_unit (.clk(clk),.rst(rst),.Data_valid(Data_valid),.Par_en(Par_en),.ser_done(ser_done),.mux_sel(mux_sel),.ser_en(ser_en),.busy(busy) );


endmodule
