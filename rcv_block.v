/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Feb  8 00:12:03 2017
/////////////////////////////////////////////////////////////


module rx_data_buff ( clk, n_rst, load_buffer, packet_data, data_read, rx_data, 
        data_ready, overrun_error );
  input [7:0] packet_data;
  output [7:0] rx_data;
  input clk, n_rst, load_buffer, data_read;
  output data_ready, overrun_error;
  wire   n30, n31, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n15, n17, n19,
         n21, n23, n25, n27, n29;

  DFFSR \rx_data_reg[7]  ( .D(n15), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[7]) );
  DFFSR \rx_data_reg[6]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[6]) );
  DFFSR \rx_data_reg[5]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[5]) );
  DFFSR \rx_data_reg[4]  ( .D(n21), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[4]) );
  DFFSR \rx_data_reg[3]  ( .D(n23), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[3]) );
  DFFSR \rx_data_reg[2]  ( .D(n25), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[2]) );
  DFFSR \rx_data_reg[1]  ( .D(n27), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[1]) );
  DFFSR \rx_data_reg[0]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[0]) );
  DFFSR data_ready_reg ( .D(n31), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        data_ready) );
  DFFSR overrun_error_reg ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        overrun_error) );
  INVX1 U3 ( .A(n1), .Y(n15) );
  MUX2X1 U4 ( .B(rx_data[7]), .A(packet_data[7]), .S(load_buffer), .Y(n1) );
  INVX1 U5 ( .A(n2), .Y(n17) );
  MUX2X1 U6 ( .B(rx_data[6]), .A(packet_data[6]), .S(load_buffer), .Y(n2) );
  INVX1 U7 ( .A(n3), .Y(n19) );
  MUX2X1 U8 ( .B(rx_data[5]), .A(packet_data[5]), .S(load_buffer), .Y(n3) );
  INVX1 U9 ( .A(n4), .Y(n21) );
  MUX2X1 U10 ( .B(rx_data[4]), .A(packet_data[4]), .S(load_buffer), .Y(n4) );
  INVX1 U11 ( .A(n5), .Y(n23) );
  MUX2X1 U12 ( .B(rx_data[3]), .A(packet_data[3]), .S(load_buffer), .Y(n5) );
  INVX1 U13 ( .A(n6), .Y(n25) );
  MUX2X1 U14 ( .B(rx_data[2]), .A(packet_data[2]), .S(load_buffer), .Y(n6) );
  INVX1 U15 ( .A(n7), .Y(n27) );
  MUX2X1 U16 ( .B(rx_data[1]), .A(packet_data[1]), .S(load_buffer), .Y(n7) );
  INVX1 U17 ( .A(n8), .Y(n29) );
  MUX2X1 U18 ( .B(rx_data[0]), .A(packet_data[0]), .S(load_buffer), .Y(n8) );
  OAI21X1 U19 ( .A(data_read), .B(n9), .C(n10), .Y(n31) );
  INVX1 U20 ( .A(load_buffer), .Y(n10) );
  INVX1 U21 ( .A(data_ready), .Y(n9) );
  NOR2X1 U22 ( .A(data_read), .B(n11), .Y(n30) );
  AOI21X1 U23 ( .A(data_ready), .B(load_buffer), .C(overrun_error), .Y(n11) );
endmodule


module stop_bit_chk ( clk, n_rst, sbc_clear, sbc_enable, stop_bit, 
        framing_error );
  input clk, n_rst, sbc_clear, sbc_enable, stop_bit;
  output framing_error;
  wire   n5, n2, n3;

  DFFSR framing_error_reg ( .D(n5), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        framing_error) );
  NOR2X1 U3 ( .A(sbc_clear), .B(n2), .Y(n5) );
  MUX2X1 U4 ( .B(framing_error), .A(n3), .S(sbc_enable), .Y(n2) );
  INVX1 U5 ( .A(stop_bit), .Y(n3) );
endmodule


module flex_stp_sr_NUM_BITS9_SHIFT_MSB0 ( clk, n_rst, shift_enable, serial_in, 
        parallel_out );
  output [8:0] parallel_out;
  input clk, n_rst, shift_enable, serial_in;
  wire   n13, n15, n17, n19, n21, n23, n25, n27, n29, n1, n2, n3, n4, n5, n6,
         n7, n8, n9;

  DFFSR \parallel_out_reg[8]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[8]) );
  DFFSR \parallel_out_reg[7]  ( .D(n27), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[7]) );
  DFFSR \parallel_out_reg[6]  ( .D(n25), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[6]) );
  DFFSR \parallel_out_reg[5]  ( .D(n23), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[5]) );
  DFFSR \parallel_out_reg[4]  ( .D(n21), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[4]) );
  DFFSR \parallel_out_reg[3]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[3]) );
  DFFSR \parallel_out_reg[2]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[2]) );
  DFFSR \parallel_out_reg[1]  ( .D(n15), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[1]) );
  DFFSR \parallel_out_reg[0]  ( .D(n13), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[0]) );
  INVX1 U2 ( .A(n1), .Y(n29) );
  MUX2X1 U3 ( .B(parallel_out[8]), .A(serial_in), .S(shift_enable), .Y(n1) );
  INVX1 U4 ( .A(n2), .Y(n27) );
  MUX2X1 U5 ( .B(parallel_out[7]), .A(parallel_out[8]), .S(shift_enable), .Y(
        n2) );
  INVX1 U6 ( .A(n3), .Y(n25) );
  MUX2X1 U7 ( .B(parallel_out[6]), .A(parallel_out[7]), .S(shift_enable), .Y(
        n3) );
  INVX1 U8 ( .A(n4), .Y(n23) );
  MUX2X1 U9 ( .B(parallel_out[5]), .A(parallel_out[6]), .S(shift_enable), .Y(
        n4) );
  INVX1 U10 ( .A(n5), .Y(n21) );
  MUX2X1 U11 ( .B(parallel_out[4]), .A(parallel_out[5]), .S(shift_enable), .Y(
        n5) );
  INVX1 U12 ( .A(n6), .Y(n19) );
  MUX2X1 U13 ( .B(parallel_out[3]), .A(parallel_out[4]), .S(shift_enable), .Y(
        n6) );
  INVX1 U14 ( .A(n7), .Y(n17) );
  MUX2X1 U15 ( .B(parallel_out[2]), .A(parallel_out[3]), .S(shift_enable), .Y(
        n7) );
  INVX1 U16 ( .A(n8), .Y(n15) );
  MUX2X1 U17 ( .B(parallel_out[1]), .A(parallel_out[2]), .S(shift_enable), .Y(
        n8) );
  INVX1 U18 ( .A(n9), .Y(n13) );
  MUX2X1 U19 ( .B(parallel_out[0]), .A(parallel_out[1]), .S(shift_enable), .Y(
        n9) );
endmodule


module sr_9bit ( clk, n_rst, shift_strobe, serial_in, packet_data, stop_bit );
  output [7:0] packet_data;
  input clk, n_rst, shift_strobe, serial_in;
  output stop_bit;


  flex_stp_sr_NUM_BITS9_SHIFT_MSB0 sr ( .clk(clk), .n_rst(n_rst), 
        .shift_enable(shift_strobe), .serial_in(serial_in), .parallel_out({
        stop_bit, packet_data}) );
endmodule


module start_bit_det ( clk, n_rst, serial_in, start_bit_detected );
  input clk, n_rst, serial_in;
  output start_bit_detected;
  wire   old_sample, new_sample, sync_phase, n4;

  DFFSR sync_phase_reg ( .D(serial_in), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        sync_phase) );
  DFFSR new_sample_reg ( .D(sync_phase), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        new_sample) );
  DFFSR old_sample_reg ( .D(new_sample), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        old_sample) );
  NOR2X1 U6 ( .A(new_sample), .B(n4), .Y(start_bit_detected) );
  INVX1 U7 ( .A(old_sample), .Y(n4) );
endmodule


module rcu ( clk, n_rst, start_bit_detected, packet_done, framing_error, 
        sbc_clear, sbc_enable, load_buffer, enable_timer );
  input clk, n_rst, start_bit_detected, packet_done, framing_error;
  output sbc_clear, sbc_enable, load_buffer, enable_timer;
  wire   n22, n23, n24, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14;
  wire   [2:0] state;

  DFFSR \state_reg[0]  ( .D(n24), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[0])
         );
  DFFSR \state_reg[2]  ( .D(n22), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[2])
         );
  DFFSR \state_reg[1]  ( .D(n23), .CLK(clk), .R(n_rst), .S(1'b1), .Q(state[1])
         );
  INVX1 U6 ( .A(n4), .Y(sbc_enable) );
  NOR2X1 U7 ( .A(n5), .B(n6), .Y(n24) );
  OAI21X1 U8 ( .A(packet_done), .B(n7), .C(n8), .Y(n6) );
  MUX2X1 U9 ( .B(n9), .A(n10), .S(state[2]), .Y(n5) );
  NOR2X1 U10 ( .A(state[1]), .B(framing_error), .Y(n10) );
  OR2X1 U11 ( .A(state[1]), .B(start_bit_detected), .Y(n9) );
  OR2X1 U12 ( .A(sbc_clear), .B(enable_timer), .Y(n23) );
  INVX1 U13 ( .A(n7), .Y(enable_timer) );
  NAND3X1 U14 ( .A(n8), .B(n11), .C(state[1]), .Y(n7) );
  NOR2X1 U15 ( .A(n12), .B(state[2]), .Y(sbc_clear) );
  OAI21X1 U16 ( .A(n13), .B(n14), .C(n4), .Y(n22) );
  NAND3X1 U17 ( .A(state[0]), .B(n11), .C(state[1]), .Y(n4) );
  NAND2X1 U18 ( .A(state[2]), .B(n12), .Y(n14) );
  OR2X1 U19 ( .A(framing_error), .B(state[1]), .Y(n13) );
  NOR2X1 U20 ( .A(n12), .B(n11), .Y(load_buffer) );
  INVX1 U21 ( .A(state[2]), .Y(n11) );
  OR2X1 U22 ( .A(n8), .B(state[1]), .Y(n12) );
  INVX1 U23 ( .A(state[0]), .Y(n8) );
endmodule


module flex_counter_1 ( clk, n_rst, clear, count_enable, rollover_val, 
        count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n29, n30, n31, n32, n33, n1, n2, n3, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n34,
         n35;

  DFFSR \count_out_reg[0]  ( .D(n33), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(n32), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n31), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR rollover_flag_reg ( .D(n29), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  DFFSR \count_out_reg[3]  ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  INVX2 U8 ( .A(n18), .Y(n1) );
  OAI22X1 U9 ( .A(n2), .B(n3), .C(n9), .D(n10), .Y(n33) );
  OAI22X1 U10 ( .A(n3), .B(n11), .C(n10), .D(n12), .Y(n32) );
  OAI22X1 U11 ( .A(n3), .B(n13), .C(n14), .D(n10), .Y(n31) );
  INVX1 U12 ( .A(count_out[2]), .Y(n13) );
  OAI22X1 U13 ( .A(n3), .B(n15), .C(n16), .D(n10), .Y(n30) );
  INVX1 U14 ( .A(n17), .Y(n10) );
  INVX1 U15 ( .A(count_out[3]), .Y(n15) );
  OAI22X1 U16 ( .A(n3), .B(n18), .C(n19), .D(n20), .Y(n29) );
  NAND2X1 U17 ( .A(n21), .B(n22), .Y(n20) );
  XOR2X1 U18 ( .A(n16), .B(rollover_val[3]), .Y(n22) );
  XOR2X1 U19 ( .A(n23), .B(n24), .Y(n16) );
  NOR2X1 U20 ( .A(n25), .B(n26), .Y(n24) );
  NAND2X1 U21 ( .A(count_out[3]), .B(n18), .Y(n23) );
  XOR2X1 U22 ( .A(n14), .B(rollover_val[2]), .Y(n21) );
  XNOR2X1 U23 ( .A(n25), .B(n26), .Y(n14) );
  NAND2X1 U24 ( .A(count_out[2]), .B(n18), .Y(n26) );
  NAND3X1 U25 ( .A(n17), .B(n27), .C(n28), .Y(n19) );
  XOR2X1 U26 ( .A(n12), .B(rollover_val[1]), .Y(n28) );
  OAI21X1 U27 ( .A(n9), .B(n34), .C(n25), .Y(n12) );
  NAND2X1 U28 ( .A(n9), .B(count_out[1]), .Y(n25) );
  NOR2X1 U29 ( .A(rollover_flag), .B(n11), .Y(n34) );
  INVX1 U30 ( .A(count_out[1]), .Y(n11) );
  XOR2X1 U31 ( .A(rollover_val[0]), .B(n9), .Y(n27) );
  NOR2X1 U32 ( .A(n2), .B(n1), .Y(n9) );
  INVX1 U33 ( .A(count_out[0]), .Y(n2) );
  NOR2X1 U34 ( .A(n35), .B(clear), .Y(n17) );
  INVX1 U35 ( .A(rollover_flag), .Y(n18) );
  INVX1 U36 ( .A(n35), .Y(n3) );
  NOR2X1 U37 ( .A(count_enable), .B(clear), .Y(n35) );
endmodule


module flex_counter_0 ( clk, n_rst, clear, count_enable, rollover_val, 
        count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n1, n2, n3, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n34, n35, n36, n37, n38, n39;

  DFFSR \count_out_reg[0]  ( .D(n35), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(n36), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(n37), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR rollover_flag_reg ( .D(n39), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  DFFSR \count_out_reg[3]  ( .D(n38), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  OAI22X1 U8 ( .A(n1), .B(n2), .C(n3), .D(n9), .Y(n35) );
  OAI22X1 U9 ( .A(n2), .B(n10), .C(n9), .D(n11), .Y(n36) );
  OAI22X1 U10 ( .A(n2), .B(n12), .C(n13), .D(n9), .Y(n37) );
  INVX1 U11 ( .A(count_out[2]), .Y(n12) );
  OAI22X1 U12 ( .A(n2), .B(n14), .C(n15), .D(n9), .Y(n38) );
  INVX1 U13 ( .A(n16), .Y(n9) );
  INVX1 U14 ( .A(count_out[3]), .Y(n14) );
  OAI22X1 U15 ( .A(n2), .B(n17), .C(n18), .D(n19), .Y(n39) );
  NAND2X1 U16 ( .A(n20), .B(n21), .Y(n19) );
  XOR2X1 U17 ( .A(n15), .B(rollover_val[3]), .Y(n21) );
  XOR2X1 U18 ( .A(n22), .B(n23), .Y(n15) );
  NOR2X1 U19 ( .A(n24), .B(n25), .Y(n23) );
  NAND2X1 U20 ( .A(count_out[3]), .B(n17), .Y(n22) );
  XOR2X1 U21 ( .A(n13), .B(rollover_val[2]), .Y(n20) );
  XNOR2X1 U22 ( .A(n24), .B(n25), .Y(n13) );
  NAND2X1 U23 ( .A(count_out[2]), .B(n17), .Y(n25) );
  NAND3X1 U24 ( .A(n16), .B(n26), .C(n27), .Y(n18) );
  XOR2X1 U25 ( .A(n11), .B(rollover_val[1]), .Y(n27) );
  OAI21X1 U26 ( .A(n3), .B(n28), .C(n24), .Y(n11) );
  NAND2X1 U27 ( .A(n3), .B(count_out[1]), .Y(n24) );
  NOR2X1 U28 ( .A(rollover_flag), .B(n10), .Y(n28) );
  INVX1 U29 ( .A(count_out[1]), .Y(n10) );
  XOR2X1 U30 ( .A(rollover_val[0]), .B(n3), .Y(n26) );
  NOR2X1 U31 ( .A(n1), .B(rollover_flag), .Y(n3) );
  INVX1 U32 ( .A(count_out[0]), .Y(n1) );
  NOR2X1 U33 ( .A(n34), .B(clear), .Y(n16) );
  INVX1 U34 ( .A(rollover_flag), .Y(n17) );
  INVX1 U35 ( .A(n34), .Y(n2) );
  NOR2X1 U36 ( .A(count_enable), .B(clear), .Y(n34) );
endmodule


module timer ( clk, n_rst, enable_timer, shift_strobe, packet_done );
  input clk, n_rst, enable_timer;
  output shift_strobe, packet_done;


  flex_counter_1 flexc1 ( .clk(clk), .n_rst(n_rst), .clear(packet_done), 
        .count_enable(enable_timer), .rollover_val({1'b1, 1'b0, 1'b1, 1'b0}), 
        .rollover_flag(shift_strobe) );
  flex_counter_0 flexc2 ( .clk(clk), .n_rst(n_rst), .clear(packet_done), 
        .count_enable(shift_strobe), .rollover_val({1'b1, 1'b0, 1'b0, 1'b1}), 
        .rollover_flag(packet_done) );
endmodule


module rcv_block ( clk, n_rst, serial_in, data_read, rx_data, data_ready, 
        overrun_error, framing_error );
  output [7:0] rx_data;
  input clk, n_rst, serial_in, data_read;
  output data_ready, overrun_error, framing_error;
  wire   load_buff, sbc_cl, sbc_en, stop_b, shift_stro, start_bit_det,
         packet_do, enable_tim;
  wire   [7:0] pack_dat;

  rx_data_buff rx ( .clk(clk), .n_rst(n_rst), .load_buffer(load_buff), 
        .packet_data(pack_dat), .data_read(data_read), .rx_data(rx_data), 
        .data_ready(data_ready), .overrun_error(overrun_error) );
  stop_bit_chk sbc ( .clk(clk), .n_rst(n_rst), .sbc_clear(sbc_cl), 
        .sbc_enable(sbc_en), .stop_bit(stop_b), .framing_error(framing_error)
         );
  sr_9bit sr9 ( .clk(clk), .n_rst(n_rst), .shift_strobe(shift_stro), 
        .serial_in(serial_in), .packet_data(pack_dat), .stop_bit(stop_b) );
  start_bit_det sbd ( .clk(clk), .n_rst(n_rst), .serial_in(serial_in), 
        .start_bit_detected(start_bit_det) );
  rcu controlUnit ( .clk(clk), .n_rst(n_rst), .start_bit_detected(
        start_bit_det), .packet_done(packet_do), .framing_error(framing_error), 
        .sbc_clear(sbc_cl), .sbc_enable(sbc_en), .load_buffer(load_buff), 
        .enable_timer(enable_tim) );
  timer tim ( .clk(clk), .n_rst(n_rst), .enable_timer(enable_tim), 
        .shift_strobe(shift_stro), .packet_done(packet_do) );
endmodule

