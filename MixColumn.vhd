library ieee;
use ieee.std_logic_1164.all;

entity MixColumn is port(
	x : in std_logic_vector(7 downto 0);
	y : out std_logic_vector(7 downto 0)
);
end MixColumn;

architecture behavior of MixColumn is
    signal test : std_logic_vector(7 downto 0);
    component mul2 port(
        x : in std_logic_vector(7 downto 0);
        y : out std_logic_vector(7 downto 0));
    end component;
begin
    mul2_example : mul2 port map (x => x, y => test);
	y <= test;
end;
