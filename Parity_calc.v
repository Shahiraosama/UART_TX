module Parity_calc(

input	wire		clk,
input	wire		rst,
input	wire		Data_valid,
input	wire	[7:0]	P_Data,
input	wire		Par_type,
input	wire		Par_en,
output	reg		Par_bit
);

localparam even = 1'b0;
localparam odd  = 1'b1;

always@(posedge clk or negedge rst)
begin
	if(!rst)
	begin
	Par_bit <= 1'b0;
	end

	else if (Par_en)
	begin

	case(Par_type)	
even:
	begin
	Par_bit <= ^(P_Data);
	end
odd:
	begin
	Par_bit <= ~^(P_Data);
	end
	
	endcase
	
	end

end


endmodule

