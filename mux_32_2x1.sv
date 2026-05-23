`timescale 1ps / 1ps

module mux_32_2x1(one, zero, out, sel);

    input logic [31:0] one, zero; 
    input logic sel;
    output logic [31:0] out;

    genvar i;
    generate
        for(i = 0; i < 32; i++) begin : makeMux
            mux_2x1 dutt (.in({one[i], zero[i]}), .out(out[i]), .sel(sel));
        end
    endgenerate
endmodule

