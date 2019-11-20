library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Common.all;

entity BusToBytes is port(
    in_state : in std_logic_vector(127 downto 0);
    out_state : out state_byte
);
end BusToBytes;


architecture bheavior of BusToBytes is
begin
    out_state(15) <= in_state(7 downto 0);
    out_state(14) <= in_state(15 downto 8);
    out_state(13) <= in_state(23 downto 16);
    out_state(12) <= in_state(31 downto 24);
    out_state(11) <= in_state(39 downto 32);
    out_state(10) <= in_state(47 downto 40);
    out_state(9) <= in_state(55 downto 48);
    out_state(8) <= in_state(63 downto 56);
    out_state(7) <= in_state(71 downto 64);
    out_state(6) <= in_state(79 downto 72);
    out_state(5) <= in_state(87 downto 80);
    out_state(4) <= in_state(95 downto 88);
    out_state(3) <= in_state(103 downto 96);
    out_state(2) <= in_state(111 downto 104);
    out_state(1) <= in_state(119 downto 112);
    out_state(0) <= in_state(127 downto 120);
end;

