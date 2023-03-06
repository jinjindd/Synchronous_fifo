module FIFO_control(write_ptr,read_ptr,stack_full,stack_empty,write_to_stack,read_from_stack,clk,rst);
	parameter stack_width=8;
	parameter stack_height=8;
	parameter stack_ptr_width=3;
	output stack_full;
	output stack_empty;
	output [stack_ptr_width-1:0] read_ptr;
	output [stack_ptr_width-1:0] write_ptr;
	input write_to_stack;
	input read_from_stack;
	input clk;
	input rst;
	reg [stack_ptr_width-1:0] read_ptr;
	reg [stack_ptr_width-1:0] write_ptr;
	reg [stack_ptr_width:0] ptr_gap;
	reg [stack_width-1:0] data_out;
	reg [stack_width-1:0] stack [stack_height-1:0];
//stack status signal
	assign stack_full=(ptr_gap==stack_height);
	assign stack_empty=(ptr_gap==0);

	always@(posedge clk or posedge rst)
	if(rst)
	 begin
	  data_out<=0;
	  read_ptr<=0;
	  write_ptr<=0;
	  ptr_gap<=0;
	 end
	else if(write_to_stack&&(!stack_full)&&(!read_from_stack))
	 begin
	  write_ptr<=write_ptr+1;
	  ptr_gap<=ptr_gap+1;
	 end
	else if(!write_to_stack&&(!stack_empty)&&(read_from_stack))
	 begin
	  read_ptr<=read_ptr+1;
	  ptr_gap<=ptr_gap-1;
	 end
	else if(write_to_stack&&stack_empty&&read_from_stack)
	 begin
	  write_ptr<=write_ptr+1;
	  ptr_gap<=ptr_gap+1;
	 end
	else if(write_to_stack&&stack_full&&read_from_stack)
	 begin
	  read_ptr<=read_ptr+1;
	  ptr_gap<=ptr_gap-1;
	 end
	else if(write_to_stack&&read_from_stack&&(!stack_full)&&(!stack_empty))
	 begin
	  write_ptr<=write_ptr+1;
	  read_ptr<=read_ptr+1;
	 end
endmodule
