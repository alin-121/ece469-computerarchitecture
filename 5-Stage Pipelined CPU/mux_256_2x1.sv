module mux_256_2x1(one, zero, out, sel);

    input  logic [255:0] one, zero; 
    input  logic         sel;
    output logic [255:0] out; 
	 
    genvar i;
	 
    generate 
        for (i = 0; i < 256; i++) begin : makeMux
            mux_2x1 combine (
                .in({one[i], zero[i]}),
                .out(out[i]),
                .sel(sel)
            );
        end 
    endgenerate 

endmodule
