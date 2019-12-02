library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.Common.all;

library xil_defaultlib;
use xil_defaultlib.Common.all;




entity Decipher is port(
    in_state : in state;
    RoundKeys : in RoundKeys;
    out_state : out state
);
end Decipher;

architecture behavior of Decipher is

    component AddRoundKey is port(
        in_state : in state;
        RoundKey : in state_byte;
        out_state : out state);
    end component;

    component InvRound is port(
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
    Round0 : InvRound port map(state0, RoundKeys(1), state1);
    Round1 : InvRound port map(state1, RoundKeys(2), state2);
    Round2 : InvRound port map(state2, RoundKeys(3), state3);
    Round3 : InvRound port map(state3, RoundKeys(4), state4);
    Round4 : InvRound port map(state4, RoundKeys(5), state5);
    Round5 : InvRound port map(state5, RoundKeys(6), state6);
    Round6 : InvRound port map(state6, RoundKeys(7), state7);
    Round7 : InvRound port map(state7, RoundKeys(8), state8);
    Round8 : InvRound port map(state8, RoundKeys(9), state9);

    --Final SubBytes, SHiftRows, and RoundKey
    InvShiftRows0 : InvShiftRows port map(state9, state10);
    InvSubBytes0 : SubBytes port map(state10, state11);
    FinalAddRoundKey : AddRoundKey port map(state11, RoundKeys(10), out_state);
end;

