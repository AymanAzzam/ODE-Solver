**All files run on modelsim 
the main two modules i implement this phase of adder/sub
are CSA.v and look2.v 
however i implement two different designs of carry look ahead
CLA.v and CLA2.v 
But look2.v was most optimize version of Carry Look ahead 

To use module for add two numbers  

Add_Sub #(16)mod1(.A(a), 
	.B(b), 
	.result(res), 
	.overflow(err),
	.cin('b0));
endmodule

** to subtracte two numbers

Add_Sub #(16)mod1(.A(a), 
	.B(~b), 
	.result(res), 
	.overflow(err),
	.cin('b1));
endmodule
