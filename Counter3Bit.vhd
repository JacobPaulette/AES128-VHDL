library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.Common.all;
library xil_defaultlib;
use xil_defaultlib.Common.all;


entity Counter3Bit is port(
    clock : in std_logic;
    clear_L : in std_logic;
    count : out std_logic_vector(2 downto 0);
    enable : in std_logic
);
end Counter3Bit;

architecture behavior of Counter3Bit is

    signal state : std_logic_vector(2 downto 0) := "000";
begin
    
    count <= state;

    process(clock, clear_L)
    begin
        if clear_L = '0' then
            state <= "000";
        elsif (rising_edge(clock) and (enable = '1')) then
            state <= std_logic_vector(unsigned(state) + 1);
        end if;
    end process;
end;

