`timescale 1ns / 1ps

module AHB_slave_interface_tb;

// DUT signals
reg clk, rst;
reg Hwrite, Hreadyin;
reg [1:0] Htrans;
reg [31:0] Haddr, Hwdata, Prdata;
wire valid;
wire [31:0] Haddr1, Haddr2, Hwdata1, Hwdata2;
wire [31:0] Hrdata;
wire Hwritereg;
wire [2:0] tempselx;
wire [1:0] Hresp;

// Instantiate the DUT
AHB_slave_interface DUT (
    .clk(clk),
    .rst(rst),
    .Hwrite(Hwrite),
    .Hreadyin(Hreadyin),
    .Htrans(Htrans),
    .Haddr(Haddr),
    .Hwdata(Hwdata),
    .Prdata(Prdata),
    .valid(valid),
    .Haddr1(Haddr1),
    .Haddr2(Haddr2),
    .Hwdata1(Hwdata1),
    .Hwdata2(Hwdata2),
    .Hrdata(Hrdata),
    .Hwritereg(Hwritereg),
    .tempselx(tempselx),
    .Hresp(Hresp)
);

// Clock Generation
always #5 clk = ~clk; // 10ns clock period

// Testbench Procedure
initial begin
    // Step 1: Initialize
    clk = 0;
	rst = 0;
	Hwrite = 0;
	Hreadyin = 0;
	Htrans = 2'b00;
	Haddr = 32'b0;
	Hwdata = 32'b0;
	Prdata = 32'b0;
    #15 rst = 1; // Release reset after 15ns

    // Step 2: Read-Write-Read-Write Test
    $display("Starting Read-Write-Read-Write Test");

    // Write Transaction 1
    Haddr = 32'h8000_0010;
    Hwdata = 32'h1234_5678;
    Htrans = 2'b10; // Non-sequential
    Hwrite = 1;
    Hreadyin = 1;
    #10;

    // Read Transaction 1
    Hwrite = 0;
    Prdata = 32'hABCD_EF01; // Simulate data from APB
    #10;

    // Write Transaction 2
    Haddr = 32'h8400_0020;
    Hwdata = 32'h8765_4321;
    Hwrite = 1;
    Htrans = 2'b11; // Sequential
    #10;

    // Read Transaction 2
    Hwrite = 0;
    Prdata = 32'h1122_3344; // Simulate data from APB
    #10;

    $display("Read-Write-Read-Write Test Completed");

    // Step 3: Invalid Address Test
    $display("Starting Invalid Address Test");
    Haddr = 32'h9000_0000; // Out of range
    Htrans = 2'b10; // Non-sequential
    Hreadyin = 1;
    #10;
    if (!valid)
        $display("Invalid Address Test Passed");
    else
        $display("Invalid Address Test Failed");

    // Step 4: Reset Test
    $display("Starting Reset Test");
    rst = 0;
    #10;
    if (Haddr1 == 0 && Haddr2 == 0 && Hwdata1 == 0 && Hwdata2 == 0)
        $display("Reset Test Passed");
    else
        $display("Reset Test Failed");
    rst = 1;

    // Step 5: Burst Test (Incremental and Wrapping)
    $display("Starting Burst Test");
    Haddr = 32'h8000_0000;
    Hwrite = 1;
    Htrans = 2'b10; // Non-sequential
    Hreadyin = 1;
    #10;

    // Incremental burst
    Haddr = 32'h8000_0004;
    #10;
    Haddr = 32'h8000_0008;
    #10;

    // Wrapping burst
    Haddr = 32'h8000_000C; // Wrap to lower boundary
    #10;
    Haddr = 32'h8000_0000;
    #10;

    $display("Burst Test Completed");

    // Finish simulation
    $stop;
end

endmodule

