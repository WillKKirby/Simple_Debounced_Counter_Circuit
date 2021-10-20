-- The 8-bit ROM to hold the first 14 fibonacci numbers
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
    Port ( 
         Address : in UNSIGNED (3 downto 0); -- The address to read
         Data : out STD_LOGIC_VECTOR (7 downto 0) ); -- The contents of ROM position ADDRESS
end ROM;

architecture Behavioral of ROM is

-- The contents of the ROM
type ROM_Array is array (0 to 13) of std_logic_vector(7 downto 0);
    constant Content: ROM_Array := (
    0 => B"00000000", -- 0
    1 => B"00000001", -- 1
    2 => B"00000001", -- 1
    3 => B"00000010", -- 2
    4 => B"00000011", -- 3
    5 => B"00000101", -- 5
    6 => B"00001000", -- 8
    7 => B"00001101", -- 13
    8 => B"00010101", -- 21
    9 => B"00100010", -- 34
    10 => B"00110111", --55
    11 => B"01011001", -- 89
    12 => B"10010000", -- 144
    13 => B"11101001" ); -- 233

begin

-- Assigns the correct value to the output
Data <= Content(to_integer(Address));

end Behavioral;
