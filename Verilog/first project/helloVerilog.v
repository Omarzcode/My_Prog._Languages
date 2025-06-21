module MUX_2to1_gate(
    input x1,x2,s;
    output reg f;
);
// not (sn,s);
// and (g0,sn,s);
// and(g1,x2,s);
// or(f,g0,g1);

// assign f=(x1 & ~s)|(x2&s);
// always @ (x1,x2,s)
// begin
//     if(s)
//     begin
//     f=x2;
//     end
//     else
//     begin
//     f=x2;
//     end
// end
case (s)
    1:f=x1;
    0:f=x2 ;
    default: f=1'b0;
endcase
wire g0;
MUX_2to1_gate M0();


endmodule