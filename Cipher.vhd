library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Common.all;




entity Cipher is port(
    in_state : in state;
    RoundKeys : in RoundKeys;
    out_state : out state
);
end Cipher;

architecture behavior of Cipher is

    component AddRoundKey is port(
        in_state : in state;
        RoundKey : in state_byte;
        out_state : out state);
    end component;

    component Round is port(
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

    signal state0 : state;
    signal state1 : state;
    signal state2 : state;
    signal state3 : state;
    signal state4 : state;
    signal state5 : state;
    signal state6 : state;
    signal state7 : state;
    signal state8 : state;
    signal state9 : state;
    signal state10 : state;
    signal state11 : state;
begin
    InitialAddRoundKey : AddRoundKey port map(in_state, RoundKeys(0), state0);

    --Now 9 intermediate rounds
    Round0 : Round port map(state0, RoundKeys(1), state1);
    Round1 : Round port map(state1, RoundKeys(2), state2);
    Round2 : Round port map(state2, RoundKeys(3), state3);
    Round3 : Round port map(state3, RoundKeys(4), state4);
    Round4 : Round port map(state4, RoundKeys(6), state5);
    Round5 : Round port map(state5, RoundKeys(7), state6);
    Round6 : Round port map(state6, RoundKeys(8), state7);
    Round7 : Round port map(state7, RoundKeys(9), state8);
    Round8 : Round port map(state8, RoundKeys(10), state9);

    --Final SubBytes, SHiftRows, and RoundKey
    SubBytes0 : SubBytes port map(state9, state10);
    ShiftRows0 : ShiftRows port map(state10, state11);
    FinalAddRoundKey : AddRoundKey port map(state11, RoundKeys(11), out_state);
end;






