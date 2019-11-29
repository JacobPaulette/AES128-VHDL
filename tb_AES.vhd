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
        enable : in std_logic);
    end component;

    signal input : std_logic_vector(15 downto 0);
    signal output : std_logic_vector(15 downto 0);
    signal clock : std_logic := '0';
    signal clear_L : std_logic := '1';
    signal enable : std_logic :='1';

    constant half_period : time := 500 ns;

begin
    clock <= not clock after half_period;

    AES0 : AES port map(
        input => input,
        output => output,
        clock => clock,
        clear_L => clear_L,
        enable => enable);

    --x"2B7E151628AED2A6ABF7158809CF4F3C";
    process
    begin
        input <= x"2B7E";
        wait for 2*half_period;
        input <= x"1516";
        wait for 2*half_period;
        input <= x"28AE";
        wait for 2*half_period;
        input <= x"D2A6";
        wait for 2*half_period;
        input <= x"ABF7";
        wait for 2*half_period;
        input <= x"1588";
        wait for 2*half_period;
        input <= x"09CF";
        wait for 2*half_period;
        input <= x"4F3C";
        wait for 9*half_period;
        wait;
    end process;
end;
