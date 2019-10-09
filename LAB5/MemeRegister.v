//file MemeRegister.v

module MemeRegister(
	input wire clock,
	input wire reset,
	input wire write,
	input wire clock_debug,
	input wire [4:0] read_address_debug,
	input wire [31:0] data_in,
	output reg [31:0] data_out_1,
	output reg [31:0]	data_out_2,
	output reg [31:0] data_out_debug,
	input wire [4:0] read_address_1,
	input wire [4:0] read_address_2,
	input wire [4:0] write_address
	);
	
	reg [31:0] Regfile [31:0];
	integer i;
	
	initial begin
		for (i=0;i<32;i=i+1) begin
			Regfile[i]=i;	
		end
	end
	
	always @(posedge clock_debug) begin
		data_out_debug <= Regfile[read_address_debug];
	end
		
	always @(posedge clock) begin
		
		
		if (reset==1) begin
			for (i=0;i<32;i=i+1) begin
			Regfile[i]<=0;	
			end
		end 
		
		else if (write==1) begin
			Regfile[write_address]<=data_in;
		end
		
		data_out_1<=Regfile[read_address_1];
		data_out_2<=Regfile[read_address_2];
		
	end
		
endmodule
	