module datamem(read_data,address,write_data,memread,memwrite,clk );
output reg [31:0] read_data;
input wire [31:0]address;//rg3i m3 alaa?!
input wire memwrite;
input wire memread;
input wire [31:0]write_data;//sw
input wire clk;
reg[31:0] mem[0:255];
integer file;
integer i=0;

//initial
//begin
//mem=0;
/*mem[3]=32'h3;
mem[1]=32'h00_00_00_03;
mem[2]=32'h2;
mem[4]={32{1'b1}};
;*/
//$readmemh("D:\\backend\\data_mem_read.txt",mem);
/*file=$fopen("D:\\backend\\data_mem.txt"); // mn awel hena
$fmonitor(file,"mem[%b]=%b",i,mem[i]);
for(i=0;i<255;i=i+1)
begin
#8
i=i;
end*/
//end

always @(posedge clk)
begin
$writememh("D:\\backend\\data_mem.txt",mem);
end


always @(negedge clk)
begin
if (memread==1'b1 && memwrite==1'b0)
read_data<=mem[{address[7:0]}]; // lma 7atet assign error
end
always @(posedge clk)
begin
if (memread==1'b0&&memwrite==1'b1)
mem[{address[7:0]}]<=write_data;
end
endmodule

module datamemo_tb();

wire[31:0]read_data;
reg [31:0]data_write;
reg [7:0]address;
reg memread;
reg memwrite;
reg clk;
initial
begin
clk=0;
end

datamem test_1 (read_data,address,data_write,memread,memwrite,clk );
always
begin
#2
clk=~clk;
end

initial
begin

memwrite=1'b1;
memread=1'b0;
address={8{1'b0}};
data_write={32{1'b1}};
repeat(1)@(posedge clk);
memread=1'b1;
memwrite=1'b0;
address={8{1'b0}};
repeat(1)@(posedge clk);
memread=1'b1;
memwrite=1'b0;
address={8'b0000_0100};

$monitor("data written %b and data loaded from memory %b",data_write,read_data);
end 

endmodule
