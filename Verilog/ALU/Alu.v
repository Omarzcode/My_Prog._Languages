module ALU (
    input signed [3:0] a,b,sel,
    input clk,
    output signed [7:0] y
);

    reg signed [3:0] regA;
    reg signed [3:0] regB;
    reg signed [7:0] regY;
    reg signed [7:0] nextY;

    always @(posedge clk)
    begin
        regA<=a;
        regB<=b;
        regY<=nextY;
    end

    assign y=regY;

    always @(*) begin
        if (sel[3] == 1'b0) begin
            // Arithmetic instructions
            case (sel[2:0])
                3'b000: nextY = regA + 1;        // Increment A
                3'b001: nextY = regB + 1;        // Increment B
                3'b010: nextY = regA;            // Transfer A
                3'b011: nextY = regB;            // Transfer B
                3'b100: nextY = regA - 1;        // Decrement A
                3'b101: nextY = regA * regB;     // Multiply A and B
                3'b110: nextY = regA + regB;     // Add A and B
                3'b111: nextY = regA - regB;     // Subtract A - B
                default: nextY = 8'sd0;
            endcase
        end
    end
    
always @(*) begin
assign regA = ~regB 
end

endmodule