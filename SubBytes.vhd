library ieee;
use ieee.std_logic_1164.all;
use work.Common.all;

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

    component sbox port(
        in_byte : in std_logic_vector(7 downto 0);
        out_byte : out std_logic_vector(7 downto 0));
    end component;
begin
    s0 <= in_state(0);
    s1 <= in_state(1);
    s2 <= in_state(2);
    s3 <= in_state(3);

    sbox0 : sbox port map(s0(0), sp0(0));
    sbox1 : sbox port map(s0(1), sp0(1));
    sbox2 : sbox port map(s0(2), sp0(2));
    sbox3 : sbox port map(s0(3), sp0(3));
    sbox4 : sbox port map(s1(0), sp1(0));
    sbox5 : sbox port map(s1(1), sp1(1));
    sbox6 : sbox port map(s1(2), sp1(2));
    sbox7 : sbox port map(s1(3), sp1(3));
    sbox8 : sbox port map(s2(0), sp2(0));
    sbox9 : sbox port map(s2(1), sp2(1));
    sbox10 : sbox port map(s2(2), sp2(2));
    sbox11 : sbox port map(s2(3), sp2(3));
    sbox12 : sbox port map(s3(0), sp3(0));
    sbox13 : sbox port map(s3(1), sp3(1));
    sbox14 : sbox port map(s3(2), sp3(2));
    sbox15 : sbox port map(s3(3), sp3(3));
    
    out_state(0) <= sp0;
    out_state(1) <= sp1;
    out_state(2) <= sp2;
    out_state(3) <= sp3;
end;

