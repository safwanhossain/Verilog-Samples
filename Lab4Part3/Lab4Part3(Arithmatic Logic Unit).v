module ALU(Q, A, B, Zout);		//artihmatic logic unit; performs functions as seen in the case statement
	input [2:0]Q;
	input [7:0]A;
	input [7:0]B;
	
	output reg[7:0]Zout;
	
	always @*
		begin
		case(Q)
			3'b000: Zout = (~A) ^ B;
			3'b001: Zout = A ^ (~B);
			3'b010: Zout = ~(A & B);
			3'b011: Zout = A & B;
			3'b100: Zout = A + B + 8'b00000001;
			3'b101: Zout = ~(A ^ B);
			3'b110: Zout = 8'b00001000 - ( A[0] + A[1] + A[2] + A[3] + A[4] + A[5] + A[6] + A[7]);
			3'b111: Zout = (B[0] + B[1] + B[2] + B[3] + B[4] + B[5] + B[6] + B[7]) + (8'b00001000 - ( A[0] + A[1] + A[2] + A[3] + A[4] + A[5] + A[6] + A[7]));			
		endcase
		end

endmodule

module hexDecoder(b0, b1, b2, b3, HEX);		//decoder; used to display hexadecimal values on the 7 segment hex display.  
	input b0, b1, b2, b3;
	output [6:0]HEX;
	
	//derived using K-mapping
	assign HEX[0] = (b0&~b1&~b2&~b3) | (~b0&~b1&b2&~b3) | (b0&b1&~b2&b3) | (b0&~b1&b2&b3);
	assign HEX[1] = (~b0&~b1&b2&b3) | (b0&~b1&b2&~b3) | (b0&b1&b3) | (~b0&b1&b2);
	assign HEX[2] = (~b0&b1&~b2&~b3) | (~b0&~b1&b2&b3) | (b1&b2&b3);
	assign HEX[3] = (b0&~b1&~b2&~b3) | (~b0&~b1&b2&~b3) | (b0&b1&b2&~b3) | (b0&~b1&~b2&b3) | (~b0&b1&~b2&b3) | (b0&b1&b2&b3);
	assign HEX[4] = (b0&~b1&~b2&~b3) | (b0&b1&~b2&~b3) | (~b1&b2&~b3) | (b0&b1&b2&~b3) | (b0&~b1&~b2&b3);
	assign HEX[5] = (b0&~b1&~b2&~b3) | (~b0&b1&~b2&~b3) | (b0&b1&~b2&~b3) | (b0&b1&b2&~b3) | (b0&~b1&b2&b3);
	assign HEX[6] = (~b1&~b2&~b3) | (b0&b1&b2&~b3) | (~b0&~b1&b2&b3);
	
endmodule


module Lab4Part3(OPCODE, DATA, clk, reset, SEG00, SEG01, SEG10, SEG11);
	input [7:0]DATA;
	input [2:0]OPCODE;		//controls what function is performed by the ALU
	input clk, reset;
	
	output [6:0]SEG00;
	output [6:0]SEG01;
	output [6:0]SEG10;
	output [6:0]SEG11;
	
	reg [7:0]B_IN;
	wire [7:0]B_OUT;
	
	ALU A0(OPCODE, DATA, B_IN, B_OUT);
	
	hexDecoder h10(B_IN[0], B_IN[1], B_IN[2], B_IN[3], SEG00);
	hexDecoder h11(B_IN[4], B_IN[5], B_IN[6], B_IN[7], SEG01);
	hexDecoder h00(DATA[0], DATA[1], DATA[2], DATA[3], SEG10);
	hexDecoder h01(DATA[4], DATA[5], DATA[6], DATA[7], SEG11);
	
	//One of the input to the ALU is DATA and is retrieved from the user. The other input is the result of the previous calculations. Calculations occur at clock cycles
	always @(posedge clk)
	begin
		if(reset == 1)
			B_IN = 8'b00000000;
		else
			B_IN = B_OUT;
	end

endmodule
	
