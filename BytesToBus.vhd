library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Common.all;


entity BytesToBus is port(
    in_bytes : in state_byte;
    out_bus : out std_logic_vector(127 downto 0)
);
end BytesToBus;


architecture behavior of BytesToBus is
begin
    out_bus(7 downto 0) <= in_bytes(15);
    out_bus(15 downto 8) <= in_bytes(14);
    out_bus(23 downto 16)<= in_bytes(13);
    out_bus(31 downto 24)<= in_bytes(12);
    out_bus(39 downto 32) <= in_bytes(11);
    out_bus(47 downto 40) <= in_bytes(10);
    out_bus(55 downto 48) <= in_bytes(9);
    out_bus(63 downto 56) <= in_bytes(8);
    out_bus(71 downto 64) <= in_bytes(7);
    out_bus(79 downto 72) <= in_bytes(6);
    out_bus(87 downto 80) <= in_bytes(5);
    out_bus(95 downto 88) <= in_bytes(4);
    out_bus(103 downto 96) <= in_bytes(3);
    out_bus(111 downto 104) <= in_bytes(2);
    out_bus(119 downto 112) <= in_bytes(1);
    out_bus(127 downto 120) <= in_bytes(0);
end;
