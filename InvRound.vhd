library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.Common.all;

library xil_defaultlib;
use xil_defaultlib.Common.all;

entity InvRound is port(
    in_state : in state;
    RoundKey : in state_byte;
    out_state : out state
);
end InvRound;


architecture behavior of InvRound is
    signal state0 : state;
    signal state1 : state;
    signal state2 : state;

    component AddRoundKey is port(
        in_state : in state;
        RoundKey : in state_byte;
        out_state : out state);
    end component;

    component InvSubBytes is port(
        in_state : in state;
        out_state : out state);
    end component;

    component InvShiftRows is port(
        in_state : in state;
        out_state : out state);
    end component;

    component InvMixColumns is port(
        in_state : in state;
        out_state : out state);
    end component;

begin
    InvShiftRows0 : InvShiftRows port map(in_state => in_state, out_state => state0);
    InvSubBytes0 : InvSubBytes port map(in_state => state0, out_state => state1);
    AddRoundKey0 : AddRoundKey port map(in_state => state1, RoundKey => RoundKey, out_state => state2);
    InvMixColumns0 : InvMixColumns port map(in_state => state2, out_state => out_state);
end;
