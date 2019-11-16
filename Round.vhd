library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Common.all;


entity Round is port(
    in_state : in state;
    RoundKey : in state_byte;
    out_state : out state
);
end Round;


architecture behavior of Round is
    signal state0 : state;
    signal state1 : state;
    signal state2 : state;

    component AddRoundKey is port(
        in_state : in state;
        RoundKey : in state_byte;
        out_state : out state);
    end component;

    component SubBytes is port(
        in_state : in state;
        out_state : out state);
    end component;

    component ShiftRows is port(
        in_state : in state;
        out_state : out state);
    end component;

    component MixColumns is port(
        in_state : in state;
        out_state : out state);
    end component;
begin
    SubBytes0 : SubBytes port map(in_state => in_state, out_state => state0);
    ShiftRows0 : ShiftRows port map(in_state => state0, out_state => state1);
    MixColumns0 : MixColumns port map(in_state => state1, out_state => state2);
    AddRoundKey0 : AddRoundKey port map(in_state => state2, RoundKey => RoundKey, out_state => out_state);
end;

