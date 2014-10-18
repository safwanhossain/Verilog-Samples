//part 2 subcircuit; a D flip flop capable of parallel loading as well as left and right shifting
module subCircuit(left, right, loadLeft, D, loadn, clk, Q);
	input left, right, loadLeft, D, loadn, clk;
	output reg Q;
	
	reg leftRightOut;			//output of the left, right multiplex
	reg Dinput;					//input going directly into the flip/flop
	
	always @(posedge clk)
		begin
		
		if(loadLeft == 0)		//caluculates output of left/right multiplex
			leftRightOut = right;
		else
			leftRightOut = left;
			
		if(loadn == 0)			//calculates output going into the flip-flop
			Dinput = D;
		else
			Dinput = leftRightOut;
		
		Q <= Dinput;
		
		end	
endmodule


module Lab4Part2(ParallelLoadn, RotateRight, ASRight, DATA_IN, OUTPUT_Q, clk);
		input ParallelLoadn, RotateRight, ASRight, clk;
		reg ParallelLoadnWire;
		
		input [7:0]DATA_IN;
		output [7:0]OUTPUT_Q;
		
		subCircuit q0(OUTPUT_Q[1], OUTPUT_Q[7], RotateRight, DATA_IN[0], ParallelLoadn, clk, OUTPUT_Q[0]);
		
		subCircuit q1(OUTPUT_Q[2], OUTPUT_Q[0], RotateRight, DATA_IN[1], ParallelLoadn, clk, OUTPUT_Q[1]);
		
		subCircuit q2(OUTPUT_Q[3], OUTPUT_Q[1], RotateRight, DATA_IN[2], ParallelLoadn, clk, OUTPUT_Q[2]);
		
		subCircuit q3(OUTPUT_Q[4], OUTPUT_Q[2], RotateRight, DATA_IN[3], ParallelLoadn, clk, OUTPUT_Q[3]);
		
		subCircuit q4(OUTPUT_Q[5], OUTPUT_Q[3], RotateRight, DATA_IN[4], ParallelLoadn, clk, OUTPUT_Q[4]);
		
		subCircuit q5(OUTPUT_Q[6], OUTPUT_Q[4], RotateRight, DATA_IN[5], ParallelLoadn, clk, OUTPUT_Q[5]);
		
		subCircuit q6(OUTPUT_Q[7], OUTPUT_Q[5], RotateRight, DATA_IN[6], ParallelLoadn, clk, OUTPUT_Q[6]);
		
		subCircuit q7(OUTPUT_Q[0], OUTPUT_Q[6], RotateRight, DATA_IN[7], ParallelLoadnWire, clk, OUTPUT_Q[7]);		//this wire is to set the high bit for asright
		
		always @*
			begin
			
			if((ParallelLoadn == 1) && (RotateRight == 1) && (ASRight == 1))
				ParallelLoadnWire = ~ParallelLoadn;		//rotate but let the high bit through
			
			else
				ParallelLoadnWire = ParallelLoadn;
				
			end
endmodule 



//Another implementation; doesn't follow heirarchial coding but gets it done in one module 

/*
module Lab4Part2(ParallelLoadn, RotateRight, ASRight, DATA_IN, OUTPUT_Q, clk);
	input ParallelLoadn, RotateRight, ASRight, clk;
	input [7:0]DATA_IN;
	output reg[7:0]OUTPUT_Q;
	
	always @(posedge clk)
	begin	
		if(ParallelLoadn == 0)
		begin
			OUTPUT_Q[0] <= DATA_IN[0];
			OUTPUT_Q[1] <= DATA_IN[1];
			OUTPUT_Q[2] <= DATA_IN[2];
			OUTPUT_Q[3] <= DATA_IN[3];
			OUTPUT_Q[4] <= DATA_IN[4];
			OUTPUT_Q[5] <= DATA_IN[5];
			OUTPUT_Q[6] <= DATA_IN[6];
			OUTPUT_Q[7] <= DATA_IN[7];
		end
		
		else
		begin	
			if(RotateRight == 1)
			begin
				if(ASRight == 0)
				begin
					OUTPUT_Q[7] <= OUTPUT_Q[0];
					OUTPUT_Q[6] <= OUTPUT_Q[7];
					OUTPUT_Q[5] <= OUTPUT_Q[6];
					OUTPUT_Q[4] <= OUTPUT_Q[5];
					OUTPUT_Q[3] <= OUTPUT_Q[4];
					OUTPUT_Q[2] <= OUTPUT_Q[3];
					OUTPUT_Q[1] <= OUTPUT_Q[2];
					OUTPUT_Q[0] <= OUTPUT_Q[1];
				end
				
				else
				begin
					OUTPUT_Q[7] <= DATA_IN[7];
					OUTPUT_Q[6] <= OUTPUT_Q[7];
					OUTPUT_Q[5] <= OUTPUT_Q[6];
					OUTPUT_Q[4] <= OUTPUT_Q[5];
					OUTPUT_Q[3] <= OUTPUT_Q[4];
					OUTPUT_Q[2] <= OUTPUT_Q[3];
					OUTPUT_Q[1] <= OUTPUT_Q[2];
					OUTPUT_Q[0] <= OUTPUT_Q[1];
				end
			end
			
			else
			begin
				OUTPUT_Q[7] <= OUTPUT_Q[6];
				OUTPUT_Q[6] <= OUTPUT_Q[5];
				OUTPUT_Q[5] <= OUTPUT_Q[4];
				OUTPUT_Q[4] <= OUTPUT_Q[3];
				OUTPUT_Q[3] <= OUTPUT_Q[2];
				OUTPUT_Q[2] <= OUTPUT_Q[1];
				OUTPUT_Q[1] <= OUTPUT_Q[0];
				OUTPUT_Q[0] <= OUTPUT_Q[7];
			end
		end
	end
	
endmodule
*/
		
		
			
			
			
			
			
			
	
	
	
	
	
	
	
	
