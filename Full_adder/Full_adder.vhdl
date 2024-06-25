-- design

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fulladd is
    Port ( a    : in  STD_LOGIC;      -- Input A
           b    : in  STD_LOGIC;      -- Input B
           cin  : in  STD_LOGIC;      -- Carry input
           sum  : out STD_LOGIC;      -- Sum output
           cout : out STD_LOGIC       -- Carry output
         );
end fulladd;

architecture Behavioral of fulladd is
begin
    process(a, b, cin)
    begin
        sum <= a xor b xor cin;           -- Sum calculation
        cout <= (a and b) or (b and cin) or (cin and a); -- Carry calculation
    end process;
end Behavioral;

-- testbench

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
end tb;

architecture Behavioral of tb is
    signal a, b, cin : STD_LOGIC := '0';  -- Input signals
    signal sum, cout : STD_LOGIC;         -- Output signals

    -- Component declaration for the fulladd module
    component fulladd
        Port ( a    : in  STD_LOGIC;
               b    : in  STD_LOGIC;
               cin  : in  STD_LOGIC;
               sum  : out STD_LOGIC;
               cout : out STD_LOGIC
             );
    end component;

begin

    -- Instantiate the fulladd module
    uut: fulladd port map (a => a, b => b, cin => cin, sum => sum, cout => cout);

    -- Stimulus process to generate test patterns
    stim_proc: process
        variable i : integer := 0;  -- Loop index for simulation
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

