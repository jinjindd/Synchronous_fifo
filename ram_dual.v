module ram_dual(q,addr_in,addr_out,d,we,rd,clk1,clk2);
	output [7:0] q;     //output data
	input [7:0] d;	    //input data
	input [2:0] addr_in;//write data address signal
	input [2:0] addr_out;//output data address signal
	input we;
	input rd;
	input clk1;
	input clk2;
	reg [7:0] q;
	reg [7:0] mem[7:0];
	always@(posedge clk1)
	 begin
	  if(we)
	   mem[addr_in]<=d;
	 end
	always@(posedge clk2)
	 begin
	  if(rd)
	   q<=mem[addr_out];
	 end
endmodule
