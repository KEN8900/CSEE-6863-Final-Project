
module APB_FSM( clk,rst,valid,Haddr1,Haddr2,Hwdata1,Hwdata2,Prdata,Hwrite,Haddr,Hwdata,Hwritereg,tempselx, 
			   Pwrite,Penable,Pselx,Paddr,Pwdata,Hreadyout);

input clk,rst,valid,Hwrite,Hwritereg;
input [31:0] Hwdata,Haddr,Haddr1,Haddr2,Hwdata1,Hwdata2,Prdata;
input [2:0] tempselx;
output reg Pwrite,Penable;
output reg Hreadyout;  
output reg [2:0] Pselx;
output reg [31:0] Paddr,Pwdata;


//////////////////////////////////////////////////////states

parameter IDLE=3'b000;
parameter WAIT=3'b001;
parameter READ= 3'b010;
parameter WRITE=3'b011;
parameter WRITEP=3'b100;
parameter RENABLE=3'b101;
parameter WENABLE=3'b110;
parameter WENABLEP=3'b111;


//////////////////////////////////////////////////// PRESENT STATE LOGIC

reg [2:0] CS,NS;

always @(posedge clk or negedge rst)
 begin:CS_LOGIC
  if (~rst)
    CS<=IDLE;
  else
    CS<=NS;
 end


/////////////////////////////////////////////////////// NEXT STATE LOGIC

always @(CS,valid,Hwrite,Hwritereg)
 begin:NS_LOGIC
  case (CS)
    
 	IDLE:begin
		 if (~valid)
		  NS=IDLE;
		 else if (valid && Hwrite)
		  NS=WAIT;
		 else 
		  NS=READ;
		end    

	WAIT:begin
		 if (~valid)
		  NS=WRITE;
		 else
		  NS=WRITEP;
		end

	READ: begin
		   NS=RENABLE;
		 end

	WRITE:begin
		  if (~valid)
		   NS=WENABLE;
		  else
		   NS=WENABLEP;
		 end

	WRITEP:begin
		   NS=WENABLEP;
		  end

	RENABLE:begin
		     if (~valid)
		      NS=IDLE;
		     else if (valid && Hwrite)
		      NS=WAIT;
		     else
		      NS=READ;
		   end

	WENABLE:begin
		     if (~valid)
		      NS=IDLE;
		     else if (valid && Hwrite)
		      NS=WAIT;
		     else
		      NS=READ;
		   end

	WENABLEP:begin
		      if (~valid && Hwritereg)
		       NS=WRITE;
		      else if (valid && Hwritereg)
		       NS=WRITEP;
		      else
		       NS=READ;
		    end

	default: begin
		   NS=IDLE;
		  end
  endcase
 end


////////////////////////////////////////////////////////OUTPUT LOGIC:COMBINATIONAL


reg Penable_temp,Hreadyout_temp,Pwrite_temp;
reg [2:0] Pselx_temp;
reg [31:0] Paddr_temp, Pwdata_temp;

always @(*)
 begin:OUTPUT_COMBINATIONAL_LOGIC
   case(CS)
    
	IDLE: begin
			  if (valid && ~Hwrite) 
			   begin:IDLE_TO_READ
			        Paddr_temp=Haddr;
				Pwrite_temp=Hwrite;
				Pselx_temp=tempselx;
				Penable_temp=0;
				Hreadyout_temp=0;
			   end
			  
			  else if (valid && Hwrite)
			   begin:IDLE_TO_WWAIT
			        Pselx_temp=0;
				//Pselx_temp=tempselx;
				Penable_temp=0;
				Hreadyout_temp=1;			   
			   end
			   
			  else
                            begin:IDLE_TO_IDLE
			        Pselx_temp=0;
				Penable_temp=0;
				Hreadyout_temp=1;
				Paddr_temp='0;
				Pwrite_temp='0;	
			   end
		     end    

	WAIT:begin
	          if (~valid) 
			   begin:WAIT_TO_WRITE
			    Paddr_temp=Haddr1;
				Pwrite_temp=1;
				Pselx_temp=tempselx;
				Penable_temp=0;
				Pwdata_temp=Hwdata;
				Hreadyout_temp=0;
			   end
			  
			  else 
			   begin:WAIT_TO_WRITEP
			    Paddr_temp=Haddr1;
				Pwrite_temp=1;
				Pselx_temp=tempselx;
				Pwdata_temp=Hwdata;
				Penable_temp=0;
				Hreadyout_temp=0;		   
			   end
			   
		     end  

	READ: begin:READ_TO_RENABLE
			  Penable_temp=1;
			  Hreadyout_temp=1;
		     end

	WRITE:begin
              if (~valid) 
			   begin:WRITE_TO_WENABLE
				Penable_temp=1;
				Hreadyout_temp=1;
			   end
			  
			  else 
			   begin:WRITE_TO_WENABLEP ///DOUBT
				Penable_temp=1;
				Hreadyout_temp=1;		   
			   end
		     end

	WRITEP:begin:WRITEP_TO_WENABLEP
               Penable_temp=1;
			   Hreadyout_temp=1;
		      end

	RENABLE:begin
	            if (valid && ~Hwrite) 
				 begin:RENABLE_TO_READ
					Paddr_temp=Haddr;
					Pwrite_temp=Hwrite;
					Pselx_temp=tempselx;
					Penable_temp=0;
					Hreadyout_temp=0;
				 end
			  
			  else if (valid && Hwrite)
			    begin:RENABLE_TO_WWAIT
			     Pselx_temp=0;
				 Penable_temp=0;
				 Hreadyout_temp=1;			   
			    end
			   
			  else
                begin:RENABLE_TO_IDLE
			     Pselx_temp=0;
				 Penable_temp=0;
				 Hreadyout_temp=1;	
			    end

		       end

	WENABLEP:begin
                 if (~valid && Hwritereg) 
			      begin:WENABLEP_TO_WRITEP
			       Paddr_temp=Haddr2;
				   Pwrite_temp=Hwrite;
				   Pselx_temp=tempselx;
				   Penable_temp=0;
				   Pwdata_temp=Hwdata;
				   Hreadyout_temp=0;
				  end

			  
			    else 
			     begin:WENABLEP_TO_WRITE_OR_READ /////DOUBT
			      Paddr_temp=Haddr2;
				  Pwrite_temp=Hwrite;
				  Pselx_temp=tempselx;
				  Pwdata_temp=Hwdata;
				  Penable_temp=0;
				  Hreadyout_temp=0;		   
			     end
		        end

	WENABLE :begin
	             if (~valid && Hwritereg) 
			      begin:WENABLE_TO_IDLE
				   Pselx_temp=0;
				   Penable_temp=0;
				   Hreadyout_temp=0;
				  end

			  
			    else 
			     begin:WENABLE_TO_WAIT_OR_READ /////DOUBT
				  Pselx_temp=0;
				  Penable_temp=0;
				  Hreadyout_temp=0;		   
			     end

		        end

 endcase
end


////////////////////////////////////////////////////////OUTPUT LOGIC:SEQUENTIAL

always @(posedge clk or negedge rst)
 begin
  
  if (~rst)
   begin
    Paddr<=0;
	Pwrite<=0;
	Pselx<=0;
	Pwdata<=0;
	Penable<=0;
	Hreadyout<=0;
   end
  
  else
   begin
        Paddr<=Paddr_temp;
	Pwrite<=Pwrite_temp;
	Pselx<=Pselx_temp;
	Pwdata<=Pwdata_temp;
	Penable<=Penable_temp;
	Hreadyout<=Hreadyout_temp;
   end
 end
 ///////////////////////


endmodule
