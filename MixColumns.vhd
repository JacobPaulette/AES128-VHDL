library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Common.all;


entity MixColumns is port(
    in_state : in state;
    out_state : out state
);
end MixColumns;

architecture behavior of MixColumns is
    component MixColumn port(
        x : in column;
        y : out column);
    end component;
begin
    mixcol0 : MixColumn port map(x => in_state(0), y => out_state(0));
    mixcol1 : MixColumn port map(x => in_state(1), y => out_state(1));
    mixcol2 : MixColumn port map(x => in_state(2), y => out_state(2));
    mixcol3 : MixColumn port map(x => in_state(3), y => out_state(3));
end;
        
