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
    signal mul9_0 : std_logic_vector(7 downto 0);
    signal mul9_1 : std_logic_vector(7 downto 0);
    signal mul9_2 : std_logic_vector(7 downto 0);
    signal mul9_3 : std_logic_vector(7 downto 0);
    signal mul11_0 : std_logic_vector(7 downto 0);
    signal mul11_1 : std_logic_vector(7 downto 0);
    signal mul11_2 : std_logic_vector(7 downto 0);
    signal mul11_3 : std_logic_vector(7 downto 0);
    signal mul13_0 : std_logic_vector(7 downto 0);
    signal mul13_1 : std_logic_vector(7 downto 0);
    signal mul13_2 : std_logic_vector(7 downto 0);
    signal mul13_3 : std_logic_vector(7 downto 0);
    signal mul14_0 : std_logic_vector(7 downto 0);
    signal mul14_1 : std_logic_vector(7 downto 0);
    signal mul14_2 : std_logic_vector(7 downto 0);
    signal mul14_3 : std_logic_vector(7 downto 0);


    component mul9 port(
        x : in std_logic_vector(7 downto 0);
        y : out std_logic_vector(7 downto 0));
    end component;

    component mul11 port(
        x : in std_logic_vector(7 downto 0);
        y : out std_logic_vector(7 downto 0));
    end component;


    component mul13 port(
        x : in std_logic_vector(7 downto 0);
        y : out std_logic_vector(7 downto 0));
    end component;

    component mul14 port(
        x : in std_logic_vector(7 downto 0);
        y : out std_logic_vector(7 downto 0));
    end component;
begin
    mul9_0_inst : mul9 port map(x => x(0), y => mul9_0);
    mul9_1_inst : mul9 port map(x => x(1), y => mul9_1);
    mul9_2_inst : mul9 port map(x => x(2), y => mul9_2);
    mul9_3_inst : mul9 port map(x => x(3), y => mul9_3);

    mul11_0_inst : mul11 port map(x => x(0), y => mul11_0);
    mul11_1_inst : mul11 port map(x => x(1), y => mul11_1);
    mul11_2_inst : mul11 port map(x => x(2), y => mul11_2);
    mul11_3_inst : mul11 port map(x => x(3), y => mul11_3);

    mul13_0_inst : mul13 port map(x => x(0), y => mul13_0);
    mul13_1_inst : mul13 port map(x => x(1), y => mul13_1);
    mul13_2_inst : mul13 port map(x => x(2), y => mul13_2);
    mul13_3_inst : mul13 port map(x => x(3), y => mul13_3);

    mul14_0_inst : mul14 port map(x => x(0), y => mul14_0);
    mul14_1_inst : mul14 port map(x => x(1), y => mul14_1);
    mul14_2_inst : mul14 port map(x => x(2), y => mul14_2);
    mul14_3_inst : mul14 port map(x => x(3), y => mul14_3);



    y(0) <= mul14_0 xor mul11_1 xor mul13_2 xor mul9_3;
    y(1) <= mul9_0 xor mul14_1 xor mul11_2 xor mul13_3;
    y(2) <= mul13_0 xor mul9_1 xor mul14_2 xor mul11_3;
    y(3) <= mul11_0 xor mul13_1 xor mul9_2 xor mul14_3;
end;
