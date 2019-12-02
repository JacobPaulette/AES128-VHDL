library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.Common.all;

library xil_defaultlib;
use xil_defaultlib.Common.all;

entity MixColumns is port(
    in_state : in state;
    out_state : out state
);
end MixColumns;

architecture behavior of MixColumns is
    component InvMixColumn port(
        x : in column;
        y : out column);
    end component;
begin
    Invmixcol0 : InvMixColumn port map(x => in_state(0), y => out_state(0));
    Invmixcol1 : InvMixColumn port map(x => in_state(1), y => out_state(1));
    Invmixcol2 : InvMixColumn port map(x => in_state(2), y => out_state(2));
    Invmixcol3 : InvMixColumn port map(x => in_state(3), y => out_state(3));
end;
        
