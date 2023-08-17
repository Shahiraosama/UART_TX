module FSM(

input	wire		clk,
input	wire		rst,
input	wire		Data_valid,
input	wire		Par_en,
input	wire		ser_done,
output	reg	[1:0]	mux_sel,
output	reg		ser_en,
output	reg		busy

);

localparam [2:0] IDLE_state    =3'b000;
localparam [2:0] start_state   =3'b001;
localparam [2:0] ser_data_state=3'b011;
localparam [2:0] Par_bit_state =3'b010;
localparam [2:0] stop_state    =3'b110;
 
reg		busy_out;
reg	[2:0]	current_state;
reg	[2:0]	next_state;




always@(posedge clk or negedge rst)
begin
	if(!rst)
	begin
	current_state <= IDLE_state;
	end

	else
	begin
	current_state <= next_state;
	end

end

always @(*)
begin
	case(current_state)
IDLE_state:
	begin
	if(!Data_valid)
	begin
	next_state = IDLE_state;
	end
	else
	begin
	next_state = start_state;
	end
	end

start_state:
	begin
	next_state = ser_data_state;
	end
ser_data_state:
	begin
	if(!ser_done)
	begin
	next_state = ser_data_state;
	end
	
	else
	begin
	if(Par_en)
	begin
	next_state = Par_bit_state ;
	end

	else
	begin
	next_state = stop_state ;
	end

	end
	end

Par_bit_state:
	begin
	next_state = stop_state ;
	end
stop_state:
	begin
	if (Data_valid)
	begin
	next_state = start_state; 
	end

	else 
	begin
	next_state = IDLE_state;
	end
	end
default:
	begin
	next_state = IDLE_state ;
	end

	endcase
end


always@(*)
begin
	case(current_state)
IDLE_state:
	begin
	busy_out = 1'b0;
	mux_sel = 2'b01;
	ser_en = 1'b0;
	end
start_state:
	begin
	busy_out = 1'b1;
	mux_sel = 2'b00;
	ser_en = 1'b0;
	end

ser_data_state:
	begin
	if(ser_done)
	begin
	ser_en = 1'b0;
	end
	else
	begin
	ser_en = 1'b1;
	end
	busy_out = 1'b1;
	mux_sel = 2'b10;	
	end
Par_bit_state:
	begin
	busy_out =1'b1;
	mux_sel = 2'b11;
	ser_en = 1'b0;
	end
stop_state:
	begin
	busy_out =1'b1;
	mux_sel = 2'b01;
	ser_en = 1'b0;
	end
default 
	begin
	busy_out =1'b0;
	mux_sel = 2'b01;
	ser_en = 1'b0;
	end
	endcase

end

always@(posedge clk or negedge rst)
begin
if(!rst)
begin
busy <= 1'b0;
end

else
begin
busy <= busy_out ;
end
end



endmodule

