`timescale 1ns / 1ps
module top_tb;

reg clk;
reg rst;
reg Hwrite;
reg Hreadyin;
reg [31:0] Hwdata,Haddr,Prdata;
reg [1:0] Htrans;

wire Penable,Pwrite,Hreadyout;
wire [1:0] Hresp;
wire [2:0] Pselx;
wire [31:0] Paddr,Pwdata;
wire [31:0] Hrdata;

Bridge_Top dut(
	.clk(clk),	
    .rst(rst),
    .Hwrite(Hwrite),
    .Hreadyin(Hreadyin),
    .Htrans(Htrans),
    .Haddr(Haddr),
    .Hwdata(Hwdata),
    .Prdata(Prdata),
    .Hrdata(Hrdata),
	.Penable(Penable),
	.Pwrite(Pwrite),
	.Hreadyout(Hreadyout),
	.Hresp(Hresp),
	.Pselx(Pselx),
	.Paddr(Paddr),
	.Pwdata(Pwdata)
);

// Clock Generation
always #5 clk = ~clk; // 10ns clock period

initial begin
	clk = 1;
	rst = 0;
	Hwrite = 0;
	Hreadyin = 0;
	Haddr = 32'b0;
	Hwdata = 32'b0;
	Prdata = 32'b0;
	Htrans = 2'b10;

	#20 rst = 1;

	//single read
	Haddr = 32'h8400_0010;
	Hwrite = 0;
	Hreadyin = 1;
	#10
	Haddr = 32'bz;
	Hwrite = 1'bz;
	Hreadyin = 0;
	#10
	Hreadyin = 1;
	Prdata = 32'h1111_2222;
	#10
	Hreadyin = 0;
	#40

	//single write
	Haddr = 32'h8800_0010;
	Hwrite = 1;
	Hreadyin = 1;
	#10
	Haddr = 32'bz;
	Hwrite = 1'bz;
	Hreadyin = 1;
	Hwdata = 32'h3333_4444;
	#10
	Hreadyin = 0;
	#10
	Hreadyin = 0;
	#40
	$stop;
end
endmodule












