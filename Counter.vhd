-- A 4 bit counter that holds which position of the sequence
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Counter is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           rst : in STD_LOGIC;
           count : out UNSIGNED (3 downto 0)); -- The output
end Counter;

architecture Behavioral of Counter is

-- The internal signal for the counter
signal countInt : UNSIGNED(3 downto 0);
begin

-- The counter process
    CountProc: process (CLK)
    begin
        -- Synchronous counter
        if (rising_edge(CLK)) then
            -- Reset condition
            if (rst = '1') then
                countInt <= (others => '0');
            else 
                -- Only count on enable
                if (EN = '1') then
                    -- Only count up to 13
                    if (countInt = 13) then
                        countInt <= (others => '0');
                    else 
                        -- Count
                        countInt <= (countInt + 1);
                    end if;
                end if;
            end if;
        end if;
    end process CountProc;
count <= countInt;
end Behavioral;
