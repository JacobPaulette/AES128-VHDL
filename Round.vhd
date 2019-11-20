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
    --conversions to other datatypes
    --BusToBytes0 : BusToBytes port map(in_state => in_state_bus, out_state => in_state_bytes);
    --ToStateColumn0 : ToStateColumn port map(in_state => in_state_bytes, out_state => in_state);
    --BusToBytes1 : BusToBytes port map(in_state => RoundKey_bus, out_state => RoundKey);


    --SubBytes0 : SubBytes port map(in_state => in_state, out_state => state0);
    --ShiftRows0 : ShiftRows port map(in_state => state0, out_state => state1);
    MixColumns0 : MixColumns port map(in_state => in_state, out_state => out_state);
    --AddRoundKey0 : AddRoundKey port map(in_state => state2, RoundKey => RoundKey, out_state => out_state);
end;
