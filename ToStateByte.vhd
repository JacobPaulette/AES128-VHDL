library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.Common.all;

library xil_defaultlib;
use xil_defaultlib.Common.all;

entity ToStateByte is port(
    in_state : in state;
    out_state : out state_byte
);
end ToStateByte;


architecture behavior of ToStateByte is
    signal s0 : column;
    signal s1 : column;
    signal s2 : column;
    signal s3 : column;
begin
    s0 <= in_state(0);
    s1 <= in_state(1);
    s2 <= in_state(2);
    s3 <= in_state(3);
    out_state(0 to 15) <= (s0(0), s0(1), s0(2), s0(3),
                            s1(0), s1(1), s1(2), s1(3),
                            s2(0), s2(1), s2(2), s2(3),
                            s3(0), s3(1), s3(2), s3(3));
end; 
