library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.Common.all;

library xil_defaultlib;
use xil_defaultlib.Common.all;

entity ToStateColumn is port(
    in_state : in state_byte;
    out_state : out state
);
end ToStateColumn;


architecture behavior of ToStateColumn is
begin
    out_state(0) <= (in_state(0), in_state(1), in_state(2), in_state(3));
    out_state(1) <= (in_state(4), in_state(5), in_state(6), in_state(7));
    out_state(2) <= (in_state(8), in_state(9), in_state(10), in_state(11));
    out_state(3) <= (in_state(12), in_state(13), in_state(14), in_state(15));
end; 
