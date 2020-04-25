/*
 * Created by 
   ../bin/Linux-x86_64-O/oasysGui 19.2-p002 on Wed Apr 22 05:02:31 2020
 * (C) Mentor Graphics Corporation
 */
/* CheckSum: 1957331847 */

module datapath(B, A, result);
   input [15:0]B;
   input [15:0]A;
   output [15:0]result;

   HA_X1 i_0 (.A(B[0]), .B(A[0]), .CO(n_0), .S(result[0]));
   FA_X1 i_1 (.A(B[1]), .B(A[1]), .CI(n_0), .CO(n_1), .S(result[1]));
   FA_X1 i_2 (.A(B[2]), .B(A[2]), .CI(n_1), .CO(n_2), .S(result[2]));
   FA_X1 i_3 (.A(B[3]), .B(A[3]), .CI(n_2), .CO(n_3), .S(result[3]));
   FA_X1 i_4 (.A(B[4]), .B(A[4]), .CI(n_3), .CO(n_4), .S(result[4]));
   FA_X1 i_5 (.A(B[5]), .B(A[5]), .CI(n_4), .CO(n_5), .S(result[5]));
   FA_X1 i_6 (.A(B[6]), .B(A[6]), .CI(n_5), .CO(n_6), .S(result[6]));
   FA_X1 i_7 (.A(B[7]), .B(A[7]), .CI(n_6), .CO(n_7), .S(result[7]));
   FA_X1 i_8 (.A(B[8]), .B(A[8]), .CI(n_7), .CO(n_8), .S(result[8]));
   FA_X1 i_9 (.A(B[9]), .B(A[9]), .CI(n_8), .CO(n_9), .S(result[9]));
   FA_X1 i_10 (.A(B[10]), .B(A[10]), .CI(n_9), .CO(n_10), .S(result[10]));
   FA_X1 i_11 (.A(B[11]), .B(A[11]), .CI(n_10), .CO(n_11), .S(result[11]));
   FA_X1 i_12 (.A(B[12]), .B(A[12]), .CI(n_11), .CO(n_12), .S(result[12]));
   FA_X1 i_13 (.A(B[13]), .B(A[13]), .CI(n_12), .CO(n_13), .S(result[13]));
   FA_X1 i_14 (.A(B[14]), .B(A[14]), .CI(n_13), .CO(n_14), .S(result[14]));
   XNOR2_X1 i_15 (.A(B[15]), .B(A[15]), .ZN(n_15));
   XNOR2_X1 i_16 (.A(n_15), .B(n_14), .ZN(result[15]));
endmodule

module Add_Sub(A, B, result, overflow);
   input [15:0]A;
   input [15:0]B;
   output [15:0]result;
   output overflow;

   wire n_0_1_0;
   wire n_0_1_1;
   wire n_0_1_2;

   datapath i_0_0 (.B(B), .A(A), .result(result));
   INV_X1 i_0_1_0 (.A(A[15]), .ZN(n_0_1_0));
   INV_X1 i_0_1_1 (.A(B[15]), .ZN(n_0_1_1));
   INV_X1 i_0_1_2 (.A(result[15]), .ZN(n_0_1_2));
   OAI33_X1 i_0_1_3 (.A1(n_0_1_0), .A2(n_0_1_1), .A3(result[15]), .B1(n_0_1_2), 
      .B2(B[15]), .B3(A[15]), .ZN(overflow));
endmodule
