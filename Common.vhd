library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


package Common is
    subtype BYTE is std_logic_vector(7 downto 0);
    type column is array (0 to 3) of BYTE;
    type state_byte is array (0 to 15) of BYTE;
    type state is array (0 to 3) of column;

end Common;
