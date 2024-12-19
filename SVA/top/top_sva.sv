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

/*************input addr and mode constraint*************/

assume property (@(posedge clk) Haddr>=32'h8000_0000 && Haddr<32'h8C00_0000);

assume property (@(posedge clk) Htrans == 2'b1x);


/*************back-to-back constraint*************/
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
//three invalid cycles before and after write-read pattern 

property write_follows_read1;
	@(posedge clk) disable iff(!rst)
	read_h ##1 Hwrite |-> ($past(Hwrite && Hreadyin,2));
endproperty
assume property (write_follows_read1);
//must be write-read-write

property write_follows_read2;
	@(posedge clk) disable iff(!rst)
	read_h ##1 Hwrite |-> (!Hreadyin ##1 Hwrite && !Hreadyin ##1 Hwrite && !Hreadyin ##1 write_h);
endproperty
assume property (write_follows_read2);
//three invalid cycles before and after write-read pattern

/***************burst constraint***************/
//burst read 
property burst_read_pre;
	@(posedge clk) disable iff(!rst)
	read_h ##1 !Hwrite ##1 read_h|-> (!$past(Hwrite,3) && !$past(Hwrite,4) && !$past(Hwrite,5)) || ($past(!Hreadyin,3) && $past(!Hreadyin,4) && $past(!Hreadyin,5));
endproperty
assume property (burst_read_pre);

property burst_read_post;
	@(posedge clk) disable iff(!rst)
	(read_h ##1 !Hwrite ##1 read_h) |-> $past(!Hreadyin,3) && $past(!Hreadyin,1) ##1 !Hreadyin ##1 Hreadyin;
endproperty
assume property (burst_read_post);
//Hreadyin pattern for burst read
//make sure that there are no valid write in 3 cycles before burst read starts

//burst write
property burst_write_pre;
	@(posedge clk) disable iff(!rst)
	Hwrite ##1 Hwrite ##1 Hwrite|-> ($past(Hwrite,3) && $past(Hwrite,4)) || ($past(!Hreadyin,3) && $past(!Hreadyin,4));
endproperty
assume property (burst_write_pre);
//make sure that there are no valid read in 2 cycles before burst write starts

property burst_write_start;
	@(posedge clk) disable iff(!rst)
	 write_h ##1 write_h |-> ##1 Hwrite && !Hreadyin ##1 Hreadyin;
endproperty
assume property (burst_write_start);
//start pattern of burst write

property burst_write_body;
	@(posedge clk) disable iff(!rst)
	write_h ##1 Hwrite && !Hreadyin ##1 write_h |-> ($past(Hwrite && Hreadyin,3)) || ($past(Hwrite,3) && $past(Hwrite,4));
endproperty
assume property (burst_write_body);
//when burst write body pattern occurs, it follows either start pattern or body pattern
 
property burst_write_post;
	@(posedge clk) disable iff(!rst)
	//write_h ##1 Hwrite && !Hreadyin ##1 write_h |-> ##1 !Hreadyin ##1 Hreadyin;
	write_h ##1 Hwrite ##1 write_h |-> $past(!Hreadyin,1) ##1 !Hreadyin ##1 Hreadyin;
endproperty
assume property (burst_write_post);

property burst_write_Hwrite;
	@(posedge clk) disable iff(!rst)
	 write_h ##1 Hwrite && !Hreadyin |-> ##1 Hwrite ;
endproperty
assume property (burst_write_Hwrite);

property burst_Hwdata1;
	@(posedge clk) disable iff(!rst)
	burst_write1 |-> ##2 (Hwdata == $past(Hwdata,1));
endproperty 
assume property (burst_Hwdata1);
	
property burst_Hwdata2;
	@(posedge clk) disable iff(!rst)
	burst_write1 ##1 (burst_write2[*]) |-> ##2 (Hwdata == $past(Hwdata,1));
endproperty 
assume property (burst_Hwdata2);

//reset check
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
	Hwrite && Hreadyin;
endsequence

sequence read_h;
	!Hwrite && Hreadyin;
endsequence

//single read/write check---------//use testbench to test single read and write case

/*************burst write check*************/

property read_data_transfer;
	@(posedge clk) disable iff(!rst)
	!Pwrite && Penable |-> Hrdata == Prdata;
endproperty

sequence burst_read;
	read_h ##1 !Hwrite && !Hreadyin ##1 read_h;
endsequence

property read_Pwrite;         
	@(posedge clk) disable iff(!rst)
	burst_read |-> $past(!Pwrite);
endproperty

property read_Penable;
	@(posedge clk) disable iff(!rst)
	burst_read |-> Penable ##1 !Penable ##1 Penable ##1 !Penable;
endproperty

property burst_read_addr;
	@(posedge clk) disable iff(!rst)
	//addr0 ##0 burst_read |-> $past(Pselx[0],1) && Pselx[0] && $onehot(Pselx);
	burst_read |-> Paddr == $past(Haddr,2) && $past(Paddr,1) == $past(Haddr,2);
endproperty

/*************burst write check*************/

property write_Pwrite;
	@(posedge clk) disable iff(!rst)
	write_h ##1 Hwrite |-> ##1 Pwrite;
endproperty

sequence burst_write1;
	write_h ##1 write_h ;
endsequence 

sequence burst_write2;
	Hwrite && !Hreadyin ##1 write_h ;
endsequence

property burst_write_data1;
	@(posedge clk) disable iff(!rst)
	burst_write1 |-> ##1 (Pwdata == $past(Hwdata,1)) ##1 (Pwdata == $past(Hwdata,2))  ##1 (Pwdata == $past(Hwdata,2)) ##1 (Pwdata == $past(Hwdata,2));
endproperty

property burst_write_data2;
	@(posedge clk) disable iff(!rst)
	burst_write1 ##1 (burst_write2[*]) |-> ##3 (Pwdata == $past(Hwdata,2)) ##1 (Pwdata == $past(Hwdata,2)) && Pwdata == $past(Pwdata,1);
endproperty

property write_Penable1;
	@(posedge clk) disable iff(!rst)
	burst_write1 |-> ##2 Penable ##1 !Penable ##1 Penable;
endproperty

property write_Penable2;	
	@(posedge clk) disable iff(!rst)
	burst_write1 ##1 (burst_write2[*]) |-> ##1 !Penable ##1 Penable ##1 !Penable;
	//write_h ##1 Hwrite && !Hreadyin ##1 write_h |-> ##4 Penable ##1 !Penable ##1 Penable;
endproperty

property burst_write_addr1;
	@(posedge clk) disable iff(!rst)
	burst_write1 |-> ##1 Paddr == $past(Haddr,2) ##1 Paddr == $past(Haddr,3);
endproperty

property burst_write_addr2;
	@(posedge clk) disable iff(!rst)
	burst_write1 ##1 burst_write2 |-> ##1 Paddr == $past(Haddr,3) ##1 Paddr == $past(Paddr,1);
endproperty


/*************back-to-back check*************/

property back_to_back_Paddr;
	@(posedge clk) disable iff(!rst)
	write_p ##1 read_p |-> ##1  $past(Paddr,2) == $past(Paddr);
endproperty

//Penable check
property back_to_back_Penable;
	@(posedge clk) disable iff(!rst)
	write_h ##1 read_h |-> ##2 Penable ##1 !Penable ##1 Penable;
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

//check read addr 
property read_after_write_addr;
	@(posedge clk) disable iff(!rst)
	write_h ##1 read_h |-> ##3 (Paddr == $past(Haddr,3)) ##1 (Paddr == $past(Paddr,1));
endproperty	 

//check write addr
property write_after_read_addr;
	@(posedge clk) disable iff(!rst)
	read_h ##1 !Hreadyin ##1 !Hreadyin ##1 !Hreadyin ##1 write_h |-> ##2 (Paddr == $past(Haddr,2)) ##1 (Paddr == $past(Paddr,1));
endproperty

//check data
property back2back_data;
	@(posedge clk) disable iff(!rst)
	write_h ##1 read_h |-> ##1 (Pwdata == $past(Hwdata));
endproperty

property back2back_Pwrite;
	@(posedge clk) disable iff(!rst)
	write_h ##1 read_h |-> ##1 Pwrite ##1 Pwrite ##1 !Pwrite ##1 !Pwrite;
endproperty

//failed check -- psel
//burst write
property burst_write_psel0;
	@(posedge clk) disable iff(!rst)
	addr0 ##0 burst_write1 |-> ##1 psel_s0;
endproperty


//assertion check
Reset_check_Paddr: assert property (reset_check_Paddr);
Reset_check_Penable: assert property (reset_check_Penable);

Read_data_transfer: assert property (read_data_transfer);
Read_Pwrite: assert property (read_Pwrite);
Read_Penable: assert property (read_Penable);
Burst_read_addr: assert property (burst_read_addr);

Burst_write_data1: assert property (burst_write_data1);
Burst_write_data2: assert property (burst_write_data2);
Write_Pwrite: assert property (write_Pwrite);
Write_Penable1: assert property (write_Penable1);
Write_Penable2: assert property (write_Penable2);
Burst_write_addr1: assert property (burst_write_addr1);
Burst_write_addr2: assert property (burst_write_addr2);

Back_to_back_Penable: assert property (back_to_back_Penable);
Back_to_back_Paddr: assert property (back_to_back_Paddr);
Read_after_write_addr: assert property (read_after_write_addr);
Write_after_read_addr: assert property (write_after_read_addr);
Back2back_data: assert property (back2back_data);

Back2back_Pwrite: assert property (back2back_Pwrite);
Burst_write_psel0: assert property (burst_write_psel0);

endmodule


bind Bridge_Top top_sva chk_top (.clk(clk), .rst(rst), .Hwrite(Hwrite), .Hreadyin(Hreadyin), .Hwdata(Hwdata), .Haddr(Haddr), .Htrans(Htrans), .Prdata(Prdata), .Pselx(Pselx), .Paddr(Paddr), .Pwdata(Pwdata), .Penable(Penable), .Pwrite(Pwrite), .Hreadyout(Hreadyout), .Hresp(Hresp), .Hrdata(Hrdata));


 

