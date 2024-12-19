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
        input wire [2:0] NS

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


endmodule

bind APB_FSM APB_FSM_sva APB_FSM_chk(.*);

