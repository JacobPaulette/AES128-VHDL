library ieee;
use ieee.std_logic_1164.all;
--use work.Common.all;

library xil_defaultlib;
use xil_defaultlib.Common.all;

entity SubBytes is port(
    in_state : in state;
    out_state : out state
);
end SubBytes;

architecture behavior of SubBytes is
    signal s0 : column;
    signal s1 : column;
    signal s2 : column;
    signal s3 : column;

    signal sp0 : column;
    signal sp1 : column;
    signal sp2 : column;
    signal sp3 : column;

    component inv_sbox port(
        in_byte : in std_logic_vector(7 downto 0);
        out_byte : out std_logic_vector(7 downto 0));
    end component;
begin
    s0 <= in_state(0);
    s1 <= in_state(1);
    s2 <= in_state(2);
    s3 <= in_state(3);

    inv_sbox0 : inv_sbox port map(s0(0), sp0(0));
    inv_sbox1 : inv_sbox port map(s0(1), sp0(1));
    inv_sbox2 : inv_sbox port map(s0(2), sp0(2));
    inv_sbox3 : inv_sbox port map(s0(3), sp0(3));
    inv_sbox4 : inv_sbox port map(s1(0), sp1(0));
    inv_sbox5 : inv_sbox port map(s1(1), sp1(1));
    inv_sbox6 : inv_sbox port map(s1(2), sp1(2));
    inv_sbox7 : inv_sbox port map(s1(3), sp1(3));
    inv_sbox8 : inv_sbox port map(s2(0), sp2(0));
    inv_sbox9 : inv_sbox port map(s2(1), sp2(1));
    inv_sbox10 : inv_sbox port map(s2(2), sp2(2));
    inv_sbox11 : inv_sbox port map(s2(3), sp2(3));
    inv_sbox12 : inv_sbox port map(s3(0), sp3(0));
    inv_sbox13 : inv_sbox port map(s3(1), sp3(1));
    inv_sbox14 : inv_sbox port map(s3(2), sp3(2));
    inv_sbox15 : inv_sbox port map(s3(3), sp3(3));
    
    out_state(0) <= sp0;
    out_state(1) <= sp1;
    out_state(2) <= sp2;
    out_state(3) <= sp3;
end;

