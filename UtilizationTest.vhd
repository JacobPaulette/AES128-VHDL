library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Common.all;



entity UtilizationTest is port(
    in_state : in std_logic_vector(127 downto 0);
    RoundKey : in std_logic_vector(127 downto 0);
    out_state : out std_logic_vector(127 downto 0)
);
end UtilizationTest;

architecture behavior of UtilizationTest is

    component RoundBus is port(
        in_state : in std_logic_vector(127 downto 0);
        RoundKey : in std_logic_vector(127 downto 0);
        out_state : out std_logic_vector(127 downto 0)
    );
    end component;
begin

end;




