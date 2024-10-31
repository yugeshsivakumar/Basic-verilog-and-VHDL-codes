-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bibuffer is
    Port ( A : inout STD_LOGIC;
           B : inout STD_LOGIC;
           ctrl : in STD_LOGIC);
end bibuffer;

architecture Behavioral of bibuffer is
begin
    process(A, B, ctrl)
    begin
        if ctrl = '1' then
            B <= A;
            A <= 'Z';
        else
            A <= B;
            B <= 'Z';
        end if;
    end process;
end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bibuffer_tb is
end bibuffer_tb;

architecture Behavioral of bibuffer_tb is
    signal A_tb, B_tb : STD_LOGIC;
    signal ctrl_tb : STD_LOGIC;
    signal temp_A, temp_B : STD_LOGIC;
begin
    -- Instantiate the bibuffer design
    DUT: entity work.bibuffer port map (A => A_tb, B => B_tb, ctrl => ctrl_tb);

    -- Test process to stimulate signals
    process
    begin
        ctrl_tb <= '1';
        temp_A <= '0';
        wait for 20 ns;
        temp_A <= '1';
        wait for 20 ns;
        
        ctrl_tb <= '0';
        temp_B <= '0';
        wait for 20 ns;
        temp_B <= '1';
        wait for 20 ns;

        wait;
    end process;

    -- Drive A_tb and B_tb based on ctrl_tb and temporary signals
    A_tb <= temp_A when ctrl_tb = '1' else 'Z';
    B_tb <= temp_B when ctrl_tb = '0' else 'Z';
end Behavioral;