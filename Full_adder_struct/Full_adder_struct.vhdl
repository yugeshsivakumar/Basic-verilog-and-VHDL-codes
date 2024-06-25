-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fa is
    Port ( a    : in  STD_LOGIC;          -- Input A
           b    : in  STD_LOGIC;          -- Input B
           cin  : in  STD_LOGIC;          -- Carry input
           sum  : out STD_LOGIC;          -- Sum output
           cout : out STD_LOGIC           -- Carry output
         );
end fa;

architecture Behavioral of fa is
    signal s1, s2, s3 : STD_LOGIC;        -- Intermediate signals
begin

    -- Instantiate the first half adder
    h1: entity work.ha port map(
        a => a,
        b => b,
        sum => s1,
        cout => s2
    );

    -- Instantiate the second half adder
    ha2: entity work.ha port map(
        a => s1,
        b => cin,
        sum => sum,
        cout => s3
    );

    -- Calculate the final carry output
    cout <= s2 or s3;

end Behavioral;


-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal a, b, cin : STD_LOGIC := '0';  -- Input signals
    signal sum, cout : STD_LOGIC;         -- Output signals

    -- Component declaration for the full adder module
    component fa
        Port ( a    : in  STD_LOGIC;
               b    : in  STD_LOGIC;
               cin  : in  STD_LOGIC;
               sum  : out STD_LOGIC;
               cout : out STD_LOGIC
             );
    end component;

begin

    -- Instantiate the full adder module
    uut: fa port map (a => a, b => b, cin => cin, sum => sum, cout => cout);

    -- Stimulus process to generate test patterns
    stim_proc: process
        variable i : integer := 0; -- Loop index for simulation
    begin
        for i in 0 to 7 loop
            (a, b, cin) <= std_logic_vector(to_unsigned(i, 3)); -- Assign input combinations
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
        report "a = " & std_logic'image(a) & " b = " & std_logic'image(b) & " cin = " & std_logic'image(cin) & 
               " sum = " & std_logic'image(sum) & " cout = " & std_logic'image(cout);
        wait for 9 ns;
    end process;

end Behavioral;
