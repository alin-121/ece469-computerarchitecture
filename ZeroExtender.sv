module ZeroExtender #(parameter INPUT = 64, parameter EXTEND_TO = 64) (in, out);

    input  logic [INPUT-1:0] in;
    output logic [EXTEND_TO-1:0] out;

    assign out = {{(EXTEND_TO - INPUT){1'b0}}, in};

endmodule
