/*
 * Created by 
   ../bin/Linux-x86_64-O/oasysGui 19.2-p002 on Fri Apr 24 14:41:20 2020
 * (C) Mentor Graphics Corporation
 */
/* CheckSum: 2268178722 */

module booth(prod, mc, mp, clk, reset);
   output [31:0]prod;
   input [15:0]mc;
   input [15:0]mp;
   input clk;
   input reset;

   wire [15:0]M;
   wire Q_1;
   wire [4:0]i;
   wire n_0_0;
   wire n_0_1;
   wire n_0_2;
   wire n_0_3;
   wire n_0_4;
   wire n_0_5;
   wire n_0_6;
   wire n_0_7;
   wire n_0_8;
   wire n_0_9;
   wire n_0_10;
   wire n_0_11;
   wire n_0_12;
   wire n_0_13;
   wire n_0_14;
   wire n_0_15;
   wire n_0_16;
   wire n_0_17;
   wire n_0_18;
   wire n_0_19;
   wire n_0_20;
   wire n_0_21;
   wire n_0_22;
   wire n_0_23;
   wire n_0_24;
   wire n_0_25;
   wire n_0_26;
   wire n_0_27;
   wire n_0_28;
   wire n_0_29;
   wire n_0_30;
   wire n_0_31;
   wire n_0_32;
   wire n_0_33;
   wire n_0_34;
   wire n_0_35;
   wire n_0_36;
   wire n_0_37;
   wire n_0_38;
   wire n_0_39;
   wire n_0_40;
   wire n_0_41;
   wire n_0_42;
   wire n_0_43;
   wire n_0_44;
   wire n_0_45;
   wire n_0_46;
   wire n_0_47;
   wire n_0_48;
   wire n_0_49;
   wire n_0_50;
   wire n_0_51;
   wire n_0_52;
   wire n_0_53;
   wire n_0_54;
   wire n_0_55;
   wire n_0_56;
   wire n_0_57;
   wire n_0_58;
   wire n_0_59;
   wire n_0_60;
   wire n_0_61;
   wire n_0_62;
   wire n_0_63;
   wire n_0_64;
   wire n_0_65;
   wire n_0_66;
   wire n_0_67;
   wire n_0_68;
   wire n_0_69;
   wire n_0_70;
   wire n_0_71;
   wire n_0_72;
   wire n_0_73;
   wire n_0_74;
   wire n_0_75;
   wire n_0_76;
   wire n_0_77;
   wire n_0_78;
   wire n_0_79;
   wire n_0_80;
   wire n_0_81;
   wire n_0_82;
   wire n_0_83;
   wire n_0_84;
   wire n_0_85;
   wire n_0_86;
   wire n_0_87;
   wire n_0_88;
   wire n_0_89;
   wire n_0_90;
   wire n_0_91;
   wire n_0_92;
   wire n_0_93;
   wire n_0_94;
   wire n_0_95;
   wire n_0_96;
   wire n_0_97;
   wire n_0_98;
   wire n_0_99;
   wire n_0_100;
   wire n_0_101;
   wire n_0_102;
   wire n_0_103;
   wire n_0_104;
   wire n_0_105;
   wire n_0_106;
   wire n_0_107;
   wire n_0_108;
   wire n_0_109;
   wire n_0_110;
   wire n_0_111;
   wire n_0_112;
   wire n_0_113;
   wire n_0_114;
   wire n_0_115;
   wire n_0_116;
   wire n_0_117;
   wire n_0_118;
   wire n_0_119;
   wire n_0_120;
   wire n_0_121;
   wire n_0_122;
   wire n_0_123;
   wire n_0_124;
   wire n_0_125;
   wire n_0_126;
   wire n_0_127;
   wire n_0_128;
   wire n_0_129;
   wire n_0_130;
   wire n_0_131;
   wire n_0_132;
   wire n_0_133;
   wire n_0_134;
   wire n_0_135;
   wire n_0_136;
   wire n_0_137;
   wire n_0_138;
   wire n_0_139;
   wire n_0_140;
   wire n_0_141;
   wire n_0_142;
   wire n_0_143;
   wire n_0_144;
   wire n_0_145;
   wire n_0_146;
   wire n_0_147;
   wire n_0_148;
   wire n_0_149;
   wire n_0_150;
   wire n_0_151;
   wire n_0_152;
   wire n_0_153;
   wire n_0_154;
   wire n_0_155;
   wire n_0_156;
   wire n_0_157;
   wire n_0_158;
   wire n_0_159;
   wire n_0_160;
   wire n_0_161;
   wire n_0_162;
   wire n_0_163;
   wire n_0_164;
   wire n_0_165;
   wire n_0_166;
   wire n_0_167;
   wire n_0_168;
   wire n_0_169;
   wire n_0_170;
   wire n_0_171;
   wire n_0_172;
   wire n_0_173;
   wire n_0_174;
   wire n_0_175;
   wire n_0_176;
   wire n_0_177;
   wire n_0_178;
   wire n_0_179;
   wire n_0_180;
   wire n_0_181;
   wire n_0_182;
   wire n_0_183;
   wire n_0_184;
   wire n_0_185;
   wire n_0_186;
   wire n_0_187;

   DFF_X1 \A_reg[14]  (.D(n_16), .CK(n_1), .Q(prod[30]), .QN());
   DFF_X1 \A_reg[13]  (.D(n_15), .CK(n_1), .Q(prod[29]), .QN());
   DFF_X1 \A_reg[12]  (.D(n_14), .CK(n_1), .Q(prod[28]), .QN());
   DFF_X1 \A_reg[11]  (.D(n_13), .CK(n_1), .Q(prod[27]), .QN());
   DFF_X1 \A_reg[10]  (.D(n_12), .CK(n_1), .Q(prod[26]), .QN());
   DFF_X1 \A_reg[9]  (.D(n_11), .CK(n_1), .Q(prod[25]), .QN());
   DFF_X1 \A_reg[8]  (.D(n_10), .CK(n_1), .Q(prod[24]), .QN());
   DFF_X1 \A_reg[7]  (.D(n_9), .CK(n_1), .Q(prod[23]), .QN());
   DFF_X1 \A_reg[6]  (.D(n_8), .CK(n_1), .Q(prod[22]), .QN());
   DFF_X1 \A_reg[5]  (.D(n_7), .CK(n_1), .Q(prod[21]), .QN());
   DFF_X1 \A_reg[4]  (.D(n_6), .CK(n_1), .Q(prod[20]), .QN());
   DFF_X1 \A_reg[3]  (.D(n_5), .CK(n_1), .Q(prod[19]), .QN());
   DFF_X1 \A_reg[2]  (.D(n_4), .CK(n_1), .Q(prod[18]), .QN());
   DFF_X1 \A_reg[1]  (.D(n_3), .CK(n_1), .Q(prod[17]), .QN());
   DFF_X1 \A_reg[0]  (.D(n_2), .CK(n_1), .Q(prod[16]), .QN());
   CLKGATETST_X1 clk_gate_M_reg (.CK(clk), .E(reset), .SE(1'b0), .GCK(n_0));
   DFF_X1 \M_reg[15]  (.D(mc[15]), .CK(n_0), .Q(M[15]), .QN());
   DFF_X1 \M_reg[14]  (.D(mc[14]), .CK(n_0), .Q(M[14]), .QN());
   DFF_X1 \M_reg[13]  (.D(mc[13]), .CK(n_0), .Q(M[13]), .QN());
   DFF_X1 \M_reg[12]  (.D(mc[12]), .CK(n_0), .Q(M[12]), .QN());
   DFF_X1 \M_reg[11]  (.D(mc[11]), .CK(n_0), .Q(M[11]), .QN());
   DFF_X1 \M_reg[10]  (.D(mc[10]), .CK(n_0), .Q(M[10]), .QN());
   DFF_X1 \M_reg[9]  (.D(mc[9]), .CK(n_0), .Q(M[9]), .QN());
   DFF_X1 \M_reg[8]  (.D(mc[8]), .CK(n_0), .Q(M[8]), .QN());
   DFF_X1 \M_reg[7]  (.D(mc[7]), .CK(n_0), .Q(M[7]), .QN());
   DFF_X1 \M_reg[6]  (.D(mc[6]), .CK(n_0), .Q(M[6]), .QN());
   DFF_X1 \M_reg[5]  (.D(mc[5]), .CK(n_0), .Q(M[5]), .QN());
   DFF_X1 \M_reg[4]  (.D(mc[4]), .CK(n_0), .Q(M[4]), .QN());
   DFF_X1 \M_reg[3]  (.D(mc[3]), .CK(n_0), .Q(M[3]), .QN());
   DFF_X1 \M_reg[2]  (.D(mc[2]), .CK(n_0), .Q(M[2]), .QN());
   DFF_X1 \M_reg[1]  (.D(mc[1]), .CK(n_0), .Q(M[1]), .QN());
   DFF_X1 \M_reg[0]  (.D(mc[0]), .CK(n_0), .Q(M[0]), .QN());
   DFF_X1 \Q_reg[15]  (.D(n_32), .CK(n_1), .Q(prod[15]), .QN());
   DFF_X1 \Q_reg[14]  (.D(n_31), .CK(n_1), .Q(prod[14]), .QN());
   DFF_X1 \Q_reg[13]  (.D(n_30), .CK(n_1), .Q(prod[13]), .QN());
   DFF_X1 \Q_reg[12]  (.D(n_29), .CK(n_1), .Q(prod[12]), .QN());
   DFF_X1 \Q_reg[11]  (.D(n_28), .CK(n_1), .Q(prod[11]), .QN());
   DFF_X1 \Q_reg[10]  (.D(n_27), .CK(n_1), .Q(prod[10]), .QN());
   DFF_X1 \Q_reg[9]  (.D(n_26), .CK(n_1), .Q(prod[9]), .QN());
   DFF_X1 \Q_reg[8]  (.D(n_25), .CK(n_1), .Q(prod[8]), .QN());
   DFF_X1 \Q_reg[7]  (.D(n_24), .CK(n_1), .Q(prod[7]), .QN());
   DFF_X1 \Q_reg[6]  (.D(n_23), .CK(n_1), .Q(prod[6]), .QN());
   DFF_X1 \Q_reg[5]  (.D(n_22), .CK(n_1), .Q(prod[5]), .QN());
   DFF_X1 \Q_reg[4]  (.D(n_21), .CK(n_1), .Q(prod[4]), .QN());
   DFF_X1 \Q_reg[3]  (.D(n_20), .CK(n_1), .Q(prod[3]), .QN());
   DFF_X1 \Q_reg[2]  (.D(n_19), .CK(n_1), .Q(prod[2]), .QN());
   DFF_X1 \Q_reg[1]  (.D(n_18), .CK(n_1), .Q(prod[1]), .QN());
   DFF_X1 \Q_reg[0]  (.D(n_17), .CK(n_1), .Q(prod[0]), .QN());
   DFF_X1 Q_1_reg (.D(n_39), .CK(n_1), .Q(Q_1), .QN());
   DFF_X1 \i_reg[4]  (.D(n_38), .CK(n_1), .Q(i[4]), .QN());
   DFF_X1 \i_reg[3]  (.D(n_37), .CK(n_1), .Q(i[3]), .QN());
   DFF_X1 \i_reg[2]  (.D(n_36), .CK(n_1), .Q(i[2]), .QN());
   DFF_X1 \i_reg[1]  (.D(n_35), .CK(n_1), .Q(i[1]), .QN());
   DFF_X1 \i_reg[0]  (.D(n_34), .CK(n_1), .Q(i[0]), .QN());
   CLKGATETST_X1 clk_gate_A_reg (.CK(clk), .E(n_33), .SE(1'b0), .GCK(n_1));
   AOI21_X1 i_0_0 (.A(n_0_0), .B1(n_0_2), .B2(n_0_1), .ZN(n_2));
   OAI21_X1 i_0_1 (.A(n_0_163), .B1(n_0_2), .B2(n_0_1), .ZN(n_0_0));
   AOI22_X1 i_0_2 (.A1(prod[17]), .A2(M[1]), .B1(n_0_178), .B2(n_0_164), 
      .ZN(n_0_1));
   AOI221_X1 i_0_3 (.A(n_0_3), .B1(n_0_154), .B2(n_0_148), .C1(n_0_164), 
      .C2(n_0_150), .ZN(n_0_2));
   AOI21_X1 i_0_4 (.A(n_0_152), .B1(n_0_177), .B2(M[0]), .ZN(n_0_3));
   AOI21_X1 i_0_5 (.A(reset), .B1(n_0_6), .B2(n_0_4), .ZN(n_3));
   AOI22_X1 i_0_6 (.A1(n_0_153), .A2(n_0_7), .B1(n_0_154), .B2(n_0_5), .ZN(n_0_4));
   XNOR2_X1 i_0_7 (.A(n_0_128), .B(n_0_82), .ZN(n_0_5));
   NAND2_X1 i_0_8 (.A1(prod[18]), .A2(n_0_150), .ZN(n_0_6));
   XOR2_X1 i_0_9 (.A(n_0_129), .B(n_0_126), .Z(n_0_7));
   AOI21_X1 i_0_10 (.A(n_0_8), .B1(prod[19]), .B2(n_0_9), .ZN(n_4));
   OAI21_X1 i_0_11 (.A(n_0_163), .B1(prod[19]), .B2(n_0_9), .ZN(n_0_8));
   OAI33_X1 i_0_12 (.A1(n_0_152), .A2(n_0_122), .A3(n_0_123), .B1(n_0_79), 
      .B2(n_0_78), .B3(n_0_155), .ZN(n_0_9));
   AOI21_X1 i_0_13 (.A(n_0_10), .B1(prod[20]), .B2(n_0_11), .ZN(n_5));
   OAI21_X1 i_0_14 (.A(n_0_163), .B1(prod[20]), .B2(n_0_11), .ZN(n_0_10));
   OAI33_X1 i_0_15 (.A1(n_0_152), .A2(n_0_119), .A3(n_0_120), .B1(n_0_75), 
      .B2(n_0_74), .B3(n_0_155), .ZN(n_0_11));
   AOI21_X1 i_0_16 (.A(n_0_12), .B1(prod[21]), .B2(n_0_13), .ZN(n_6));
   OAI21_X1 i_0_17 (.A(n_0_163), .B1(prod[21]), .B2(n_0_13), .ZN(n_0_12));
   OAI33_X1 i_0_18 (.A1(n_0_117), .A2(n_0_115), .A3(n_0_152), .B1(n_0_155), 
      .B2(n_0_70), .B3(n_0_71), .ZN(n_0_13));
   AOI21_X1 i_0_19 (.A(n_0_14), .B1(prod[22]), .B2(n_0_15), .ZN(n_7));
   OAI21_X1 i_0_20 (.A(n_0_163), .B1(prod[22]), .B2(n_0_15), .ZN(n_0_14));
   OAI33_X1 i_0_21 (.A1(n_0_68), .A2(n_0_67), .A3(n_0_155), .B1(n_0_113), 
      .B2(n_0_112), .B3(n_0_152), .ZN(n_0_15));
   AOI21_X1 i_0_22 (.A(n_0_16), .B1(prod[23]), .B2(n_0_17), .ZN(n_8));
   OAI21_X1 i_0_23 (.A(n_0_163), .B1(prod[23]), .B2(n_0_17), .ZN(n_0_16));
   OAI33_X1 i_0_24 (.A1(n_0_152), .A2(n_0_109), .A3(n_0_110), .B1(n_0_155), 
      .B2(n_0_64), .B3(n_0_65), .ZN(n_0_17));
   AOI221_X1 i_0_25 (.A(reset), .B1(prod[24]), .B2(n_0_19), .C1(n_0_182), 
      .C2(n_0_18), .ZN(n_9));
   INV_X1 i_0_26 (.A(n_0_19), .ZN(n_0_18));
   AOI21_X1 i_0_27 (.A(n_0_20), .B1(M[8]), .B2(n_0_21), .ZN(n_0_19));
   AOI221_X1 i_0_28 (.A(M[8]), .B1(n_0_153), .B2(n_0_108), .C1(n_0_154), 
      .C2(n_0_62), .ZN(n_0_20));
   AOI22_X1 i_0_29 (.A1(n_0_153), .A2(n_0_107), .B1(n_0_154), .B2(n_0_63), 
      .ZN(n_0_21));
   AOI21_X1 i_0_30 (.A(n_0_22), .B1(prod[25]), .B2(n_0_23), .ZN(n_10));
   OAI21_X1 i_0_31 (.A(n_0_163), .B1(prod[25]), .B2(n_0_23), .ZN(n_0_22));
   AOI21_X1 i_0_32 (.A(n_0_24), .B1(n_0_170), .B2(n_0_25), .ZN(n_0_23));
   AOI221_X1 i_0_33 (.A(n_0_170), .B1(n_0_153), .B2(n_0_104), .C1(n_0_154), 
      .C2(n_0_60), .ZN(n_0_24));
   AOI22_X1 i_0_34 (.A1(n_0_154), .A2(n_0_59), .B1(n_0_153), .B2(n_0_105), 
      .ZN(n_0_25));
   AOI21_X1 i_0_35 (.A(n_0_26), .B1(prod[26]), .B2(n_0_27), .ZN(n_11));
   OAI21_X1 i_0_36 (.A(n_0_163), .B1(prod[26]), .B2(n_0_27), .ZN(n_0_26));
   OAI33_X1 i_0_37 (.A1(n_0_155), .A2(n_0_55), .A3(n_0_56), .B1(n_0_101), 
      .B2(n_0_100), .B3(n_0_152), .ZN(n_0_27));
   AOI21_X1 i_0_38 (.A(n_0_28), .B1(prod[27]), .B2(n_0_29), .ZN(n_12));
   OAI21_X1 i_0_39 (.A(n_0_163), .B1(prod[27]), .B2(n_0_29), .ZN(n_0_28));
   AOI21_X1 i_0_40 (.A(n_0_30), .B1(M[11]), .B2(n_0_31), .ZN(n_0_29));
   AOI221_X1 i_0_41 (.A(M[11]), .B1(n_0_154), .B2(n_0_53), .C1(n_0_153), 
      .C2(n_0_99), .ZN(n_0_30));
   AOI22_X1 i_0_42 (.A1(n_0_154), .A2(n_0_54), .B1(n_0_153), .B2(n_0_98), 
      .ZN(n_0_31));
   AOI21_X1 i_0_43 (.A(n_0_32), .B1(prod[28]), .B2(n_0_33), .ZN(n_13));
   OAI21_X1 i_0_44 (.A(n_0_163), .B1(prod[28]), .B2(n_0_33), .ZN(n_0_32));
   OAI33_X1 i_0_45 (.A1(n_0_155), .A2(n_0_51), .A3(n_0_49), .B1(n_0_152), 
      .B2(n_0_93), .B3(n_0_94), .ZN(n_0_33));
   AOI21_X1 i_0_46 (.A(n_0_34), .B1(prod[29]), .B2(n_0_35), .ZN(n_14));
   OAI21_X1 i_0_47 (.A(n_0_163), .B1(prod[29]), .B2(n_0_35), .ZN(n_0_34));
   OAI33_X1 i_0_48 (.A1(n_0_152), .A2(n_0_90), .A3(n_0_91), .B1(n_0_47), 
      .B2(n_0_46), .B3(n_0_155), .ZN(n_0_35));
   AOI21_X1 i_0_49 (.A(n_0_36), .B1(prod[30]), .B2(n_0_37), .ZN(n_15));
   OAI21_X1 i_0_50 (.A(n_0_163), .B1(prod[30]), .B2(n_0_37), .ZN(n_0_36));
   AOI21_X1 i_0_51 (.A(n_0_38), .B1(M[14]), .B2(n_0_39), .ZN(n_0_37));
   AOI221_X1 i_0_52 (.A(M[14]), .B1(n_0_154), .B2(n_0_45), .C1(n_0_153), 
      .C2(n_0_88), .ZN(n_0_38));
   AOI22_X1 i_0_53 (.A1(n_0_154), .A2(n_0_44), .B1(n_0_153), .B2(n_0_89), 
      .ZN(n_0_39));
   AOI21_X1 i_0_54 (.A(reset), .B1(n_0_85), .B2(n_0_40), .ZN(n_16));
   AOI22_X1 i_0_55 (.A1(n_0_153), .A2(n_0_86), .B1(n_0_154), .B2(n_0_41), 
      .ZN(n_0_40));
   XOR2_X1 i_0_56 (.A(M[15]), .B(n_0_42), .Z(n_0_41));
   AOI21_X1 i_0_57 (.A(n_0_43), .B1(n_0_186), .B2(n_0_175), .ZN(n_0_42));
   AOI22_X1 i_0_58 (.A1(n_0_175), .A2(n_0_44), .B1(n_0_186), .B2(n_0_45), 
      .ZN(n_0_43));
   INV_X1 i_0_59 (.A(n_0_45), .ZN(n_0_44));
   OAI22_X1 i_0_60 (.A1(n_0_174), .A2(n_0_48), .B1(n_0_185), .B2(n_0_46), 
      .ZN(n_0_45));
   AND2_X1 i_0_61 (.A1(n_0_174), .A2(n_0_48), .ZN(n_0_46));
   NOR2_X1 i_0_62 (.A1(n_0_174), .A2(n_0_48), .ZN(n_0_47));
   AOI21_X1 i_0_63 (.A(n_0_51), .B1(prod[28]), .B2(n_0_50), .ZN(n_0_48));
   INV_X1 i_0_64 (.A(n_0_50), .ZN(n_0_49));
   NAND3_X1 i_0_65 (.A1(n_0_173), .A2(n_0_84), .A3(n_0_52), .ZN(n_0_50));
   AOI21_X1 i_0_66 (.A(n_0_173), .B1(n_0_84), .B2(n_0_52), .ZN(n_0_51));
   OAI21_X1 i_0_67 (.A(n_0_53), .B1(prod[27]), .B2(M[11]), .ZN(n_0_52));
   INV_X1 i_0_68 (.A(n_0_54), .ZN(n_0_53));
   OAI22_X1 i_0_69 (.A1(M[10]), .A2(n_0_57), .B1(prod[26]), .B2(n_0_56), 
      .ZN(n_0_54));
   NOR2_X1 i_0_70 (.A1(M[10]), .A2(n_0_57), .ZN(n_0_55));
   AND2_X1 i_0_71 (.A1(M[10]), .A2(n_0_57), .ZN(n_0_56));
   AOI21_X1 i_0_72 (.A(n_0_58), .B1(n_0_183), .B2(n_0_170), .ZN(n_0_57));
   AOI21_X1 i_0_73 (.A(n_0_59), .B1(prod[25]), .B2(M[9]), .ZN(n_0_58));
   INV_X1 i_0_74 (.A(n_0_60), .ZN(n_0_59));
   AOI21_X1 i_0_75 (.A(n_0_61), .B1(prod[24]), .B2(M[8]), .ZN(n_0_60));
   AOI21_X1 i_0_76 (.A(n_0_63), .B1(n_0_182), .B2(n_0_169), .ZN(n_0_61));
   INV_X1 i_0_77 (.A(n_0_63), .ZN(n_0_62));
   OAI22_X1 i_0_78 (.A1(M[7]), .A2(n_0_66), .B1(prod[23]), .B2(n_0_65), .ZN(
      n_0_63));
   NOR2_X1 i_0_79 (.A1(M[7]), .A2(n_0_66), .ZN(n_0_64));
   AND2_X1 i_0_80 (.A1(M[7]), .A2(n_0_66), .ZN(n_0_65));
   OAI22_X1 i_0_81 (.A1(n_0_167), .A2(n_0_69), .B1(n_0_181), .B2(n_0_67), 
      .ZN(n_0_66));
   AND2_X1 i_0_82 (.A1(n_0_167), .A2(n_0_69), .ZN(n_0_67));
   NOR2_X1 i_0_83 (.A1(n_0_167), .A2(n_0_69), .ZN(n_0_68));
   OAI22_X1 i_0_84 (.A1(M[5]), .A2(n_0_72), .B1(prod[21]), .B2(n_0_70), .ZN(
      n_0_69));
   AND2_X1 i_0_85 (.A1(M[5]), .A2(n_0_72), .ZN(n_0_70));
   NOR2_X1 i_0_86 (.A1(M[5]), .A2(n_0_72), .ZN(n_0_71));
   INV_X1 i_0_87 (.A(n_0_73), .ZN(n_0_72));
   AOI21_X1 i_0_88 (.A(n_0_74), .B1(prod[20]), .B2(n_0_76), .ZN(n_0_73));
   NOR2_X1 i_0_89 (.A1(n_0_166), .A2(n_0_77), .ZN(n_0_74));
   INV_X1 i_0_90 (.A(n_0_76), .ZN(n_0_75));
   NAND2_X1 i_0_91 (.A1(n_0_166), .A2(n_0_77), .ZN(n_0_76));
   AOI21_X1 i_0_92 (.A(n_0_78), .B1(prod[19]), .B2(n_0_80), .ZN(n_0_77));
   NOR2_X1 i_0_93 (.A1(n_0_165), .A2(n_0_81), .ZN(n_0_78));
   INV_X1 i_0_94 (.A(n_0_80), .ZN(n_0_79));
   NAND2_X1 i_0_95 (.A1(n_0_165), .A2(n_0_81), .ZN(n_0_80));
   AOI22_X1 i_0_96 (.A1(prod[18]), .A2(M[2]), .B1(n_0_129), .B2(n_0_82), 
      .ZN(n_0_81));
   AOI21_X1 i_0_97 (.A(n_0_83), .B1(n_0_178), .B2(n_0_164), .ZN(n_0_82));
   AOI21_X1 i_0_98 (.A(n_0_147), .B1(prod[17]), .B2(M[1]), .ZN(n_0_83));
   NAND2_X1 i_0_99 (.A1(prod[27]), .A2(M[11]), .ZN(n_0_84));
   NAND2_X1 i_0_100 (.A1(prod[30]), .A2(n_0_150), .ZN(n_0_85));
   XNOR2_X1 i_0_101 (.A(M[15]), .B(n_0_87), .ZN(n_0_86));
   OAI33_X1 i_0_102 (.A1(n_0_186), .A2(n_0_175), .A3(n_0_89), .B1(prod[30]), 
      .B2(M[14]), .B3(n_0_88), .ZN(n_0_87));
   INV_X1 i_0_103 (.A(n_0_89), .ZN(n_0_88));
   OAI22_X1 i_0_104 (.A1(M[13]), .A2(n_0_92), .B1(n_0_185), .B2(n_0_90), 
      .ZN(n_0_89));
   AND2_X1 i_0_105 (.A1(M[13]), .A2(n_0_92), .ZN(n_0_90));
   NOR2_X1 i_0_106 (.A1(M[13]), .A2(n_0_92), .ZN(n_0_91));
   AOI21_X1 i_0_107 (.A(n_0_93), .B1(prod[28]), .B2(n_0_95), .ZN(n_0_92));
   NOR2_X1 i_0_108 (.A1(M[12]), .A2(n_0_96), .ZN(n_0_93));
   INV_X1 i_0_109 (.A(n_0_95), .ZN(n_0_94));
   NAND2_X1 i_0_110 (.A1(M[12]), .A2(n_0_96), .ZN(n_0_95));
   AOI21_X1 i_0_111 (.A(n_0_97), .B1(prod[27]), .B2(n_0_172), .ZN(n_0_96));
   AOI21_X1 i_0_112 (.A(n_0_99), .B1(n_0_184), .B2(M[11]), .ZN(n_0_97));
   INV_X1 i_0_113 (.A(n_0_99), .ZN(n_0_98));
   OAI22_X1 i_0_114 (.A1(n_0_171), .A2(n_0_102), .B1(prod[26]), .B2(n_0_100), 
      .ZN(n_0_99));
   AND2_X1 i_0_115 (.A1(n_0_171), .A2(n_0_102), .ZN(n_0_100));
   NOR2_X1 i_0_116 (.A1(n_0_171), .A2(n_0_102), .ZN(n_0_101));
   AOI21_X1 i_0_117 (.A(n_0_103), .B1(n_0_183), .B2(M[9]), .ZN(n_0_102));
   AOI21_X1 i_0_118 (.A(n_0_104), .B1(prod[25]), .B2(n_0_170), .ZN(n_0_103));
   INV_X1 i_0_119 (.A(n_0_105), .ZN(n_0_104));
   AOI21_X1 i_0_120 (.A(n_0_106), .B1(prod[24]), .B2(n_0_169), .ZN(n_0_105));
   AOI21_X1 i_0_121 (.A(n_0_108), .B1(n_0_182), .B2(M[8]), .ZN(n_0_106));
   INV_X1 i_0_122 (.A(n_0_108), .ZN(n_0_107));
   OAI22_X1 i_0_123 (.A1(n_0_168), .A2(n_0_111), .B1(prod[23]), .B2(n_0_109), 
      .ZN(n_0_108));
   AND2_X1 i_0_124 (.A1(n_0_168), .A2(n_0_111), .ZN(n_0_109));
   NOR2_X1 i_0_125 (.A1(n_0_168), .A2(n_0_111), .ZN(n_0_110));
   OAI22_X1 i_0_126 (.A1(M[6]), .A2(n_0_114), .B1(n_0_181), .B2(n_0_112), 
      .ZN(n_0_111));
   AND2_X1 i_0_127 (.A1(M[6]), .A2(n_0_114), .ZN(n_0_112));
   NOR2_X1 i_0_128 (.A1(M[6]), .A2(n_0_114), .ZN(n_0_113));
   AOI21_X1 i_0_129 (.A(n_0_117), .B1(prod[21]), .B2(n_0_116), .ZN(n_0_114));
   INV_X1 i_0_130 (.A(n_0_116), .ZN(n_0_115));
   NAND2_X1 i_0_131 (.A1(M[5]), .A2(n_0_118), .ZN(n_0_116));
   NOR2_X1 i_0_132 (.A1(M[5]), .A2(n_0_118), .ZN(n_0_117));
   OAI22_X1 i_0_133 (.A1(n_0_166), .A2(n_0_121), .B1(prod[20]), .B2(n_0_120), 
      .ZN(n_0_118));
   NOR2_X1 i_0_134 (.A1(n_0_166), .A2(n_0_121), .ZN(n_0_119));
   AND2_X1 i_0_135 (.A1(n_0_166), .A2(n_0_121), .ZN(n_0_120));
   AOI21_X1 i_0_136 (.A(n_0_122), .B1(n_0_180), .B2(n_0_124), .ZN(n_0_121));
   NOR2_X1 i_0_137 (.A1(n_0_165), .A2(n_0_125), .ZN(n_0_122));
   INV_X1 i_0_138 (.A(n_0_124), .ZN(n_0_123));
   NAND2_X1 i_0_139 (.A1(n_0_165), .A2(n_0_125), .ZN(n_0_124));
   AOI22_X1 i_0_140 (.A1(n_0_128), .A2(n_0_126), .B1(n_0_179), .B2(M[2]), 
      .ZN(n_0_125));
   AOI21_X1 i_0_141 (.A(n_0_127), .B1(prod[17]), .B2(n_0_164), .ZN(n_0_126));
   AOI22_X1 i_0_142 (.A1(n_0_178), .A2(M[1]), .B1(n_0_177), .B2(M[0]), .ZN(
      n_0_127));
   INV_X1 i_0_143 (.A(n_0_129), .ZN(n_0_128));
   XNOR2_X1 i_0_144 (.A(n_0_179), .B(M[2]), .ZN(n_0_129));
   INV_X1 i_0_145 (.A(n_0_130), .ZN(n_17));
   AOI22_X1 i_0_146 (.A1(prod[1]), .A2(n_0_163), .B1(reset), .B2(mp[0]), 
      .ZN(n_0_130));
   INV_X1 i_0_147 (.A(n_0_131), .ZN(n_18));
   AOI22_X1 i_0_148 (.A1(prod[2]), .A2(n_0_163), .B1(reset), .B2(mp[1]), 
      .ZN(n_0_131));
   INV_X1 i_0_149 (.A(n_0_132), .ZN(n_19));
   AOI22_X1 i_0_150 (.A1(prod[3]), .A2(n_0_163), .B1(reset), .B2(mp[2]), 
      .ZN(n_0_132));
   INV_X1 i_0_151 (.A(n_0_133), .ZN(n_20));
   AOI22_X1 i_0_152 (.A1(prod[4]), .A2(n_0_163), .B1(reset), .B2(mp[3]), 
      .ZN(n_0_133));
   INV_X1 i_0_153 (.A(n_0_134), .ZN(n_21));
   AOI22_X1 i_0_154 (.A1(prod[5]), .A2(n_0_163), .B1(reset), .B2(mp[4]), 
      .ZN(n_0_134));
   INV_X1 i_0_155 (.A(n_0_135), .ZN(n_22));
   AOI22_X1 i_0_156 (.A1(prod[6]), .A2(n_0_163), .B1(reset), .B2(mp[5]), 
      .ZN(n_0_135));
   INV_X1 i_0_157 (.A(n_0_136), .ZN(n_23));
   AOI22_X1 i_0_158 (.A1(prod[7]), .A2(n_0_163), .B1(reset), .B2(mp[6]), 
      .ZN(n_0_136));
   INV_X1 i_0_159 (.A(n_0_137), .ZN(n_24));
   AOI22_X1 i_0_160 (.A1(prod[8]), .A2(n_0_163), .B1(reset), .B2(mp[7]), 
      .ZN(n_0_137));
   INV_X1 i_0_161 (.A(n_0_138), .ZN(n_25));
   AOI22_X1 i_0_162 (.A1(prod[9]), .A2(n_0_163), .B1(reset), .B2(mp[8]), 
      .ZN(n_0_138));
   INV_X1 i_0_163 (.A(n_0_139), .ZN(n_26));
   AOI22_X1 i_0_164 (.A1(prod[10]), .A2(n_0_163), .B1(reset), .B2(mp[9]), 
      .ZN(n_0_139));
   INV_X1 i_0_165 (.A(n_0_140), .ZN(n_27));
   AOI22_X1 i_0_166 (.A1(prod[11]), .A2(n_0_163), .B1(reset), .B2(mp[10]), 
      .ZN(n_0_140));
   INV_X1 i_0_167 (.A(n_0_141), .ZN(n_28));
   AOI22_X1 i_0_168 (.A1(prod[12]), .A2(n_0_163), .B1(reset), .B2(mp[11]), 
      .ZN(n_0_141));
   INV_X1 i_0_169 (.A(n_0_142), .ZN(n_29));
   AOI22_X1 i_0_170 (.A1(prod[13]), .A2(n_0_163), .B1(reset), .B2(mp[12]), 
      .ZN(n_0_142));
   INV_X1 i_0_171 (.A(n_0_143), .ZN(n_30));
   AOI22_X1 i_0_172 (.A1(prod[14]), .A2(n_0_163), .B1(reset), .B2(mp[13]), 
      .ZN(n_0_143));
   INV_X1 i_0_173 (.A(n_0_144), .ZN(n_31));
   AOI22_X1 i_0_174 (.A1(prod[15]), .A2(n_0_163), .B1(reset), .B2(mp[14]), 
      .ZN(n_0_144));
   INV_X1 i_0_175 (.A(n_0_145), .ZN(n_32));
   AOI22_X1 i_0_176 (.A1(reset), .A2(mp[15]), .B1(n_0_163), .B2(n_0_146), 
      .ZN(n_0_145));
   AOI21_X1 i_0_177 (.A(n_0_149), .B1(n_0_151), .B2(n_0_147), .ZN(n_0_146));
   INV_X1 i_0_178 (.A(n_0_148), .ZN(n_0_147));
   NAND2_X1 i_0_179 (.A1(prod[16]), .A2(M[0]), .ZN(n_0_148));
   AOI21_X1 i_0_180 (.A(prod[16]), .B1(M[0]), .B2(n_0_151), .ZN(n_0_149));
   INV_X1 i_0_181 (.A(n_0_151), .ZN(n_0_150));
   NAND2_X1 i_0_182 (.A1(n_0_155), .A2(n_0_152), .ZN(n_0_151));
   INV_X1 i_0_183 (.A(n_0_153), .ZN(n_0_152));
   NOR2_X1 i_0_184 (.A1(n_0_176), .A2(Q_1), .ZN(n_0_153));
   INV_X1 i_0_185 (.A(n_0_155), .ZN(n_0_154));
   NAND2_X1 i_0_186 (.A1(n_0_176), .A2(Q_1), .ZN(n_0_155));
   NAND2_X1 i_0_187 (.A1(n_0_163), .A2(n_0_159), .ZN(n_33));
   NOR2_X1 i_0_188 (.A1(i[0]), .A2(reset), .ZN(n_34));
   AOI21_X1 i_0_189 (.A(reset), .B1(n_0_161), .B2(n_0_156), .ZN(n_35));
   NAND2_X1 i_0_190 (.A1(i[1]), .A2(i[0]), .ZN(n_0_156));
   AOI221_X1 i_0_191 (.A(reset), .B1(n_0_187), .B2(n_0_161), .C1(i[2]), .C2(
      n_0_162), .ZN(n_36));
   AOI21_X1 i_0_192 (.A(reset), .B1(n_0_160), .B2(n_0_157), .ZN(n_37));
   OAI21_X1 i_0_193 (.A(i[3]), .B1(i[2]), .B2(n_0_161), .ZN(n_0_157));
   INV_X1 i_0_194 (.A(n_0_158), .ZN(n_38));
   AOI211_X1 i_0_195 (.A(reset), .B(n_0_159), .C1(i[4]), .C2(n_0_160), .ZN(
      n_0_158));
   NOR2_X1 i_0_196 (.A1(i[4]), .A2(n_0_160), .ZN(n_0_159));
   OR3_X1 i_0_197 (.A1(i[2]), .A2(n_0_161), .A3(i[3]), .ZN(n_0_160));
   INV_X1 i_0_198 (.A(n_0_162), .ZN(n_0_161));
   NOR2_X1 i_0_199 (.A1(i[1]), .A2(i[0]), .ZN(n_0_162));
   NOR2_X1 i_0_200 (.A1(n_0_176), .A2(reset), .ZN(n_39));
   INV_X1 i_0_201 (.A(reset), .ZN(n_0_163));
   INV_X1 i_0_202 (.A(M[1]), .ZN(n_0_164));
   INV_X1 i_0_203 (.A(M[3]), .ZN(n_0_165));
   INV_X1 i_0_204 (.A(M[4]), .ZN(n_0_166));
   INV_X1 i_0_205 (.A(M[6]), .ZN(n_0_167));
   INV_X1 i_0_206 (.A(M[7]), .ZN(n_0_168));
   INV_X1 i_0_207 (.A(M[8]), .ZN(n_0_169));
   INV_X1 i_0_208 (.A(M[9]), .ZN(n_0_170));
   INV_X1 i_0_209 (.A(M[10]), .ZN(n_0_171));
   INV_X1 i_0_210 (.A(M[11]), .ZN(n_0_172));
   INV_X1 i_0_211 (.A(M[12]), .ZN(n_0_173));
   INV_X1 i_0_212 (.A(M[13]), .ZN(n_0_174));
   INV_X1 i_0_213 (.A(M[14]), .ZN(n_0_175));
   INV_X1 i_0_214 (.A(prod[0]), .ZN(n_0_176));
   INV_X1 i_0_215 (.A(prod[16]), .ZN(n_0_177));
   INV_X1 i_0_216 (.A(prod[17]), .ZN(n_0_178));
   INV_X1 i_0_217 (.A(prod[18]), .ZN(n_0_179));
   INV_X1 i_0_218 (.A(prod[19]), .ZN(n_0_180));
   INV_X1 i_0_219 (.A(prod[22]), .ZN(n_0_181));
   INV_X1 i_0_220 (.A(prod[24]), .ZN(n_0_182));
   INV_X1 i_0_221 (.A(prod[25]), .ZN(n_0_183));
   INV_X1 i_0_222 (.A(prod[27]), .ZN(n_0_184));
   INV_X1 i_0_223 (.A(prod[29]), .ZN(n_0_185));
   INV_X1 i_0_224 (.A(prod[30]), .ZN(n_0_186));
   INV_X1 i_0_225 (.A(i[2]), .ZN(n_0_187));
endmodule

module datapath__0_17(result, p_0);
   input [31:0]result;
   output [31:0]p_0;

   HA_X1 i_0 (.A(result[8]), .B(result[7]), .CO(n_0), .S(p_0[8]));
   HA_X1 i_1 (.A(result[9]), .B(n_0), .CO(n_1), .S(p_0[9]));
   HA_X1 i_2 (.A(result[10]), .B(n_1), .CO(n_2), .S(p_0[10]));
   HA_X1 i_3 (.A(result[11]), .B(n_2), .CO(n_3), .S(p_0[11]));
   HA_X1 i_4 (.A(result[12]), .B(n_3), .CO(n_4), .S(p_0[12]));
   HA_X1 i_5 (.A(result[13]), .B(n_4), .CO(n_5), .S(p_0[13]));
   HA_X1 i_6 (.A(result[14]), .B(n_5), .CO(n_6), .S(p_0[14]));
   HA_X1 i_7 (.A(result[15]), .B(n_6), .CO(n_7), .S(p_0[15]));
   HA_X1 i_8 (.A(result[16]), .B(n_7), .CO(n_8), .S(p_0[16]));
   HA_X1 i_9 (.A(result[17]), .B(n_8), .CO(n_9), .S(p_0[17]));
   HA_X1 i_10 (.A(result[18]), .B(n_9), .CO(n_10), .S(p_0[18]));
   HA_X1 i_11 (.A(result[19]), .B(n_10), .CO(n_11), .S(p_0[19]));
   HA_X1 i_12 (.A(result[20]), .B(n_11), .CO(n_12), .S(p_0[20]));
   HA_X1 i_13 (.A(result[21]), .B(n_12), .CO(n_13), .S(p_0[21]));
   HA_X1 i_14 (.A(result[22]), .B(n_13), .CO(n_14), .S(p_0[22]));
   HA_X1 i_15 (.A(result[23]), .B(n_14), .CO(n_15), .S(p_0[23]));
endmodule

module multiplier(multiplicand, multiplier, o_result, overflow_flag, clk, reset);
   input [15:0]multiplicand;
   input [15:0]multiplier;
   output [15:0]o_result;
   output overflow_flag;
   input clk;
   input reset;

   wire [31:0]result;
   wire n_0_1_0;
   wire n_0_1_1;
   wire n_0_1_2;
   wire n_0_1_3;
   wire n_0_1_4;
   wire n_0_1_5;
   wire n_0_1_6;
   wire n_0_1_7;
   wire n_0_1_8;
   wire n_0_1_9;

   booth b (.prod({uc_0, result[30], result[29], result[28], result[27], 
      result[26], result[25], result[24], result[23], result[22], result[21], 
      result[20], result[19], result[18], result[17], result[16], result[15], 
      result[14], result[13], result[12], result[11], result[10], result[9], 
      result[8], result[7], result[6], result[5], result[4], result[3], 
      result[2], result[1], result[0]}), .mc(multiplicand), .mp(multiplier), 
      .clk(clk), .reset(reset));
   datapath__0_17 i_0_0 (.result({uc_1, uc_2, uc_3, uc_4, uc_5, uc_6, uc_7, uc_8, 
      result[23], result[22], result[21], result[20], result[19], result[18], 
      result[17], result[16], result[15], result[14], result[13], result[12], 
      result[11], result[10], result[9], result[8], result[7], uc_9, uc_10, 
      uc_11, uc_12, uc_13, uc_14, uc_15}), .p_0({uc_16, uc_17, uc_18, uc_19, 
      uc_20, uc_21, uc_22, uc_23, o_result[15], o_result[14], o_result[13], 
      o_result[12], o_result[11], o_result[10], o_result[9], o_result[8], 
      o_result[7], o_result[6], o_result[5], o_result[4], o_result[3], 
      o_result[2], o_result[1], o_result[0], uc_24, uc_25, uc_26, uc_27, uc_28, 
      uc_29, uc_30, uc_31}));
   NOR4_X1 i_0_1_0 (.A1(result[26]), .A2(result[25]), .A3(result[24]), .A4(
      result[23]), .ZN(n_0_1_0));
   NOR4_X1 i_0_1_1 (.A1(result[30]), .A2(result[29]), .A3(result[28]), .A4(
      result[27]), .ZN(n_0_1_1));
   NAND4_X1 i_0_1_2 (.A1(result[20]), .A2(result[19]), .A3(result[22]), .A4(
      result[21]), .ZN(n_0_1_2));
   NAND4_X1 i_0_1_3 (.A1(result[16]), .A2(result[15]), .A3(result[18]), .A4(
      result[17]), .ZN(n_0_1_3));
   NAND4_X1 i_0_1_4 (.A1(result[12]), .A2(result[11]), .A3(result[14]), .A4(
      result[13]), .ZN(n_0_1_4));
   NAND3_X1 i_0_1_5 (.A1(result[10]), .A2(result[9]), .A3(result[8]), .ZN(
      n_0_1_5));
   OR4_X1 i_0_1_6 (.A1(n_0_1_2), .A2(n_0_1_3), .A3(n_0_1_4), .A4(n_0_1_5), 
      .ZN(n_0_1_6));
   NOR4_X1 i_0_1_7 (.A1(result[1]), .A2(result[0]), .A3(result[3]), .A4(
      result[2]), .ZN(n_0_1_7));
   NOR4_X1 i_0_1_8 (.A1(result[5]), .A2(result[4]), .A3(result[7]), .A4(
      result[6]), .ZN(n_0_1_8));
   AND2_X1 i_0_1_9 (.A1(n_0_1_7), .A2(n_0_1_8), .ZN(n_0_1_9));
   OAI211_X1 i_0_1_10 (.A(n_0_1_0), .B(n_0_1_1), .C1(n_0_1_6), .C2(n_0_1_9), 
      .ZN(overflow_flag));
endmodule
