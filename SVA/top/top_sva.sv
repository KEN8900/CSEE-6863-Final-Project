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

let possible_Pselx = ((Pselx == 0) || (Pselx == 1) || (Pselx == 2) || (Pselx == 4));

//input constraint
let valid_addr = Haddr>=32'h8000_0000 && Haddr<32'h8C00_0000;
assume property (@(posedge clk) Haddr>=32'h8000_0000 && Haddr<32'h8C00_0000);
assume property (@(posedge clk) Htrans == 2'b1x);

property burst_read_Hreadyin;
	@(posedge clk) disable iff(!rst)
	 //Hreadyin && !Hwrite |-> ##1 !Hreadyin;
	(read_h ##1 !Hwrite ##1 read_h) |-> $past(Hreadyin,2) && $past(!Hreadyin,1) && Hreadyin;
endproperty
assume property (burst_read_Hreadyin);

property burst_write_Hreadyin_1;
	@(posedge clk) disable iff(!rst)
	 write_h ##1 write_h |-> ##1 Hwrite && !Hreadyin ##1 Hreadyin;
endproperty
assume property (burst_write_Hreadyin_1);

property burst_write_Hreadyin_2;
	@(posedge clk) disable iff(!rst)
	 Hwrite && !Hreadyin ##1 write_h ##1 Hwrite && !Hreadyin |-> !Hreadyin;
endproperty
assume property (burst_write_Hreadyin_2);

property burst_write_Hreadyin_3;
	@(posedge clk) disable iff(!rst)
	 write_h ##1 Hwrite && !Hreadyin |-> ##1 Hwrite ;
endproperty
assume property (burst_write_Hreadyin_3);

//back-to-back constraint
property read_follows_write1;
	@(posedge clk) disable iff(!rst)
	write_h ##1 read_h |-> ##1 !Hreadyin ##1 !Hreadyin ##1 !Hreadyin;
endproperty
assume property (read_follows_write1);

property read_follows_write2;
	@(posedge clk) disable iff(!rst)
	write_h ##1 read_h |-> $past(!Hreadyin,2) && $past(!Hreadyin,3) && $past(!Hreadyin,4);
endproperty
assume property (read_follows_write2);

property write_follows_read1;
	@(posedge clk) disable iff(!rst)
	read_h ##1 Hwrite |-> ($past(Hwrite && Hreadyin,2));
endproperty
assume property (write_follows_read1);

property write_follows_read2;
	@(posedge clk) disable iff(!rst)
	read_h ##1 Hwrite |-> (!Hreadyin ##1 Hwrite && !Hreadyin ##1 Hwrite && !Hreadyin ##1 write_h);
endproperty
assume property (write_follows_read2);

//burst constraint
property burst_read_Hwrite;
	@(posedge clk) disable iff(!rst)
	!Hwrite ##1 !Hwrite ##1 !Hwrite|-> !$past(Hwrite,3) && !$past(Hwrite,4) && !$past(Hwrite,5) ;
endproperty
assume property (burst_read_Hwrite);

property burst_write_Hwrite;
	@(posedge clk) disable iff(!rst)
	Hwrite ##1 Hwrite ##1 Hwrite|-> $past(Hwrite,3) && $past(Hwrite,4);
endproperty
assume property (burst_write_Hwrite);


//reset 
property reset_check_Paddr;
    @(posedge clk)
        $rose(rst) |-> Paddr == 0;  
endproperty

property reset_check_Penable;
    @(posedge clk)
        $rose(rst) |-> Penable == 0;  
endproperty

//APB output waveform discription
sequence write_p; 
        Pwrite &&  possible_Pselx  && !Penable ##1 Pwrite && possible_Pselx && Penable;
endsequence

sequence read_p; 
        !Pwrite && possible_Pselx && !Penable ##1 !Pwrite && possible_Pselx && Penable;
endsequence

//AHB valid input waveform discription
sequence write_h;
	valid_addr && Hwrite && Hreadyin;
endsequence

sequence read_h;
	valid_addr && !Hwrite && Hreadyin;
endsequence

//back to back check
//read after write
property read_after_write1;
	@(posedge clk) disable iff(!rst)
	write_h ##1 read_h |-> ##1 !Penable ##1 Penable ##1 !Penable ##1 Penable;
endproperty

property read_after_write2;
	@(posedge clk) disable iff(!rst)
	write_p ##1 read_p |-> ##1  $past(Paddr,2) == $past(Paddr);
endproperty

//pselx check: pselx should hold for 2 cycles
//For Address range 8000_0000 to 8400_0000
sequence psel_s0;
	$onehot(Pselx) ##0 (Pselx[0] ##1 Pselx[0]);
endsequence

//For Address range 8400_0000 to 8800_0000
sequence psel_s1;
	$onehot(Pselx) ##0 (Pselx[1] ##1 Pselx[1]);
endsequence

//For Address range 8800_0000 to 8C00_0000
sequence psel_s2;
	$onehot(Pselx) ##0 (Pselx[2] ##1 Pselx[2]);
endsequence

//burst read check
property read_data_transfer;
	@(posedge clk) disable iff(!rst)
	Penable |-> Hrdata == Prdata;
endproperty

property read_Pwrite;         
	@(posedge clk) disable iff(!rst)
	read_h ##1 !Hwrite ##1 read_h |-> $past(!Pwrite);
endproperty
//burst write check
property write_Pwrite;
	@(posedge clk) disable iff(!rst)
	write_h ##1 Hwrite |-> ##1 Pwrite;
endproperty




//assertion check
Reset_check_Paddr: assert property (reset_check_Paddr);
Reset_check_Penable: assert property (reset_check_Penable);
Read_after_write1: assert property (read_after_write1);
Read_after_write2: assert property (read_after_write2);
Read_data_transfer: assert property (read_data_transfer);
Read_Pwrite: assert property (read_Pwrite);
Write_Pwrite: assert property (write_Pwrite);


endmodule


bind Bridge_Top top_sva chk_top (.clk(clk), .rst(rst), .Hwrite(Hwrite), .Hreadyin(Hreadyin), .Hwdata(Hwdata), .Haddr(Haddr), .Htrans(Htrans), .Prdata(Prdata), .Pselx(Pselx), .Paddr(Paddr), .Pwdata(Pwdata), .Penable(Penable), .Pwrite(Pwrite), .Hreadyout(Hreadyout), .Hresp(Hresp), .Hrdata(Hrdata));


 

