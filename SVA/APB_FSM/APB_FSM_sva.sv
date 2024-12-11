module APB_FSM_sva(
	input wire clk,
        input wire rst,
        input wire valid,
        input wire Hwrite,
        input wire [31:0] Hwdata,
        input wire [31:0] Haddr,
        input wire [31:0] Haddr1,
        input wire [31:0] Haddr2,
        input wire [31:0] Hwdata1,
        input wire [31:0] Hwdata2,
        input wire [31:0] Prdata,
        input wire [2:0] tempselx,
        input wire Hwritereg,
        input wire Pwrite,
        input wire Penable,
        input wire [2:0] Pselx,
        input wire [31:0] Paddr,
        input wire [31:0] Pwdata,
        input wire Hreadyout,
        input wire [2:0] CS,
        input wire [2:0] NS,

	//added all temp ports
	input wire Penable_temp,
	input wire Hreadyout_temp,
	input wire Pwrite_temp,
	input wire [2:0] Pselx_temp,
	input wire [31:0] Paddr_temp,
	input wire [31:0] Pwdata_temp
);
//PARAMETERS

	parameter IDLE=3'b000;
	parameter WAIT=3'b001;
	parameter READ= 3'b010;
	parameter WRITE=3'b011;
	parameter WRITEP=3'b100;
	parameter RENABLE=3'b101;
	parameter WENABLE=3'b110;
	parameter WENABLEP=3'b111;

//assertions
//verify basic state transfer
property FSM_state_transfer;
	@(posedge clk) disable iff(!rst) 1 |-> ##2 CS == $past(NS);
endproperty
assert_fsm_state_transfer: assert property (FSM_state_transfer);

//check each state transfer
//IDLE
property IDLE_TO_IDLE;
	@(posedge clk) disable iff(!rst)
	CS == IDLE && !valid |-> NS == IDLE;
endproperty
assert_idle2idle: assert property (IDLE_TO_IDLE);

property IDLE_TO_WAIT;
	@(posedge clk) disable iff(!rst) 
	CS == IDLE && valid && Hwrite |-> NS == WAIT;
endproperty
assert_idle2wait: assert property (IDLE_TO_WAIT);

property IDLE_TO_READ;
	@(posedge clk) disable iff(!rst) 
	CS == IDLE && valid && !Hwrite |-> NS == READ;
endproperty
assert_idle2read: assert property (IDLE_TO_READ);

//WAIT
property WAIT_TO_WRITE;
	@(posedge clk) disable iff(!rst) 
	CS == WAIT && !valid |-> NS == WRITE;
endproperty
assert_wait2write: assert property (WAIT_TO_WRITE);

property WAIT_TO_WRITEP;
	@(posedge clk) disable iff(!rst) 
	CS == WAIT && valid |-> NS == WRITEP;
endproperty
assert_wait2writep: assert property (WAIT_TO_WRITEP);

//READ
property READ_TO_RENABLE;
	@(posedge clk) disable iff(!rst) 
	CS == READ |-> NS == RENABLE;
endproperty
assert_read2renable: assert property (READ_TO_RENABLE);

//WRITE
property WRITE_TO_WENABLE;
	@(posedge clk) disable iff(!rst) 
	CS == WRITE && !valid |-> NS == WENABLE;
endproperty
assert_write2wenable: assert property (WRITE_TO_WENABLE);

property WRITE_TO_WENABLEP;
	@(posedge clk) disable iff(!rst) 
	CS == WRITE && valid |-> NS == WENABLEP;
endproperty
assert_write2wenablep: assert property (WRITE_TO_WENABLEP);

//WRITEP
property WRITEP_TO_WENABLEP;
	@(posedge clk) disable iff(!rst) 
	CS == WRITEP |-> NS == WENABLEP;
endproperty
assert_writep2wenablep: assert property (WRITEP_TO_WENABLEP);

//RENABLE
property RENABLE_TO_IDLE;
	@(posedge clk) disable iff(!rst)
	CS == RENABLE && !valid |-> NS == IDLE;
endproperty
assert_renable2idle: assert property (RENABLE_TO_IDLE);

property RENABLE_TO_WAIT;
	@(posedge clk) disable iff(!rst)
	CS == RENABLE && valid && Hwrite |-> NS == WAIT;
endproperty
assert_renable2wait: assert property (RENABLE_TO_WAIT);

property RENABLE_TO_READ;
	@(posedge clk) disable iff(!rst)
	CS == RENABLE && valid && !Hwrite |-> NS == READ;
endproperty
assert_renable2read: assert property (RENABLE_TO_READ);

//WENABLE
property WENABLE_TO_IDLE;
	@(posedge clk) disable iff(!rst)
	CS == WENABLE && !valid |-> NS == IDLE;
endproperty
assert_wenable2idle: assert property (WENABLE_TO_IDLE);

property WENABLE_TO_WAIT;
	@(posedge clk) disable iff(!rst)
	CS == WENABLE && valid && Hwrite |-> NS == WAIT;
endproperty
assert_wenable2wait: assert property (WENABLE_TO_WAIT);

property WENABLE_TO_READ;
	@(posedge clk) disable iff(!rst)
	CS == WENABLE && valid && !Hwrite |-> NS == READ;
endproperty
assert_wenable2read: assert property (WENABLE_TO_READ);

//WENABLEP
property WENABLEP_TO_WRITE;
	@(posedge clk) disable iff(!rst)
	CS == WENABLEP && !valid && Hwritereg |-> NS == WRITE;
endproperty
assert_wenablep2write: assert property (WENABLEP_TO_WRITE);

property WENABLEP_TO_WRITEP;
	@(posedge clk) disable iff(!rst)
	CS == WENABLEP && valid && Hwritereg |-> NS == WRITEP;
endproperty
assert_wenablep2writep: assert property (WENABLEP_TO_WRITEP);

property WENABLEP_TO_READ;
	@(posedge clk) disable iff(!rst)
	CS == WENABLEP && valid && !Hwritereg |-> NS == READ;
endproperty
assert_wenablep2read: assert property (WENABLEP_TO_READ);

//Output combinational logic

//IDLE
property IDLE_Paddr;
	@(posedge clk) disable iff(!rst)
	CS == IDLE && valid && !Hwrite |-> Paddr_temp == Haddr;
endproperty
assert_IDLE_Paddr: assert property (IDLE_Paddr);

property IDLE_Pwrite;
	@(posedge clk) disable iff(!rst)
	CS == IDLE && valid && !Hwrite |-> Pwrite_temp == Hwrite;
endproperty
assert_IDLE_Pwrite: assert property (IDLE_Pwrite);

property IDLE_Pselx;
	@(posedge clk) disable iff(!rst)
	CS == IDLE && valid && !Hwrite |-> Pselx_temp == tempselx;
endproperty
assert_IDLE_Pselx: assert property (IDLE_Pselx);

property IDLE_Hreadyout;
	@(posedge clk) disable iff(!rst)
	CS == IDLE && valid && !Hwrite |-> Hreadyout_temp == 0;
endproperty
assert_IDLE_Hreadyout: assert property (IDLE_Hreadyout);


property IDLE_IDLE;
	@(posedge clk) disable iff(!rst)
	CS == IDLE && (!valid || (valid && Hwrite)) |-> Pselx_temp == 0 && Penable_temp == 0 && Hreadyout_temp == 1;
endproperty
assert_IDLE_IDLE: assert property (IDLE_IDLE);



//WAIT
property WAIT_Paddr;
	@(posedge clk) disable iff(!rst)
	CS == WAIT |-> Paddr_temp == Haddr1;
endproperty
assert_WAIT_Paddr: assert property (WAIT_Paddr);

property WAIT_Pwrite;
	@(posedge clk) disable iff(!rst)
	CS == WAIT |-> Pwrite_temp == 1;
endproperty
assert_WAIT_Pwrite: assert property (WAIT_Pwrite);

property WAIT_Pselx;
	@(posedge clk) disable iff(!rst)
	CS == WAIT |-> Pselx_temp == tempselx;
endproperty
assert_WAIT_Pselx: assert property (WAIT_Pselx);

property WAIT_Pwdata;
	@(posedge clk) disable iff(!rst)
	CS == WAIT |-> Pwdata_temp == Hwdata;
endproperty
assert_WAIT_Pwdata: assert property (WAIT_Pwdata);

property WAIT_Penable;
	@(posedge clk) disable iff(!rst)
	CS == WAIT |-> Penable_temp == 0;
endproperty
assert_WAIT_Penable: assert property (WAIT_Penable);

property WAIT_Hreadyout;
	@(posedge clk) disable iff(!rst)
	CS == WAIT |-> Hreadyout_temp == 0;
endproperty
assert_WAIT_Hreadyout: assert property (WAIT_Hreadyout);


//READ
property READ_Penable;
	@(posedge clk) disable iff(!rst)
	CS == READ |-> Penable_temp == 1;
endproperty
assert_READ_Penable: assert property (READ_Penable);

property READ_Hreadyout;
	@(posedge clk) disable iff(!rst)
	CS == READ |-> Hreadyout_temp == 1;
endproperty
assert_READ_Hreadyout: assert property (READ_Hreadyout);


//WRITE
property WRITE_Penable;
	@(posedge clk) disable iff(!rst)
	CS == WRITE && !valid |-> Penable_temp == 1;
endproperty
assert_WRITE_Penable: assert property (WRITE_Penable);

property WRITE_Hreadyout;
	@(posedge clk) disable iff(!rst)
	CS == WRITE && !valid |-> Hreadyout_temp == 1;
endproperty
assert_WRITE_Hreadyout: assert property (WRITE_Hreadyout);

property WRITE_Penable_p;
	@(posedge clk) disable iff(!rst)
	CS == WRITE && valid |-> Penable_temp == 1;
endproperty
assert_WRITE_Penable_p: assert property (WRITE_Penable_p);

property WRITE_Hreadyout_p;
	@(posedge clk) disable iff(!rst)
	CS == WRITE && valid |-> Hreadyout_temp == 1;
endproperty
assert_WRITE_Hreadyout_p: assert property (WRITE_Hreadyout_p);

//WRITEP
property WRITEP_Penable;
	@(posedge clk) disable iff(!rst)
	CS == WRITEP |-> Penable_temp == 1;
endproperty
assert_WRITEP_Penable: assert property (WRITEP_Penable);

property WRITEP_Hreadyout;
	@(posedge clk) disable iff(!rst)
	CS == WRITEP |-> Hreadyout_temp == 1;
endproperty
assert_WRITEP_Hreadyout: assert property (WRITEP_Hreadyout);


//RENABLE
property RENABLE_Paddr;
	@(posedge clk) disable iff(!rst)
	CS == RENABLE && valid && !Hwrite |-> Paddr_temp == Haddr;
endproperty
assert_RENABLE_Paddr: assert property (RENABLE_Paddr);

property RENABLE_Pwrite;
	@(posedge clk) disable iff(!rst)
	CS == RENABLE && valid && !Hwrite |-> Pwrite_temp == Hwrite;
endproperty
assert_RENABLE_Pwrite: assert property (RENABLE_Pwrite);

property RENABLE_Pselx;
	@(posedge clk) disable iff(!rst)
	CS == RENABLE && valid && !Hwrite |-> Pselx_temp == tempselx;
endproperty
assert_RENABLE_Pselx: assert property (RENABLE_Pselx);

property RENABLE_Hreadyout;
	@(posedge clk) disable iff(!rst)
	CS == RENABLE && valid && !Hwrite |-> Hreadyout_temp == 0;
endproperty
assert_RENABLE_Hreadyout: assert property (RENABLE_Hreadyout);


property RENABLE_IDLE;
	@(posedge clk) disable iff(!rst)
	CS == RENABLE && (!valid || (valid && Hwrite)) |-> Pselx_temp == 0 && Penable_temp == 0 && Hreadyout_temp == 1;
endproperty
assert_RENABLE_IDLE: assert property (RENABLE_IDLE);

//WENABLEP
property WENABLEP_TO_WRITEP_OUTPUT;
	@(posedge clk) disable iff(!rst)
	CS == WENABLEP && !valid && Hwritereg |-> Paddr_temp == Haddr2 && Pwrite_temp == Hwrite && Pselx_temp == tempselx && Pwdata_temp == Hwdata && Penable_temp == 0 && Hreadyout_temp == 0;
endproperty
assert_WENABLEP_TO_WRITEP_OUTPUT: assert property (WENABLEP_TO_WRITEP_OUTPUT);

property WENABLEP_TO_WRITE_OR_READ_OUTPUT;
	@(posedge clk) disable iff(!rst)
	CS == WENABLEP && !valid && Hwritereg |-> Paddr_temp == Haddr2 && Pwrite_temp == Hwrite && Pselx_temp == tempselx && Pwdata_temp == Hwdata && Penable_temp == 0 && Hreadyout_temp == 0;
endproperty
assert_WENABLEP_TO_WRITE_OR_READ_OUTPUT: assert property (WENABLEP_TO_WRITE_OR_READ_OUTPUT);


//WENABLE

property WENABLE_TO_IDLE_OUTPUT; //
	@(posedge clk) disable iff(!rst)
	CS == WENABLE && !valid && Hwritereg |-> Pselx_temp == 0 && Penable_temp == 0 && Hreadyout_temp == 0;
endproperty
assert_WENABLE_TO_IDLE_OUTPUT: assert property (WENABLE_TO_IDLE_OUTPUT);

property WENABLE_TO_WAIT_OR_READ_OUTPUT;//
	@(posedge clk) disable iff(!rst)
	CS == WENABLE && (valid || !Hwritereg) |-> Pselx_temp == 0 && Penable_temp == 0 && Hreadyout_temp == 0;
endproperty
assert_WENABLE_TO_WAIT_OR_READ_OUTPUT: assert property (WENABLE_TO_WAIT_OR_READ_OUTPUT);

//Sequential output
//Unreachable covers
property reset;
	@(posedge clk) //use $past()
	$past(~rst) |-> Paddr == 0 && Pwrite == 0 && Pselx == 0 && Pwdata == 0 && Penable == 0 && Hreadyout == 0;
endproperty
assert_reset: assert property (reset);


//property temp;
	//@(posedge clk) 
	//!rst |-> Paddr_temp == 0 && Pwrite_temp == 0 && Pselx_temp == 0 && Pwdata_temp == 0 && Penable_temp == 0 && Hreadyout_temp == 0;
//endproperty
//assert_temp: assert property (temp);

property outputs;
	@(posedge clk) disable iff(~rst) //added a delay, and it passed
	$past(rst) == 1 |-> ##[1:$] Paddr == Paddr_temp && Pwrite == Pwrite_temp && Pselx == Pselx_temp && Pwdata == Pwdata_temp && Penable == Penable_temp && Hreadyout == Hreadyout_temp;
endproperty
assert_outputs: assert property (outputs);

endmodule

bind APB_FSM APB_FSM_sva APB_FSM_chk(.*);

