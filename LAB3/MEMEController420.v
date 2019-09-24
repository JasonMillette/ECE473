// FILE MEMEController420.v
// state machine controller

module MEMEController420(input Reset, input ONE, input X0, input CLK, output reg WEN, output reg SEL, output reg [1:0] FS, output [2:0] stateOut);
	
	parameter[2:0] s0=3'b000,	//Set states
						s1=3'b001,
						s2=3'b010,
						s3=3'b011,
						s4=3'b100;
						
	reg [2:0] state=s0;
	assign stateOut=state;
	
	always @(posedge CLK/* or posedge Reset*/) begin
	
	if(Reset==1) begin
		SEL<=0;
		WEN<=0;
		state<=s0;
		FS[0]<=0;
		FS[1]<=0;
	end
	
		case (state)
			s0: begin
				if(ONE==1) begin
					state<=s1;
					end
				else if(X0==1) begin
					state<=s2;
				end
				else if(X0==0) begin
					state<=s4;
				end
				FS[0]<=0;	//Set output
				FS[1]<=0;
				SEL<=0;
				WEN<=0;
			end
/////////////////////////////////////////////////////			
			s1: begin
				if(ONE==1) begin
					state<=s1;
				end
				SEL<=1;
				WEN<=0;
				//FS[0]<=1;
				//FS[1]<=1;
			end
/////////////////////////////////////////////////////			
			s2: begin
				FS[0]<=1;	//set output
				FS[1]<=1;
				state<=s3;
				SEL<=1;
				WEN<=1;
			end
////////////////////////////////////////////////////			
			s3: begin
				FS[0]<=1;
				FS[1]<=0;
				state<=s4;
				SEL<=1;
				WEN<=0;
			end
/////////////////////////////////////////////////////			
			s4: begin
				if(ONE==1) begin
					state<=s1;
					FS[0]<=0;	//Set output
					FS[1]<=0;
				end
				else if(X0==0) begin
					state<=s4;
					FS[0]<=0;
					FS[1]<=1;
				end
				else if(X0==1) begin
					state<=s2;
					FS[0]<=0;	//Set output
					FS[1]<=0;
				end
				SEL<=1;
				WEN<=0;
			end
			
		endcase
//////////////////////////////////////////////////////

end
endmodule