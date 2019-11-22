library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.Common.all;

library xil_defaultlib;
use xil_defaultlib.Common.all;

entity ShiftRows is port(
    in_state : in state;
    out_state : out state
);
end ShiftRows;

architecture behavior of ShiftRows is
    signal s0 : column;
    signal s1 : column;
    signal s2 : column;
    signal s3 : column;

    signal sp0 : column;
    signal sp1 : column;
    signal sp2 : column;
    signal sp3 : column;
begin
    s0 <= in_state(0);
    s1 <= in_state(1);
    s2 <= in_state(2);
    s3 <= in_state(3);
    sp0(0) <= s0(0);
    sp1(0) <= s1(0);
    sp2(0) <= s2(0);
    sp3(0) <= s3(0);

    sp0(1) <= s1(1);
    sp1(1) <= s2(1);
    sp2(1) <= s3(1);
    sp3(1) <= s0(1);

    sp0(2) <= s2(2);
    sp1(2) <= s3(2);
    sp2(2) <= s0(2);
    sp3(2) <= s1(2);

    sp0(3) <= s3(3);
    sp1(3) <= s0(3);
    sp2(3) <= s1(3);
    sp3(3) <= s2(3);

    out_state(0) <= sp0;
    out_state(1) <= sp1;
    out_state(2) <= sp2;
    out_state(3) <= sp3;
end;
