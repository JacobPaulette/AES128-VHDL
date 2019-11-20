library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Common.all;

entity BusToColumn is port(
    in_bus : in std_logic_vector(31 downto 0);
    out_column : out column
);
end BusToCOlumn;

architecture behavior of BusToCOlumn is
begin
    out_column(0) <= in_bus(7 downto 0);
    out_column(1) <= in_bus(15 downto 8);
    out_column(2) <= in_bus(23 downto 16);
    out_column(3) <= in_bus(31 downto 24);
end;
