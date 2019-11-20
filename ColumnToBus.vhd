library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Common.all;

entity ColumnToBus is port(
    in_column : in column;
    out_bus : out std_logic_vector(31 downto 0)
);
end ColumnToBus;

architecture behavior of ColumnToBus is
begin
    out_bus(7 downto 0) <= in_column(0);
    out_bus(15 downto 8) <= in_column(1);
    out_bus(23 downto 16) <= in_column(2);
    out_bus(31 downto 24) <= in_column(3);
end;
