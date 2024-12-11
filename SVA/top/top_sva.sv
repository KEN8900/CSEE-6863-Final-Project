module top_sva(input logic clk,
                      input logic rst,
                      input logic Hwrite,
                      input logic Hreadyin,
                      input logic [31:0] Hwdata,
                      input logic [31:0] Haddr,
                      input logic [1:0] Htrans,
                      input logic [31:0] Prdata,
                      input logic [2:0] Pselx,
                      input logic [31:0] Paddr,
                      input logic [31:0] Pwdata,
                      input logic Penable,
                      input logic Pwrite,
                      input logic Hreadyout,
                      input logic [1:0] Hresp,
                      input logic [31:0] Hrdata);
let addr0 = Haddr>=32'h8000_0000 && Haddr<32'h8400_0000;
let addr1 = Haddr>=32'h8400_0000 && Haddr<32'h8800_0000;
let addr2 = Haddr>=32'h8800_0000 && Haddr<32'h8C00_0000;


// non sequential 
sequence nonseq_write;
  	Htrans == 2'b10 && Hwrite && Hreadyin;
endsequence

sequence nonseq_read;
  	Htrans == 2'b10 && !Hwrite && Hreadyin;
endsequence



property nonseq_write_check;
     	@(posedge clk) disable iff (!rst)
  	nonseq_write |-> ##[1:$] (Pwrite && Paddr == Haddr && Pwdata == Hwdata);
endproperty

assert_nonseq_write: assert property (nonseq_write_check)
  	else $error("Non-sequential write failed");

property nonseq_read_check;
  	@(posedge clk) disable iff (!rst)
  	nonseq_read |-> ##[1:$] (!Pwrite && Paddr == Haddr && Prdata == Hrdata);
endproperty

assert_nonseq_read: assert property (nonseq_read_check)
  	else $error("Non-sequential read failed");

property nonseq_timing;
  	@(posedge clk) disable iff (!rst)
  	nonseq_read |-> ##[2:$] (Penable && Pselx != 0);
endproperty

assert_nonseq_timing: assert property (nonseq_timing)
  	else $error("Timing mismatch in non-sequential transaction");


property nonseq_pselx_valid;
  	@(posedge clk) disable iff (!rst)
  	nonseq_read |-> ##[1:$] (
    	($onehot(Pselx) || Pselx == 3'b000) &&
    	(($past(Pselx) == 3'b001 && addr0) ||
     	($past(Pselx) == 3'b010 && addr1) ||
     	($past(Pselx) == 3'b100 && addr2))
  );
endproperty

assert_nonseq_pselx: assert property (nonseq_pselx_valid)
  else $error("PSEL is not one-hot during non-sequential transaction");

property seq_pselx_valid;
  @(posedge clk) disable iff (!rst)
  (Htrans == 2'b11 && Hwrite && Hreadyin) |-> ##[1:$] $onehot(Pselx);
endproperty

assert_seq_pselx: assert property (seq_pselx_valid)
  else $error("PSEL is not one-hot during sequential write transaction");

property reset_pselx_check;
  @(posedge clk)
  $rose(rst) |-> (Pselx == 3'b000);
endproperty

assert_reset_pselx: assert property (reset_pselx_check)
  else $error("PSEL not correctly reset");



endmodule


bind Bridge_Top top_sva chk_top (.clk(clk), .rst(rst), .Hwrite(Hwrite), .Hreadyin(Hreadyin), .Hwdata(Hwdata), .Haddr(Haddr), .Htrans(Htrans), .Prdata(Prdata), .Pselx(Pselx), .Paddr(Paddr), .Pwdata(Pwdata), .Penable(Penable), .Pwrite(Pwrite), .Hreadyout(Hreadyout), .Hresp(Hresp), .Hrdata(Hrdata));


 

