module Serializer (
input	wire		clk,
input	wire		rst,
input	wire	[7:0]	P_Data,
input	wire		Data_valid,
input	wire		ser_en,
output	wire		ser_done,
output	wire		ser_data

);


reg	[2:0]	counter;
reg	[7:0]	temp;

always@(posedge clk or negedge rst)
begin
	if(!rst)
	begin
	temp <= 8'b0;
	end

	else if (Data_valid)
	begin
	temp <= P_Data ;
	end

	else if (ser_en)
	begin
	 temp <= temp >> 1 ;
	end
	

end

always@(posedge clk or negedge rst)
begin
	if (!rst)
	begin
	counter <=3'b0;
	end
	
	else if (ser_en)
	begin
	counter <= counter+1;
	end

	else
	begin
	counter <= 3'b0;
	end
end
assign ser_data = temp [0];
assign ser_done =(counter == 3'd7)? 1'b1:1'b0 ;



endmodule

