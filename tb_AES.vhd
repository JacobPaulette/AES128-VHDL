library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.Common.all;
library xil_defaultlib;
use xil_defaultlib.Common.all;



entity tb_AES is
end tb_AES;


architecture behavior of tb_AES is


    component AES is port(
        input : in std_logic_vector(15 downto 0);
        output : out std_logic_vector(15 downto 0);
        clock : in std_logic;
        clear_L : in std_logic;
        enable : in std_logic;
        EnotD : in std_logic);
    end component;

    signal input : std_logic_vector(15 downto 0);
    signal output : std_logic_vector(15 downto 0);
    signal clock : std_logic := '0';
    signal clear_L : std_logic := '1';
    signal enable : std_logic :='1';
    signal EnotD : std_logic := '0';

    constant half_period : time := 500 ns;

begin
    clock <= not clock after half_period;

    AES0 : AES port map(
        input => input,
        output => output,
        clock => clock,
        clear_L => clear_L,
        enable => enable,
        EnotD => EnotD);

    --x"2B7E151628AED2A6ABF7158809CF4F3C";

    --x"8610 18ef 8133 6a3b  21c9 ba1f 16dc cf87";
    process
    begin
        input <= x"8610";
        wait for 2*half_period;
        input <= x"18EF";
        wait for 2*half_period;
        input <= x"8133";
        wait for 2*half_period;
        input <= x"6A3B";
        wait for 2*half_period;
        input <= x"21C9";
        wait for 2*half_period;
        input <= x"BA1F";
        wait for 2*half_period;
        input <= x"16DC";
        wait for 2*half_period;
        input <= x"CF87";
        wait for 9*half_period;
        wait;
    end process;
end;
