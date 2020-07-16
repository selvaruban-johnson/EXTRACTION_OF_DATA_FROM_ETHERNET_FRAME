 module EOD_from_ethernet_frame
(input clk,in_valid,in_sop,in_eop,[31:0]in_data,
output logic out_valid,logic [31:0]src_ip,[15:0]src_port);
reg [31:0] frame;
reg [31:0]src_ip_frame;
reg [15:0]src_port_frame;
bit [3:0]count;
always @(posedge clk)
begin
	if(in_valid && in_sop)
	begin
		count <= 0;
		src_ip <= 0;
		src_port <= 0;
		out_valid <= 0;
		src_ip_frame <= 0;
		src_port_frame <= 0;
	end
	
	else if(in_valid && in_eop && count == 4'd15)
	begin
		count <= 4'd0;
		out_valid <= 1'b1;
		src_ip <= src_ip_frame;
		src_port <= src_port_frame;
	end

	else
	begin
	count <= count +1'b1;
	if(count == 4'd8)
		src_ip_frame <= in_data;
	if(count == 4'd10)
		src_port_frame <= in_data[31:16] ;		
	end
end	
endmodule 