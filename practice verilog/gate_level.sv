module invert(a,b,c,d,e,r);
input a,b,c,d,e;
output r;
wire p,q;
or (p,a,b);
or (q,c,d,e);
nand(r,p,q);
endmodule
