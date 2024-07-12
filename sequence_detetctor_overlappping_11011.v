module sequence_detetctor_overlappping_11011(
	input clk, 
	input reset,
	input sequence_in,
	output reg detected,
	output [4:0] state_out);
// declaring states as parameters
parameter [4:0] S1 = 5'b00001,
				S11 = 5'b00010,
				S110 = 5'b00100,
				S1101 = 5'b01000,
				S11011 = 5'b10000;

reg [4:0] state;
reg [4:0] next_state;

// combinational logic
always @ (*) begin
detected = 0;
case (state) 
	S1 : begin
			if (sequence_in == 1) next_state = S11;
			else 				  next_state = S1;
		 end
	S11 : begin	
			if (sequence_in == 1) next_state = S110;
			else				  next_state = S1;
		  end
	S110 : begin
			if (sequence_in == 0) next_state = S1101;
			else				  next_state = S110;
		   end
	S1101 : begin
				if (sequence_in == 1) next_state = S11011;
				else				  next_state = S1;
			end
	S11011 : begin
				if (sequence_in == 1) begin 
					next_state = S110;
					detected = 1;
				end else	next_state = S1;
			 end
	default : next_state = S1;
endcase
end
// Sequential logic
always @ (posedge clk or negedge reset) begin
	if (!reset)
		state <= S1; 
	else 
		state <= next_state;
end
assign state_out = state;
endmodule

`timescale 1us/1ns
module sequence_detetctor_overlappping_11011_tb;
reg clk = 0; 
reg reset;
reg sequence_in;
wire [4:0] state_out;
wire detected;

sequence_detetctor_overlappping_11011 SO11011 (
	.clk(clk),
	.reset(reset),
	.sequence_in(sequence_in),
	.detected(detected),
	.state_out(state_out));

always begin #0.5 clk = ~clk; end

reg [0:15] test_vector = 15'b101_1011_0110_1100;
integer i;

initial begin
$monitor($time, " sequence_in=%b, detected=%b", sequence_in, detected);
reset = 0; #1.5; reset = 1;
repeat(2) @(posedge clk); //wait for some time
for (i=0; i<15; i = i+1) begin
	sequence_in = test_vector[i];
	@(posedge clk);
end
for (i=0; i<15; i = i+1) begin
	sequence_in = $random;
	@(posedge clk);
end
#10; $stop; 
end
endmodule