library ieee;
use ieee.std_logic_1164.all;
--use work.Common.all;

library xil_defaultlib;
use xil_defaultlib.Common.all;

entity MixColumn is port(
    x : in column;
	y : out column
);
end MixColumn;

architecture behavior of MixColumn is
    signal mul2_0 : std_logic_vector(7 downto 0);
    signal mul2_1 : std_logic_vector(7 downto 0);
    signal mul2_2 : std_logic_vector(7 downto 0);
    signal mul2_3 : std_logic_vector(7 downto 0);
    signal mul3_0 : std_logic_vector(7 downto 0);
    signal mul3_1 : std_logic_vector(7 downto 0);
    signal mul3_2 : std_logic_vector(7 downto 0);
    signal mul3_3 : std_logic_vector(7 downto 0);
 
    component mul2 port(
        x : in std_logic_vector(7 downto 0);
        y : out std_logic_vector(7 downto 0));
    end component;

    component mul3 port(
        x : in std_logic_vector(7 downto 0);
        y : out std_logic_vector(7 downto 0));
    end component;
begin
    mul2_0_inst : mul2 port map(x => x(0), y => mul2_0);
    mul2_1_inst : mul2 port map(x => x(1), y => mul2_1);
    mul2_2_inst : mul2 port map(x => x(2), y => mul2_2);
    mul2_3_inst : mul2 port map(x => x(3), y => mul2_3);

    mul3_0_inst : mul3 port map(x => x(0), y => mul3_0);
    mul3_1_inst : mul3 port map(x => x(1), y => mul3_1);
    mul3_2_inst : mul3 port map(x => x(2), y => mul3_2);
    mul3_3_inst : mul3 port map(x => x(3), y => mul3_3);

    y(0) <= mul2_0 xor mul3_1 xor x(2) xor x(3);
    y(1) <= x(0) xor mul2_1 xor mul3_2 xor x(3);
    y(2) <= x(0) xor x(1) xor mul2_2 xor mul3_3;
    y(3) <= mul3_0 xor x(1) xor x(2) xor mul2_3;
end;
