-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fsub is
    Port ( a      : in  STD_LOGIC;      -- Input A
           b      : in  STD_LOGIC;      -- Input B
           bin    : in  STD_LOGIC;      -- Borrow input
           diff   : out STD_LOGIC;      -- Difference output
           borrow : out STD_LOGIC       -- Borrow output
         );
end fsub;

architecture Behavioral of fsub is
begin
    process(a, b, bin)
    begin
        diff <= a xor b xor bin;                    -- Difference calculation
        borrow <= (not a and b) or (not a and bin) or (bin and b); -- Borrow calculation
    end process;
end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal a, b, bin : STD_LOGIC := '0';  -- Input signals
    signal diff, borrow : STD_LOGIC;      -- Output signals

    -- Component declaration for the fsub module
    component fsub
        Port ( a      : in  STD_LOGIC;
               b      : in  STD_LOGIC;
               bin    : in  STD_LOGIC;
               diff   : out STD_LOGIC;
               borrow : out STD_LOGIC
             );
    end component;

begin

    -- Instantiate the fsub module
    uut: fsub port map (a => a, b => b, bin => bin, diff => diff, borrow => borrow);

    -- Stimulus process to generate test patterns
    stim_proc: process
        variable i : integer := 0;  -- Loop index for simulation
    begin
        for i in 0 to 7 loop
            (a, b, bin) <= std_logic_vector(to_unsigned(i, 3)); -- Assign input combinations
            wait for 10 ns;
        end loop;
        
        -- Display the output
        report "Simulation finished.";
        wait;
    end process;

    -- Monitor process to display the signals
    monitor_proc: process
    begin
        wait for 1 ns;
        report "a = " & std_logic'image(a) & " b = " & std_logic'image(b) & " bin = " & std_logic'image(bin) & 
               " diff = " & std_logic'image(diff) & " borrow = " & std_logic'image(borrow);
        wait for 9 ns;
    end process;

end Behavioral;

