-- design 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity halfadder is
    Port ( 
        a : in  std_logic;
        b : in  std_logic;
        sum : out  std_logic;
        carry : out  std_logic
    );
end halfadder;

architecture Behavioral of halfadder is
begin
    sum <= a xor b;
    carry <= a and b;
end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal a, b : std_logic;
    signal sum, carry : std_logic;
    constant CLK_PERIOD : time := 10 ns;  -- Simulation clock period

begin
    -- Stimulus process
    stim_proc: process
    begin
        a <= '0';
        b <= '0';
        wait for CLK_PERIOD;
        
        for i in 0 to 3 loop
            a <= std_logic(to_unsigned(i, a'length));
            for j in 0 to 3 loop
                b <= std_logic(to_unsigned(j, b'length));
                wait for CLK_PERIOD;
            end loop;
        end loop;
        
        wait;
    end process;

    -- Instance of halfadder
    ha_inst: entity work.halfadder
        port map (
            a => a,
            b => b,
            sum => sum,
            carry => carry
        );

    -- Monitor process
    monitor_proc: process
    begin
        wait for CLK_PERIOD;
        report "Time = " & integer'image(to_integer(unsigned(clock))) &
               " a = " & std_logic'image(a) &
               " b = " & std_logic'image(b) &
               " sum = " & std_logic'image(sum) &
               " carry = " & std_logic'image(carry);
        wait;
    end process;

end Behavioral;
