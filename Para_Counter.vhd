-- Parameterizable Counter 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.DigEng.all;

entity Para_Counter is
    -- Counter Limit will be inhertited from Top 
    Generic ( LIMIT: natural := 25000000 );
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           rst : in STD_LOGIC;
           count : out UNSIGNED (LOG2(LIMIT)-1 downto 0)); -- The output
end Para_Counter;

architecture Behavioral of Para_Counter is

-- The internal signal for the counter
signal countInt : UNSIGNED (LOG2(LIMIT)-1 downto 0);
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
                    -- Logic for the Limit of the counter 
                    if (countInt = LIMIT-1) then
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
