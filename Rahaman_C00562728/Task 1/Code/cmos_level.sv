module transistor_level(a,b,c,d,e,out);
input a,b,c,d,e;
output out;
wire PD1,PD2,PD3,ND1,out;

pmos ( PD1, 1, a);
pmos ( out, PD1, b);
pmos ( PD2, 1, c);
pmos ( PD3, PD2, d);
pmos ( out, PD3, e);

nmos ( out, ND1, c);
nmos ( out, ND1, d);
nmos ( out, ND1, e);
nmos ( ND1, 0, a);
nmos ( ND1, 0, b);
endmodule
