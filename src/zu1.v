`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:14:40 03/06/2017 
// Design Name: 
// Module Name:    yao1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module zu1(
    input CLK,
	 input rst,
    output CTL_PIN1,
	 output CTL_PIN2,
	 output CTL_PIN3,
	 output [2:0] servo_en
    );
	 
reg [15:0] pul_len1;
reg [15:0] pul_len2;
reg [15:0] pul_len3;
reg [23:0] prescaler = 0;
reg [7:0] count = 0;

duoji y1(.CLK(CLK), .pul_len(pul_len1), .CTL_PIN(CTL_PIN1));
duoji d1(.CLK(CLK), .pul_len(pul_len2), .CTL_PIN(CTL_PIN2));
duoji x1(.CLK(CLK), .pul_len(pul_len3), .CTL_PIN(CTL_PIN3));

assign servo_en = 3'b111;

always @ (posedge CLK or posedge rst)
begin
  if (rst)
  begin
    pul_len1 <= 1500;
    pul_len2 <= 1500;
    pul_len3 <= 1500;
  end
  else  
  begin
    prescaler <= prescaler + 1;
    if (prescaler == 499999)
    begin
	   prescaler <= 0;
	   count <= count + 1;
	   if (count < 25)
	   begin
		  pul_len1 <= 1500 - 8 * count;
		  pul_len2 <= 1600;
		  pul_len3 <= 1400;
	   end
	   if (count >= 25 && count < 75)
	   begin
		  pul_len1 <= 1100 + 8 * count;
		  pul_len2 <= 1400;
		  pul_len3 <= 1600;
	   end
	   if (count >= 75 && count < 100)
	   begin
		  pul_len1 <= 2300 - 8 * count;
		  pul_len2 <= 1600;
		  pul_len3 <= 1400;
      end
	   if (count == 99)
	   begin
		  count <= 0;
      end
    end
  end
end


endmodule
