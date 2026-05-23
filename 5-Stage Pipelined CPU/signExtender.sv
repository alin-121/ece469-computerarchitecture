module signExtender #(parameter INPUT = 64, parameter EXTEND_TO = 64) (in, out);

    input  logic [INPUT-1:0] in;
    output logic [EXTEND_TO-1:0] out;

    assign out = {{(EXTEND_TO-INPUT){in[INPUT-1]}}, in};

endmodule

