`timescale 1ns / 1ps

module APB_FSM_Controller_tb;

// Inputs
reg Hclk, Hresetn, valid, Hwrite, Hwritereg;
reg [31:0] Hwdata, Haddr, Haddr1, Haddr2, Hwdata1, Hwdata2, Prdata;
reg [2:0] tempselx;

// Outputs
wire Pwrite, Penable, Hreadyout;
wire [2:0] Pselx;
wire [31:0] Paddr, Pwdata;

// Instantiate the DUT (Device Under Test)
APB_FSM_Controller DUT (
    .Hclk(Hclk),
    .Hresetn(Hresetn),
    .valid(valid),
    .Haddr1(Haddr1),
    .Haddr2(Haddr2),
    .Hwdata1(Hwdata1),
    .Hwdata2(Hwdata2),
    .Prdata(Prdata),
    .Hwrite(Hwrite),
    .Haddr(Haddr),
    .Hwdata(Hwdata),
    .Hwritereg(Hwritereg),
    .tempselx(tempselx),
    .Pwrite(Pwrite),
    .Penable(Penable),
    .Pselx(Pselx),
    .Paddr(Paddr),
    .Pwdata(Pwdata),
    .Hreadyout(Hreadyout)
);

// Clock generation
always #5 Hclk = ~Hclk; // 10ns clock period

// Task to initialize inputs
task initialize_inputs();
    begin
        Hclk = 0;
        Hresetn = 0;
        valid = 0;
        Hwrite = 0;
        Hwritereg = 0;
        Hwdata = 0;
        Haddr = 0;
        Haddr1 = 0;
        Haddr2 = 0;
        Hwdata1 = 0;
        Hwdata2 = 0;
        Prdata = 0;
        tempselx = 0;
    end
endtask

// Testbench Procedure
initial begin
    // Step 1: Initialize inputs and reset
    initialize_inputs();
    #10 Hresetn = 1; // Release reset after 10ns

    // Step 2: Test ST_IDLE
    $display("Testing ST_IDLE...");
    valid = 0;
    Hwrite = 0;
    #20;
    if (Penable == 0 && Hreadyout == 1)
        $display("ST_IDLE Test Passed");
    else
        $display("ST_IDLE Test Failed");

    // Step 3: Test ST_WWAIT
    $display("Testing ST_WWAIT...");
    valid = 1;
    Hwrite = 1;
    tempselx = 3'b001;
    Haddr = 32'h8000_0004;
    Hwdata = 32'hDEADBEEF;
    #10;
    if (Hreadyout == 1 && Pwrite == 0)
        $display("ST_WWAIT Test Passed");
    else
        $display("ST_WWAIT Test Failed");

    // Step 4: Test ST_WRITE
    $display("Testing ST_WRITE...");
    valid = 0; // Simulate data stabilization
    #10;
    if (Pwrite == 1 && Penable == 1)
        $display("ST_WRITE Test Passed");
    else
        $display("ST_WRITE Test Failed");

    // Step 5: Test ST_WRITEP
    $display("Testing ST_WRITEP...");
    valid = 1; // Simulate pipelined write
    Haddr1 = 32'h8000_0010;
    Hwdata1 = 32'hFACEFEED;
    #10;
    if (Pwrite == 1 && Pwdata == 32'hFACEFEED)
        $display("ST_WRITEP Test Passed");
    else
        $display("ST_WRITEP Test Failed");

    // Step 6: Test ST_READ
    $display("Testing ST_READ...");
    valid = 1;
    Hwrite = 0;
    Haddr = 32'h8000_0020;
    tempselx = 3'b010;
    #10;
    if (Penable == 1 && Pselx == 3'b010)
        $display("ST_READ Test Passed");
    else
        $display("ST_READ Test Failed");

    // Step 7: Test ST_RENABLE
    $display("Testing ST_RENABLE...");
    valid = 1;
    Hwrite = 0;
    #10;
    if (Hreadyout == 1)
        $display("ST_RENABLE Test Passed");
    else
        $display("ST_RENABLE Test Failed");

    // Step 8: Test ST_WENABLE
    $display("Testing ST_WENABLE...");
    valid = 0;
    Hwritereg = 1;
    #10;
    if (Penable == 1 && Hreadyout == 1)
        $display("ST_WENABLE Test Passed");
    else
        $display("ST_WENABLE Test Failed");

    // Step 9: Test ST_WENABLEP
    $display("Testing ST_WENABLEP...");
    valid = 1;
    Hwritereg = 1;
    #10;
    if (Penable == 0 && Pwrite == 1)
        $display("ST_WENABLEP Test Passed");
    else
        $display("ST_WENABLEP Test Failed");

    // Finish the simulation
    $display("All tests completed.");
    $stop;
end

endmodule

