module FIFO_buffer(clk,rst,write_to_stack,read_from_stack,Data_in,Data_out);
	input clk,rst;
	input write_to_stack,read_from_stack;  //????
	input[7:0] Data_in;
	output[7:0] Data_out;
	wire [7:0] Data_out;
	wire stack_full,stack_empty;
	wire [2:0] addr_in,addr_out;
	FIFO_control U1 (.stack_full(stack_full),.stack_empty(stack_empty),
			.write_to_stack(write_to_stack),.write_ptr(addr_in),
			.read_ptr(addr_out),.read_from_stack(read_from_stack),
			.clk(clk),.rst(rst));
	ram_dual     U2 (.q(Data_out),.addr_in(addr_in),.addr_out(addr_out),
			.d(Data_in),.we(write_to_stack),.rd(read_from_stack),
			.clk1(clk),.clk2(clk));
endmodule
 
