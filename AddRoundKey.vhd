library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.Common.all;

library xil_defaultlib;
use xil_defaultlib.Common.all;


entity AddRoundKey is port(
    in_state : in state;
    RoundKey : in state_byte;
    out_state : out state
);
end AddRoundKey;

architecture behavior of AddRoundKey is
    signal statebyte : state_byte;
    signal xor_state : state_byte;

    component ToStateByte port(
        in_state : in state;
        out_state : out state_byte);
    end component;

    component ToStateColumn port(
        in_state : in state_byte;
        out_state : out state);
    end component;

begin
    ToStateByte0 : ToStateByte port map(in_state => in_state, out_state => statebyte);
    ToStateColumn0 : ToStateColumn port map(in_state => xor_state, out_state => out_state);
    
    xor_state <= (statebyte(0) xor RoundKey(0), statebyte(1) xor RoundKey(1), statebyte(2) xor RoundKey(2), statebyte(3) xor RoundKey(3),
                  statebyte(4) xor RoundKey(4), statebyte(5) xor RoundKey(5), statebyte(6) xor RoundKey(6), statebyte(7) xor RoundKey(7),
                  statebyte(8) xor RoundKey(8), statebyte(9) xor RoundKey(9), statebyte(10) xor RoundKey(10), statebyte(11) xor RoundKey(11),
                  statebyte(12) xor RoundKey(12), statebyte(13) xor RoundKey(13), statebyte(14) xor RoundKey(14), statebyte(15) xor RoundKey(15));

end;
