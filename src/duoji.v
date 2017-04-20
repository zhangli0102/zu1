`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:54:25 03/06/2017 
// Design Name: 
// Module Name:    duoji 
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
module duoji(
    input CLK,
    input [15:0] pul_len,
    output reg CTL_PIN
    );

parameter CLK_F = 50;
reg [15:0] prescaler = 0;
reg [15:0] count = 0;

always @ (posedge CLK)
begin
  prescaler <= prescaler + 1;
  if (prescaler == CLK_F - 1)
  begin
    prescaler <= 0;
    count <= count + 1;
	 CTL_PIN <= (count < pul_len);
	 if (count == 19999)
	 begin
	   count <= 0;
    end
  end
end  

endmodule
